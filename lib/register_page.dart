import 'package:flutter/material.dart';
import 'package:lapang_app/constant/dialog.dart';
import 'package:lapang_app/repository/user_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isVisible = false;

  TextEditingController namaCtl = TextEditingController();
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var kWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          allWidgets(kWidth),
        ],
      ),
    );
  }

  Widget allWidgets(kWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kWidth / 15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: kWidth / 2,
            ),
            Text(
              'Buat Akun',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: kWidth / 15,
              ),
            ),
            Text(
              'Silahkan isi semua kolom di bawah ini',
              style: TextStyle(
                fontSize: kWidth / 25,
              ),
            ),
            SizedBox(
              height: kWidth / 10,
            ),
            TextFormField(
              autofocus: false,
              controller: namaCtl,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                prefixIcon: Container(
                  margin: EdgeInsets.only(right: kWidth / 25),
                  height: kWidth / 10,
                  width: kWidth / 8,
                  child: Icon(
                    Icons.person,
                    fill: 1,
                    size: kWidth / 23,
                    color: Colors.black,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: kWidth / 20),
                hintStyle: TextStyle(fontSize: kWidth / 28),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Masukkan nama anda',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
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
            TextFormField(
              controller: usernameCtl,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Container(
                  margin: EdgeInsets.only(right: kWidth / 25),
                  height: kWidth / 10,
                  width: kWidth / 8,
                  child: Icon(
                    Icons.email,
                    fill: 1,
                    size: kWidth / 23,
                    color: Colors.black,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: kWidth / 20),
                hintStyle: TextStyle(fontSize: kWidth / 28),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Masukkan username anda',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
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
            TextFormField(
              controller: passwordCtl,
              autofocus: false,
              obscureText: isVisible,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Container(
                  margin: EdgeInsets.only(right: kWidth / 25),
                  height: kWidth / 10,
                  width: kWidth / 8,
                  child: Icon(
                    Icons.key,
                    fill: 1,
                    size: kWidth / 23,
                    color: Colors.black,
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: SizedBox(
                    height: kWidth / 10,
                    width: kWidth / 8,
                    child: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                      fill: 1,
                      size: kWidth / 23,
                      color: Colors.black,
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: kWidth / 20),
                hintStyle: TextStyle(fontSize: kWidth / 28),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Masukkan password anda',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kWidth / 10)),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
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
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kWidth / 40),
                  ),
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    showDialogLoading(kWidth, context);
                    UserRepository.register(context, namaCtl.text,
                        usernameCtl.text, passwordCtl.text);
                  }
                },
                child: Text(
                  'Buat Akun',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kWidth / 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
