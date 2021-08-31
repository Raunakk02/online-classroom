import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:online_classroom/objects/app_user.dart';

abstract class AppUserNetworks {
  // final _firestore = FirebaseFirestore.instance;
  static final _users = FirebaseFirestore.instance.collection('users');

  static Future<List<AppUser>> getUsers(List<String> uids) async {
    final _futures = uids.map((uid) => getUser(uid));
    return await Future.wait(_futures);
  }

  static Future<AppUser?> get user async {
    final _user = FirebaseAuth.instance.currentUser;
    if (_user == null) throw PlatformException(code: 'not-signed-in');
    return getUser(_user.uid);
  }

  static Future<void> assignDisplayNameToUser(String displayName) async{
    if(FirebaseAuth.instance.currentUser == null)
      return;
    await FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
  }

  static Future<AppUser> getUser(String uid) async {
    final snapshot = await _users.doc(uid).get();
    final data = snapshot.data();
    if (data == null) throw PlatformException(code: 'user-does-not-exist');
    return AppUser.fromJson(data);
  }

  static Future<void> upload(AppUser user) async {
    await _users.doc(user.uid).set(user.toJson());
  }

  static Future<void> addClassCodes(String uid, List<String> classCodes,
      [WriteBatch? batch]) async {
    final _doc = _users.doc(uid);
    final _updateValue = {
      'classCodes': FieldValue.arrayUnion(classCodes),
    };

    if (batch != null) return batch.update(_doc, _updateValue);

    await _doc.update(_updateValue);
  }

  static Future<void> removeClassCodes(String uid, List<String> classCodes,
      [WriteBatch? batch]) async {
    final _doc = _users.doc(uid);
    final _updateValue = {
      'classCodes': FieldValue.arrayRemove(classCodes),
    };

    if (batch != null) return batch.update(_doc, _updateValue);

    await _doc.update(_updateValue);
  }
}
