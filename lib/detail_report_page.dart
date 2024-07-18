import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lapang_app/constant/dialog.dart';
import 'package:lapang_app/constant/snackbar.dart';
import 'package:lapang_app/constant/url.dart';
import 'package:lapang_app/model/data.dart';
import 'package:lapang_app/repository/report_repository.dart';
import 'package:lapang_app/update_report_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailReportPage extends StatefulWidget {
  final String user;
  final Report report;
  const DetailReportPage({required this.user, required this.report, super.key});

  @override
  State<DetailReportPage> createState() => _DetailReportPageState();
}

class _DetailReportPageState extends State<DetailReportPage> {
  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.report.namaBarang,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          widget.user == widget.report.namaPelapor
              ? PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: kWidth / 20,
                  ),
                  onSelected: (String result) {
                    switch (result) {
                      case 'Edit':
                        widget.report.update == '0'
                            ? Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                return UpdateReportPage(report: widget.report);
                              })).then((_) => setState(() {}))
                            : GlobalSnackBar.show(context,
                                'Laporan sudah ditemukan tidak bisa diubah!');

                        break;
                      case 'Hapus':
                        showDialogConfirm(kWidth, widget.report.id);

                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit Laporan'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Hapus',
                      child: Text('Hapus Laporan'),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
      body: ListView(
        children: [
          allWidget(kWidth),
        ],
      ),
      floatingActionButton: widget.user == widget.report.namaPelapor &&
              widget.report.update == '0'
          ? FloatingActionButton.extended(
              backgroundColor: Colors.amber,
              label: Text(
                'Tandai Sudah Ditemukan',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: kWidth / 25,
                ),
              ),
              onPressed: () {
                showDialogLoading(kWidth, context);
                ReportRepository.updateStatusData(context, widget.report.id);
              },
            )
          : const SizedBox(),
    );
  }

  Widget allWidget(kWidth) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          kWidth / 20, kWidth / 20, kWidth / 20, kWidth / 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            '$urlServer/${widget.report.pathFoto!}',
            width: kWidth / 2,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: kWidth / 20,
          ),
          widget.report.update != '0'
              ? Container(
                  width: kWidth,
                  padding: EdgeInsets.all(kWidth / 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        kWidth / 40,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Update Laporan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: kWidth / 20,
                        ),
                      ),
                      SizedBox(
                        height: kWidth / 40,
                      ),
                      Divider(
                        color: Colors.black.withOpacity(.5),
                      ),
                      SizedBox(
                        height: kWidth / 40,
                      ),
                      Text(
                        'Sudah ditemukan',
                        style: TextStyle(
                          fontSize: kWidth / 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          SizedBox(
            height: kWidth / 20,
          ),
          Container(
            width: kWidth,
            padding: EdgeInsets.all(kWidth / 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  kWidth / 40,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.report.namaPelapor!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kWidth / 20,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMMM yyyy HH:mm', 'ID')
                          .format(DateTime.parse(widget.report.waktu!)),
                      style: TextStyle(
                        fontSize: kWidth / 25,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: kWidth / 40,
                ),
                Divider(
                  color: Colors.black.withOpacity(.5),
                ),
                SizedBox(
                  height: kWidth / 40,
                ),
                Text(
                  widget.report.kronologi,
                  style: TextStyle(
                    fontSize: kWidth / 20,
                  ),
                ),
                SizedBox(
                  height: kWidth / 40,
                ),
                Divider(
                  color: Colors.black.withOpacity(.5),
                ),
                SizedBox(
                  height: kWidth / 40,
                ),
                SizedBox(
                  width: kWidth,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      launchUrl(
                          Uri.parse('https://wa.me/${widget.report.nomor}'),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Text(
                      'Hubungi via WhatsApp',
                      style: TextStyle(
                        fontSize: kWidth / 22,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: kWidth,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      launchUrl(Uri(
                        scheme: 'tel',
                        path: widget.report.nomor,
                      ));
                    },
                    child: Text(
                      'Hubungi via Telepon',
                      style: TextStyle(
                        fontSize: kWidth / 22,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showDialogConfirm(kWidth, id) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width / 1.2,
                color: Colors.white,
                padding: EdgeInsets.all(kWidth / 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: kWidth / 60,
                    ),
                    Text(
                      'Apakah anda yakin menghapus laporan ini?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: kWidth / 23,
                      ),
                    ),
                    SizedBox(
                      height: kWidth / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: kWidth / 25,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          onPressed: () {
                            ReportRepository.deleteData(context, id).then((_) {
                              Navigator.pop(context);
                              setState(() {});
                            });
                          },
                          child: Text(
                            'Hapus',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: kWidth / 25,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
