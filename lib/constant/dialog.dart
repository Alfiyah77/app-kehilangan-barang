import 'package:flutter/material.dart';

void showDialogLoading(kWidth, context) {
  showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      Size size = MediaQuery.of(context).size;
      return Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width / 2,
              color: Colors.white,
              padding:
                  EdgeInsets.fromLTRB(kWidth / 20, 0, kWidth / 20, kWidth / 20),
              child: Column(
                children: [
                  SizedBox(
                    height: kWidth / 60,
                  ),
                  Text(
                    'Loading',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: kWidth / 20,
                    ),
                  ),
                  SizedBox(
                    height: kWidth / 20,
                  ),
                  const CircularProgressIndicator(),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
