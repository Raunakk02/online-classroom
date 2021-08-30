import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/components/components.dart';
import 'package:online_classroom/networks/class_group.dart';
import 'package:online_classroom/objects/objects.dart';
import 'package:online_classroom/utils/providers.dart';
import 'package:random_color/random_color.dart';
import '../utils/utils.dart';

class ClassesHomeList extends ConsumerStatefulWidget {
  const ClassesHomeList(this.user, {Key? key}) : super(key: key);
  final AppUser user;

  @override
  _ClassesHomeListState createState() => _ClassesHomeListState(user);
}

class _ClassesHomeListState extends ConsumerState<ClassesHomeList> {
  late Future<List<ClassGroup>> _classes;
  AppUser user;

  _ClassesHomeListState(this.user);

  @override
  void initState() {
    _classes = ClassNetworks.getClasses(user.classCodes);
    super.initState();
  }

  Future<void> updateList() async {
    user = await user.updateClassCodes();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _classes = ClassNetworks.getClasses(user.classCodes);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ClassGroup>>(
        future: _classes,
        builder: (context, snapshot) {
          return CommonAsyncSnapshotResponses(
            snapshot,
            builder: (List<ClassGroup> classes) {
              ref.read(classesProvider).value = classes;
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: classes.length,
                itemBuilder: (_, i) => InkWell(
                  borderRadius: Globals.kBorderRadius,
                  onTap: () {
                    Modular.to
                        .pushNamed(Routes.classScreen, arguments: classes[i]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(Globals.screenWidth * 0.03),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: Globals.screenWidth * 0.8,
                    height: Globals.screenWidth * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: Globals.kBorderRadius,
                      color: RandomColor().randomColor(
                        colorBrightness: ColorBrightness.dark,
                        colorSaturation: ColorSaturation.mediumSaturation,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(Globals.screenWidth * 0.03),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  classes[i].name,
                                  style: Globals.kHeading2Style,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  classes[i].sectionName,
                                  style: Globals.kBodyText1Style,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                Text(
                                  classes[i].teacher,
                                  style: Globals.kBodyText2Style,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) async {
                              bool _updateList = false;
                              String _message = '';
                              switch (value) {
                                case 'unenroll':
                                  await showDialog(
                                    context: context,
                                    builder: (_) => FutureDialog<void>(
                                      future: ClassNetworks.unenroll(
                                          user.uid, classes[i].classCode),
                                      autoClose: true,
                                    ),
                                  );
                                  _updateList = true;
                                  _message = 'Successfully unrolled form class';
                                  break;
                                case 'delete':
                                  await showDialog(
                                    context: context,
                                    builder: (_) => FutureDialog<void>(
                                      future: ClassNetworks.delete(classes[i]),
                                      autoClose: true,
                                    ),
                                  );
                                  _updateList = true;
                                  _message = 'Successfully deleted the class';
                                  break;
                              }
                              if (_updateList)
                                await showDialog(
                                  context: context,
                                  builder: (_) => FutureDialog<void>(
                                    future: updateList(),
                                    hasData: (_) => CommonAlertDialog(_message),
                                  ),
                                );
                            },
                            itemBuilder: (_) => [
                              if (classes[i].students.contains(user.uid))
                                PopupMenuItem(
                                  value: 'unenroll',
                                  child: Text('Unenroll'),
                                ),
                              if (classes[i].teacherUid == user.uid)
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
