import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_classroom/objects/classes_notifier.dart';

final classesProvider = ChangeNotifierProvider((ref) => ClassesNotifier());
