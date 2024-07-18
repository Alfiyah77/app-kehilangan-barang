import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lapang_app/home_page.dart';
import 'package:lapang_app/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: Colors.amber,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.amber,
          secondary: Colors.amber,
        ),
      ),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      home: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, prefs) {
              var dataPrefs = prefs.data;
              if (prefs.hasData) {
                if (dataPrefs!.getString('id') != null) {
                  return const HomePage(); // User Home Page
                } else {
                  return const LoginPage(); // Login Page
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                ); // Login Page
              }
            }),
      ),
    );
  }
}
