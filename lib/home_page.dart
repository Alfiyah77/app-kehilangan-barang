// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lapang_app/add_report_page.dart';
import 'package:lapang_app/constant/url.dart';
import 'package:lapang_app/detail_report_page.dart';
import 'package:lapang_app/login_page.dart';
import 'package:lapang_app/model/data.dart';
import 'package:lapang_app/repository/report_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddReportPage();
          })).then((_) {
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: const Text(
          'Laporan Kehilangan',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                showDialogConfirm(kWidth);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                searchBar(kWidth),
                SizedBox(
                  height: kWidth / 20,
                ),
                FutureBuilder(
                    future: ReportRepository.getData(searchText),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<Report> reportList = snapshot.data!;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: reportList.length,
                            itemBuilder: (context, index) {
                              return reportCard(kWidth, reportList[index]);
                            });
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Text('Belum ada laporan');
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget searchBar(kWidth) {
    return Padding(
      padding: EdgeInsets.all(kWidth / 20),
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: SizedBox(
            height: kWidth / 10,
            width: kWidth / 8,
            child: Icon(
              Icons.search,
              fill: 1,
              size: kWidth / 20,
              color: Colors.black,
            ),
          ),
          constraints:
              BoxConstraints(maxHeight: kWidth / 10, minHeight: kWidth / 10),
          contentPadding: EdgeInsets.only(left: kWidth / 20),
          hintStyle: TextStyle(fontSize: kWidth / 28),
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: 'Cari Laporan ...',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
            borderSide:
                BorderSide(color: Colors.black.withOpacity(.2), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(kWidth / 50)),
            borderSide:
                BorderSide(color: Colors.black.withOpacity(.2), width: 1.0),
          ),
        ),
        onChanged: (value) {
          if (value == '') {
            setState(() {
              searchText = '';
            });
          } else {
            setState(() {
              searchText = value;
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Harus diisi';
          }
          return null;
        },
      ),
    );
  }

  Widget lastUpdate(kWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kWidth / 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Data diperbarui 1 menit yang lalu',
            style:
                TextStyle(fontStyle: FontStyle.italic, fontSize: kWidth / 30),
          ),
        ],
      ),
    );
  }

  Widget reportCard(kWidth, Report report) {
    return InkWell(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailReportPage(
            report: report,
            user: prefs.getString('nama').toString(),
          );
        })).then((_) {
          setState(() {});
        });
      },
      child: Container(
        padding: EdgeInsets.all(kWidth / 20),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 2.0, color: Colors.grey.withOpacity(.5)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    '$urlServer/${report.pathFoto!}',
                    width: kWidth / 4,
                    height: kWidth / 4,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  width: kWidth / 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: Text(
                        report.namaBarang,
                        style: TextStyle(
                          fontSize: kWidth / 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: kWidth / 50,
                    ),
                    SizedBox(
                      child: Text(
                        report.namaPelapor!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: kWidth / 25,
                            color: Colors.black.withOpacity(.5)),
                      ),
                    ),
                    SizedBox(
                      height: kWidth / 50,
                    ),
                    SizedBox(
                      width: kWidth / 1.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(
                            DateFormat('dd MMMM yyyy HH:mm', 'ID')
                                .format(DateTime.parse(report.waktu!)),
                            style: TextStyle(
                                fontSize: kWidth / 25,
                                fontStyle: FontStyle.italic,
                                color: Colors.black.withOpacity(.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDialogConfirm(kWidth) {
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
                      'Apakah anda yakin ingin logout?',
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
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.clear();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (Route<dynamic> route) => false);
                          },
                          child: Text(
                            'Ya',
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
