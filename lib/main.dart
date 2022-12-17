import 'package:flutter/material.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:icici_staff_app/screens/Login.dart';
import 'package:icici_staff_app/screens/structure.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
          title: 'Staff App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: const ColorScheme.light()
                  .copyWith(primary: customcolor.orangelight),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(customcolor.white),
                      foregroundColor:
                          MaterialStateProperty.all(customcolor.orangelight),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(
                                  color: customcolor.orangelight, width: 2))),
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 11))))),
          home: screeen()),
    );
  }
}

class screeen extends StatefulWidget {
  @override
  State<screeen> createState() => _screeenState();
}

class _screeenState extends State<screeen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> is_inn;
  @override
  void initState() {
    super.initState();
    is_inn = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('isinside') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: is_inn,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return Structure();
          } else {
            return const login();
          }
        });
  }
}
