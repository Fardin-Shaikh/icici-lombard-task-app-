import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:icici_staff_app/screens/WIDGETS.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icici_staff_app/staticData/static_data.dart';
import '../designe/loader.dart';
import 'package:http/http.dart' as http;

import '../models/m_notification.dart';
import '../staticData/internetcheck.dart';

class Notif extends StatefulWidget {
  const Notif({key});

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  Size mq;
  Notifi notif_resp;
  bool notif_bool = false;

  @override
  void initState() {
    super.initState();
    CK.inst.internet(context, (value_internet) {
      if (value_internet) {
        Notification_fetch('Notification');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: customcolor.back_white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined,
                color: customcolor.orangelight)),
      ),
      body: ListView(
        children: [
          All_widgets.big_text("Notification",
              'You have new notification to read.', mq, context),
          SizedBox(
            height: mq.height * 0.02,
          ),
          notif_bool
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'New Notifications',
                          style: textstyleclass.normal_bold(context).copyWith(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.3)),
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: notif_resp.getNotificationModelList.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                color: customcolor.back_white,
                              ),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 5),
                                minLeadingWidth: 1,
                                leading: const Icon(
                                  Icons.announcement_outlined,
                                  size: 28,
                                  color: customcolor.red_chip_front,
                                ),
                                title: Text(
                                  notif_resp.getNotificationModelList[index]
                                      .notification,
                                  style: textstyleclass
                                      .normal_bold(context)
                                      .copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(2),
                                        height: 1.2,
                                      ),
                                ),
                              ),
                            );
                          }))
                    ],
                  ),
                )
              : All_widgets.Loading_screen()
        ],
      ),
    );
  }

  Future<void> Notification_fetch(String api_name) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    final uri =
        Uri.http(api_data.URL1, api_data.URL2 + api_name, {'EmployeeId': id});

    final responce = await http.get(
      uri,
      headers: {'Apikey': api_data.api_key, 'authToken': '${token}-${id}'},
    );

    log(uri.toString());
    log(responce.statusCode.toString());

    switch (responce.statusCode) {
      case 200:
        log(responce.body);
        setState(() {
          notif_resp = Notifi.fromJson(jsonDecode(responce.body));
          notif_resp == null ? notif_bool = false : notif_bool = true;
        });

        break;
      case 404:
        All_widgets.showToastMessage('404 occured', context);
        Navigator.pop(context);
        break;
      case 401:
       
        All_widgets.expire_dialog(context);
        break;

      default:
        All_widgets.showToastMessage('Something went wrong ', context);
        Navigator.pop(context);
    }
  }
}
