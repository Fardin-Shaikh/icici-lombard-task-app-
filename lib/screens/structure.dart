import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:icici_staff_app/screens/create_task.dart';
import 'package:icici_staff_app/screens/dashboard/dashboard.dart';
import 'package:icici_staff_app/screens/mytask/mytask.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Structure extends StatefulWidget {
  Structure({
    Key key,
  }) : super(key: key);

  @override
  _StructureState createState() => _StructureState();
}

class _StructureState extends State<Structure> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          final prefs = await SharedPreferences.getInstance();
          final String token = prefs.getString('token');
          print(token);

          // // log(is_inside.toString());
          // await prefs.clear();
        }),
      ),
      body: [Dashboard(), Create_task(), MyTask()].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_task),
              label: 'Create ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task_alt),
              label: 'Mytask',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: customcolor.orangelight,
          iconSize: 25,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
