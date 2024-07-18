import 'package:flutter/material.dart';
import 'package:lapang_app/constant/dialog.dart';
import 'package:lapang_app/register_page.dart';
import 'package:lapang_app/repository/user_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = false;
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
              height: kWidth / 3,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Lapang App',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 75, 55, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: kWidth / 15,
                    ),
                  ),
                  Text(
                    'Aplikasi Pelaporan Kehilangan',
                    style: TextStyle(
                      color: Colors.black.withOpacity(.5),
                      fontSize: kWidth / 25,
                    ),
                  ),
                  SizedBox(
                    height: kWidth / 8,
                  ),
                ],
              ),
            ),
            Text(
              'Silakan Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: kWidth / 15,
              ),
            ),
            SizedBox(
              height: kWidth / 20,
            ),
            TextFormField(
              controller: usernameCtl,
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
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
                    UserRepository.login(
                        context, usernameCtl.text, passwordCtl.text);
                  }
                },
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kWidth / 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RegisterPage();
                  }));
                },
                child: const Text(
                  'Belum punya akun? Daftar di sini',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
