import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Map<String, dynamic> userData = Map();

  

}