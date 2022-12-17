import 'dart:io';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icici_staff_app/screens/Login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class All_widgets {
  static Widget big_text(
    final String title,
    final String subtitle,
    final Size mq,
    BuildContext context,
  ) {
    return Container(
      // height: mq.height * 0.15,
      // width: mq.width * 0.05,
      // color: customcolor.orangelight,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: mq.height * 0.04,
            ),
            Text(title,
                softWrap: true,
                style: textstyleclass.heading(context).copyWith(
                    fontSize: ResponsiveFlutter.of(context).fontSize(5))),
            SizedBox(
              height: mq.height * 0.003,
            ),
            Text(subtitle,
                softWrap: true,
                style: textstyleclass.subtitle(context).copyWith(
                    fontSize: ResponsiveFlutter.of(context).fontSize(2))),
          ],
        ),
      ),
    );
  }

  static Future<bool> showToastMessage(message, BuildContext context) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orangeAccent,
        textColor: Colors.white,
        fontSize: ResponsiveFlutter.of(context).fontSize(1.8));
  }

  static Widget Loading_screen() {
    return const Center(
        child: AwesomeLoader(
      loaderType: AwesomeLoader.AwesomeLoader4,
      color: Colors.orange,
    ));
  }

  static expire_dialog(BuildContext context,{bool show}) {
    return show ==true? showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text('ICICI Lombard'),
              content: Text('Session expired. Please Login Again'),
              actions: [
                TextButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('isinside');
                      await prefs.remove('token');
                      prefs.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => login()),
                          (route) => false);
                    },
                    child: Text('ok')),
              ],
            )) :'name ';
  }
//  C5FEC159A98B4DCB88A35BD0CCFD36BF
  static Widget dropdown_stack_conateiner(
    //ALL WAYS USE THIS WIDGET UNDER POSITION CHILD
    bool is_visibility_list,
    List text_list,
    double width_s,
    double height_s,
    ValueSetter maincallback,
  ) {
    return Visibility(
        visible: is_visibility_list,
        child: Container(
          width: width_s,
          height: height_s,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            border: Border.all(
              color: customcolor.orangelight, // red as border color
            ),
          ),
          child: ListView.builder(
            itemCount: text_list.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(text_list[index]),
                onTap: () {
                  maincallback(index);
                },
              );
            }),
          ),
        ));
  }

  static void imagepop(BuildContext context, ValueSetter callback1) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("From where do you want to take photo"),
              actions: [
                TextButton(
                  onPressed: () {
                    pickImage(ImageSource.gallery, callback1);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Gallery"),
                ),
                TextButton(
                  onPressed: () {
                    pickImage(ImageSource.camera, callback1);

                    Navigator.of(context).pop();
                  },
                  child: const Text("Camera"),
                )
              ],
            ));
  }

  static pickImage(ImageSource imageSource, ValueSetter callback2) async {
    await ImagePicker().pickImage(source: imageSource).then((imgFile) async {
      if (imgFile == null) return;
      final imagtemppath = File(imgFile.path);
      callback2(imagtemppath);
    });
  }
}
//POSITION CONTEINER SPAIR 

  // Positioned(
                //     right: 0,
                //     top: 218,
                //     width: mq.width * 0.4,
                //     height: mq.height * 0.2,
                //     child: Visibility(
                //         visible: priority_dropdown,
                //         child: Container(
                //           // width: mq.width * 0.4,
                //           // height: mq.height * 0.2,
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: const BorderRadius.only(
                //               bottomLeft: Radius.circular(20.0),
                //               bottomRight: Radius.circular(20.0),
                //             ),
                //             border: Border.all(
                //               color: Colors.grey, // red as border color
                //             ),
                //           ),
                //           child: ListView.builder(
                //             itemCount: proority_name_list.length,
                //             itemBuilder: ((context, index) {
                //               return ListTile(
                //                 title: Text(proority_name_list[index]),
                //                 onTap: () {
                //                   setState(() {
                //                     prority_cltr.text =
                //                         proority_name_list[index];
                //                     priority_dropdown = false;
                //                     for (var i = 0;
                //                         i < proority_name_list.length;
                //                         i++) {
                //                       if (prority_cltr.text ==
                //                           proority_name_list[index]) {
                //                         priority_id = proority_id_list[index];
                //                         log(priority_id);
                //                       }
                //                     }
                //                   });
                //                 },
                //               );
                //             }),
                //           ),
                //         ))),
