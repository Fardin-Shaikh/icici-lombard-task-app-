import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:icici_staff_app/designe/loader.dart';
import 'package:icici_staff_app/designe/textfield.dart';
import 'package:icici_staff_app/models/m_login.dart';
import 'package:icici_staff_app/screens/WIDGETS.dart';
import 'package:icici_staff_app/screens/structure.dart';
import 'package:icici_staff_app/staticData/static_data.dart';

import 'package:http/http.dart' as http;
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';

class login extends StatefulWidget {
  const login({key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  Size mq;
  TextEditingController Employee_ID_cltr = TextEditingController();
  TextEditingController password_cltr = TextEditingController();
  EmpDetail Employe_detail;
  bool emplye_detail_bool = false;
  GlobalKey<FormState> login_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   final prefs = await SharedPreferences.getInstance();
      //   final bool is_inside = prefs.getBool('isinside');
      //   print(is_inside);
      // }),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: mq.height * 0.4,
              // alignment: Alignment.centerRight,
              // decoration: BoxDecoration(
              //     // color: Colors.grey[200],
              //     ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: double.infinity,
                        width: mq.width * 0.78,
                        // width: double.infinity,

                        decoration: const BoxDecoration(
                            // color: Colors.black,
                            image: DecorationImage(
                                image:
                                    AssetImage('lib/images/loginbg_orange.png'),
                                fit: BoxFit.fitHeight)),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset('lib/images/logo_blue.png'),
                  )
                ],
              ),
            ),
            //image is done
            Container(
              margin: EdgeInsets.all(18),
              height: mq.height * 0.45,
              width: double.infinity,
              decoration: BoxDecoration(
                  // color: Colors.green[300],
                  ),
              child: Form(
                key: login_key,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: mq.height * 0.13,
                      width: double.infinity,
                      // color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello,',
                              style: textstyleclass.heading(context)),
                          SizedBox(
                            height: mq.height * 0.01,
                          ),
                          Text(
                            'Login as a user to tack your daily tasks and activities',
                            style: textstyleclass.subtitle(context).copyWith(
                                fontSize: ResponsiveFlutter.of(context)
                                    .fontSize(1.8)),
                          ),
                        ],
                      ),
                    ),
                    all_textfields.textfield(
                      'Enter Employee ID',
                      fieldController: Employee_ID_cltr,
                      onchange: (value) {
                        print(Employee_ID_cltr.text);
                      },
                      validator: RequiredValidator(errorText: 'required'),
                    ),
                    SizedBox(
                      height: mq.height * 0.02,
                    ),
                    all_textfields.textfield(
                      'Enter Passwoard',
                      fieldController: password_cltr,
                      validator: RequiredValidator(errorText: 'required'),
                    ),
                    SizedBox(
                      height: mq.height * 0.05,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: mq.height * 0.08,
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      child: ElevatedButton(
                          onPressed: () {
                            if (login_key.currentState.validate()) {
                              login_fetch(Employee_ID_cltr.text.toString(),
                                      password_cltr.text.toString(), 'Login')
                                  .whenComplete(() {
                                if (Employe_detail.response.n == 1) {
                                  All_widgets.showToastMessage(
                                      Employe_detail.response.msg, context);
                                  log(Employe_detail.employeemodel.id
                                      .toString());
                                  sharpreffsave(
                                      Employe_detail.employeemodel.id
                                          .toString(),
                                      Employe_detail.employeemodel.firstName,
                                      Employe_detail.employeemodel.lastName,
                                      Employe_detail.employeemodel.profileImage,
                                      Employe_detail.employeemodel.role
                                          .toString(),
                                      Employe_detail.employeemodel.department
                                          .toString(),
                                      Employe_detail.employeemodel.designation
                                          .toString(),
                                      Employe_detail.employeemodel.createPermission
                                          .toString(),
                                      Employe_detail
                                          .employeemodel.assignPermission
                                          .toString(),
                                      Employe_detail
                                          .employeemodel.lastLoginTimeStamp,
                                      Employe_detail.token,
                                      true);
                                  //
                                  setState(() {});
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Structure()));
                                } else {
                                  All_widgets.showToastMessage(
                                      Employe_detail.response.msg, context);
                                }
                              });
                            }
                          },
                          child: const Text(
                            'Login',
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> login_fetch(String id, String pass, String api_name) async {
    final uri = Uri.http(api_data.URL1, api_data.URL2 + api_name);
    Utils(context).startLoading();
    final responce = await http.post(uri,
        headers: {'Apikey': api_data.api_key},
        body: {"EmployeeId": id, "Password": pass, "fcmNotificationId": " "});

    switch (responce.statusCode) {
      case 200:
        log(responce.body);
        setState(() {
          Employe_detail = EmpDetail.fromJson(jsonDecode(responce.body));
          Employe_detail == null
              ? emplye_detail_bool = false
              : emplye_detail_bool = true;
        });
        Utils(context).stopLoading();

        break;
      case 404:
        Utils(context).stopLoading();
        All_widgets.showToastMessage('404 occured', context);
        break;
      case 401:
        Utils(context).stopLoading();
        All_widgets.showToastMessage('unauthorized ', context);
        break;

      default:
        All_widgets.showToastMessage('Something went wrong ', context);
        Utils(context).stopLoading();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void sharpreffsave(
      String Id,
      String FirstName,
      String LastName,
      String ProfileImage,
      String Role_id,
      String Department_id,
      String Designation,
      String CreatePermission,
      String AssignPermission,
      String LastLoginTimeStamp,
      String Token,
      bool isinside) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', Id);
    await prefs.setString('fname', FirstName);
    await prefs.setString('lname', LastName);
    await prefs.setString('pimage', ProfileImage);
    await prefs.setString('role_id', Role_id);
    await prefs.setString('department_id', Department_id);
    await prefs.setString('designation', Designation);
    await prefs.setString('createp', CreatePermission);
    await prefs.setString('assignp', AssignPermission);
    await prefs.setString('lastlogintime', LastLoginTimeStamp);
    await prefs.setString('token', Token);
    await prefs.setBool('isinside', isinside);
  }
}
