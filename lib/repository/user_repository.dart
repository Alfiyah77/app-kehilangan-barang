import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lapang_app/constant/snackbar.dart';
import 'package:lapang_app/constant/url.dart';
import 'package:lapang_app/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static Future register(context, nama, username, password) async {
    Uri url = Uri.parse("$urlServer/register.php");

    try {
      var response = await post(
        url,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "username": username,
          "nama": nama,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        GlobalSnackBar.show(
            context, 'Selamat! Registrasi akun berhasil, silahkan login');
      } else {
        Navigator.pop(context);
        GlobalSnackBar.show(context, 'Registrasi gagal!');
      }
      return null;
    } catch (e) {
      Navigator.pop(context);
      GlobalSnackBar.show(context, e.toString());
    }
  }

  static Future login(context, username, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse("$urlServer/login.php");

    try {
      var response = await post(
        url,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "username": username,
          "password": password,
        },
      );

      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 && jsonResponse.isNotEmpty) {
        prefs.setString('id', jsonResponse[0]['id'].toString());
        prefs.setString('nama', jsonResponse[0]['nama'].toString());
        prefs.setString('username', jsonResponse[0]['username'].toString());

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pop(context);
        GlobalSnackBar.show(context, 'Username atau password salah!');
      }
      return null;
    } catch (e) {
      Navigator.pop(context);
      print(e.toString());

      GlobalSnackBar.show(context, e.toString());
    }
  }
}
