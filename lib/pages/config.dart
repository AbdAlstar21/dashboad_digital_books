// ignore_for_file: non_constant_identifier_names, constant_identifier_names, avoid_print, duplicate_ignore, dead_code
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

const Color pcGrey = Color.fromARGB(255, 233, 226, 205);
const Color pcBlue = Color(0xff01aaef);
const Color pcWhite = Color(0xffffffff);
const Color pcBlack = Color(0xff000000);

Color? w = Colors.white;
Color? b = Colors.blue;
const double pfontt = 19;
const double pfontb = 17;

//for api

SharedPreferences? prefs;
const String token = "dnmnvzxtn2ddfhjhdsgfjsfbsajlarbsbmsbfsb5688";
const String api_path = "http://10.0.2.2:80/booksapp/api/";
const String images_path = "http://10.0.2.2:80/booksapp/images/";
const String files_path = "http://10.0.2.2:80/booksapp/files/";
const String files_path_in_app =
    "/storage/emulated/0/Android/data/com.example.digital_books/files/";

String G_user_id_val = "";

const String G_user_id = "user_id";
const String G_user_name = "user_name";
const String G_user_email = "user_email";
// const String G_user_image = "user_image";
// final String G_user_id = "user_id";
// final String G_user_id = "user_id";

Future<bool> checkConnection() async {
  try {
    return true;
    final result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print("connect");
      return true;
    } else {
      // ignore: avoid_print
      print("not connect");
      return false;
    }
  } on SocketException catch (_) {
    print("not connect");
    return false;
  }
}

//end for api
