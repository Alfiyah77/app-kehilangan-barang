import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lapang_app/constant/snackbar.dart';
import 'package:lapang_app/constant/url.dart';
import 'package:lapang_app/home_page.dart';
import 'package:lapang_app/model/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportRepository {
  static Future<List<Report>> getData(String search) async {
    Uri url = Uri.parse("$urlServer/get.php?search=$search");

    var response = await get(
      url,
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;
      return jsonResponse.map((i) => Report.createFromJson(i)).toList();
    }
    return [];
  }

  static Future addData(Report? report, context, XFile imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.parse("$urlServer/add.php");
    var request = MultipartRequest("POST", uri);

    var stream = ByteStream(imageFile.openRead());
    var length = await imageFile.length();

    var multipartFile =
        MultipartFile("image", stream, length, filename: imageFile.path);

    request.files.add(multipartFile);

    request.fields['namaPelapor'] = prefs.getString('nama')!;
    request.fields['namaBarang'] = report!.namaBarang;
    request.fields['kronologi'] = report.kronologi;
    request.fields['nomor'] = report.nomor;
    request.fields['waktu'] = report.waktu!;

    var response = await request.send();
    if (response.statusCode == 200) {
      GlobalSnackBar.show(context, 'Laporan berhasil dikirim');

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pop(context);
      GlobalSnackBar.show(context, 'Laporan gagal dikirim!');
    }
  }

  static Future updateData(Report? report, context, XFile? imageFile) async {
    var uri = Uri.parse("$urlServer/update.php");
    var request = MultipartRequest("POST", uri);

    if (imageFile != null) {
      var stream = ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      var multipartFile =
          MultipartFile("image", stream, length, filename: imageFile.path);

      request.files.add(multipartFile);
    } else {}

    request.fields['id'] = report!.id!;
    request.fields['namaBarang'] = report.namaBarang;
    request.fields['kronologi'] = report.kronologi;
    request.fields['nomor'] = report.nomor;
    request.fields['imageUrl'] = report.pathFoto!;

    var response = await request.send();
    if (response.statusCode == 200) {
      GlobalSnackBar.show(context, 'Laporan berhasil di-update');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pop(context);
      GlobalSnackBar.show(context, 'Laporan gagal di-update!');
    }
  }

  static Future deleteData(context, id) async {
    try {
      Response response = await post(
        Uri.parse("$urlServer/delete.php"),
        body: {
          "id": id,
        },
      );
      if (response.statusCode == 201) {
        Navigator.pop(context);
        GlobalSnackBar.show(context, 'Laporan berhasil dihapus');
      } else {
        GlobalSnackBar.show(
            context, 'Laporan gagal dihapus! Silahkan coba lagi');
      }
    } catch (e) {
      GlobalSnackBar.show(context, e.toString());
    }
  }

  static Future updateStatusData(context, id) async {
    try {
      Response response = await post(
        Uri.parse("$urlServer/update_status.php"),
        body: {
          "id": id,
        },
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        GlobalSnackBar.show(context, 'Update laporan berhasil!');
      } else {
        Navigator.pop(context);

        GlobalSnackBar.show(context, 'Update gagal! Silahkan coba lagi');
      }
    } catch (e) {
      GlobalSnackBar.show(context, e.toString());
    }
  }
}
