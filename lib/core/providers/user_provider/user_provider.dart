import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gotodo/data/models/user_model.dart';
import 'package:gotodo/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  User firebaseUser;
  UserModel userModel;

  setFirebaseUser({@required User user}) {
    firebaseUser = user;
    print('firebaseUser was set to: ${user.uid} ');
    notifyListeners();
  }

  setUserModel({@required UserEntity user}) {
    userModel = user;
    print('user was set to: ${user.username} ');
    notifyListeners();
  }
}
