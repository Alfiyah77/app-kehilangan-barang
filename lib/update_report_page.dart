import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lapang_app/constant/dialog.dart';
import 'package:lapang_app/constant/snackbar.dart';
import 'package:lapang_app/constant/url.dart';
import 'package:lapang_app/model/data.dart';
import 'package:lapang_app/repository/report_repository.dart';

class UpdateReportPage extends StatefulWidget {
  final Report report;
  const UpdateReportPage({required this.report, super.key});

  @override
  State<UpdateReportPage> createState() => _UpdateReportPageState();
}

class _UpdateReportPageState extends State<UpdateReportPage> {
  final ImagePicker imgpicker = ImagePicker();
  XFile? imagefile;

  TextEditingController namaBarangCtl = TextEditingController();
  TextEditingController kronologiCtl = TextEditingController();
  TextEditingController noHpCtl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  getImage() async {
    try {
      var pickedfile = await imgpicker.pickImage(
          imageQuality: 50, source: ImageSource.gallery);
      if (pickedfile != null) {
        imagefile = pickedfile;

        setState(() {});
      } else {
        debugPrint("No image is selected.");
      }
    } catch (e) {
      debugPrint("error while picking file.");
    }
    setState(() {});
  }

  clearImage() async {
    setState(() {
      imagefile = null;
    });
  }

  @override
  void initState() {
    namaBarangCtl = TextEditingController(text: widget.report.namaBarang);
    kronologiCtl = TextEditingController(text: widget.report.kronologi);
    noHpCtl = TextEditingController(text: widget.report.nomor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: const Text(
          'Edit Laporan Kehilangan',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          reportForm(kWidth),
        ],
      ),
    );
  }

  Widget reportForm(kWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kWidth / 20,
        vertical: kWidth / 15,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imagefile == null) ...{
              Padding(
                padding: EdgeInsets.only(bottom: kWidth / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Foto Barang',
                        style: TextStyle(
                            fontSize: kWidth / 25,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: kWidth / 99,
                    ),
                    Image.network(
                      '$urlServer/${widget.report.pathFoto}',
                      height: kWidth / 2,
                    ),
                    SizedBox(
                      height: kWidth / 99,
                    ),
                    TextButton(
                      onPressed: () {
                        getImage();
                        setState(() {});
                      },
                      child: const Text(
                        'Ganti Foto',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )
            } else if (imagefile != null) ...{
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Foto Barang',
                    style: TextStyle(
                        fontSize: kWidth / 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: kWidth / 99,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: kWidth / 20),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                              BorderRadius.all(Radius.circular(kWidth / 50))),
                      width: kWidth / 1.15,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kWidth / 20, vertical: kWidth / 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: kWidth / 5,
                                  width: kWidth / 5,
                                  child: Image.file(File(imagefile!.path)),
                                ),
                                SizedBox(
                                  width: kWidth / 3,
                                  child: Text(
                                    imagefile!.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(fontSize: kWidth / 25),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  clearImage();
                                  setState(() {});
                                },
                                child: const Text("Hapus"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            },
            Padding(
              padding: EdgeInsets.symmetric(vertical: kWidth / 25),
              child: Text(
                "Nama Barang",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: kWidth / 25),
              ),
            ),
            TextFormField(
              controller: namaBarangCtl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: kWidth / 20),
                hintStyle: TextStyle(fontSize: kWidth / 28),
                filled: true,
                fillColor: Colors.grey.shade100,
                hintText: 'Masukkan nama barang yang hilang',
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Harus diisi';
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: kWidth / 25),
              child: Text(
                "Kronologi",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: kWidth / 25),
              ),
            ),
            TextFormField(
              controller: kronologiCtl,
              keyboardType: TextInputType.text,
              maxLines: 6,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(kWidth / 20),
                hintStyle: TextStyle(fontSize: kWidth / 28),
                filled: true,
                fillColor: Colors.grey.shade100,
                hintText: 'Ceritakan dimana dan kapan terjadinya barang hilang',
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Harus diisi';
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: kWidth / 25),
              child: Text(
                "Nomor HP yang bisa dihubungi",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: kWidth / 25),
              ),
            ),
            TextFormField(
              controller: noHpCtl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(kWidth / 20),
                hintStyle: TextStyle(fontSize: kWidth / 28),
                filled: true,
                fillColor: Colors.grey.shade100,
                hintText: 'Masukkan nomor HP kamu',
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Harus diisi';
                }
                return null;
              },
            ),
            SizedBox(
              height: kWidth / 20,
            ),
            SizedBox(
              width: kWidth,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    showDialogLoading(kWidth, context);
                    ReportRepository.updateData(
                        Report(
                            id: widget.report.id,
                            namaBarang: namaBarangCtl.text,
                            kronologi: kronologiCtl.text,
                            nomor: noHpCtl.text,
                            pathFoto: widget.report.pathFoto,
                            update: '1'),
                        context,
                        // ignore: unnecessary_null_in_if_null_operators
                        imagefile ?? null);
                  } else {
                    GlobalSnackBar.show(context,
                        'Pastikan terdapat foto dan data terisi semua');
                  }
                },
                child: Text(
                  'Kirim',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: kWidth / 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
