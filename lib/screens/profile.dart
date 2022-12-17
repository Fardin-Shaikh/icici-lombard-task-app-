import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:icici_staff_app/designe/textfield.dart';
import 'package:icici_staff_app/models/m_logout.dart';
import 'package:icici_staff_app/models/m_upload_image.dart';
import 'package:icici_staff_app/screens/Login.dart';
import 'package:icici_staff_app/screens/WIDGETS.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:icici_staff_app/staticData/static_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../designe/loader.dart';
import 'package:http/http.dart' as http;

import '../models/m_login.dart';
import '../staticData/internetcheck.dart';

class Profile extends StatefulWidget {
  const Profile({key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Size mq;
  bool isChecked_dark = false;
  bool isChecked_silent = false;
  LogoutUser logout_resp;
  bool logout_bool;
  EmpDetail empdetail_resp;
  bool empdetail_bool = false;
  TextEditingController email_cltr;
  TextEditingController mobileNo_cltr;
  TextEditingController department_cltr;
  TextEditingController designation_cltr;
  File profile_image;
  UploadProfile upload_resp;
  bool upload_bool = false;
  Uint8List bytes;

  @override
  void initState() {
    super.initState();

    CK.inst.internet(context, (value_internet) {
      if (value_internet) {
        employesdetails_fetch('EmployeeDetails').whenComplete(() {
          setState(() {
            if (empdetail_resp.response.n == 1) {
              convert_image(empdetail_resp.employeemodel.profileImage);
              //CONTROLLER VALUE ASSIGN
              email_cltr = TextEditingController(
                  text: empdetail_resp.employeemodel.emailId);
              mobileNo_cltr = TextEditingController(
                  text: empdetail_resp.employeemodel.mobileNo);
              department_cltr = TextEditingController(
                  text: empdetail_resp.employeemodel.iciciDepartmentName);
              designation_cltr = TextEditingController(
                  text: empdetail_resp.employeemodel.designationName);
            }
          });
        });
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
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: customcolor.orangelight)),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Are you sure want to log Out ?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                CK.inst.internet(context, (value_internet) {
                                  if (value_internet) {
                                    logout_fetch('Logout');
                                  }
                                });
                              },
                              child: const Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("No"),
                            )
                          ],
                        ));
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: customcolor.orangelight,
              ),
            )
          ],
        ),
        body: empdetail_bool
            ? main_data(empdetail_resp.employeemodel)
            : All_widgets.Loading_screen());
  }

  Widget main_data(Employeemodel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          Container(
            // color: Colors.green,
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: customcolor.orangelight,
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: customcolor.white,
                        child: CircleAvatar(
                          radius: 43,
                          backgroundImage: profile_image != null
                              ? FileImage(profile_image)
                              : const NetworkImage(
                                  'https://images.unsplash.com/photo-1648183185045-7a5592e66e9c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHByb2lmaWxlJTIwcGhvdG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -16,
                      left: 30,
                      child: FloatingActionButton.small(
                        elevation: 2,
                        backgroundColor: customcolor.white,
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: customcolor.orangelight,
                        ),
                        onPressed: () {
                          All_widgets.imagepop(context, (value) {
                            setState(() {
                              profile_image = value;
                              if (profile_image != null) {
                                Utils(context).startLoading();
                                upload_profile_image(profile_image)
                                    .whenComplete(() {
                                  Utils(context).stopLoading();
                                  All_widgets.showToastMessage(
                                      upload_resp.response.msg, context);
                                });
                              }
                            });
                          });
                          // setState(() {
                          //    String base64data =
                          //         "c3457bf0e5294300ac41f6a2c2e34b44";
                          //      bytes =
                          //         const Base64Decoder().convert(base64data);
                          // });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(width: mq.width * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mq.height * 0.04,
                    ),
                    SizedBox(
                      // color: Colors.red,
                      width: mq.width * 0.55,
                      child: Text('${data.firstName} ${data.lastName}',
                          softWrap: true,
                          style: textstyleclass.heading(context).copyWith(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(3))),
                    ),
                    SizedBox(
                      height: mq.height * 0.005,
                    ),
                    Text(data.employeeId,
                        softWrap: true,
                        style: textstyleclass.subtitle(context)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: mq.height * 0.03,
          ),
          Divider(
            color: Colors.grey,
            thickness: 0.9,
          ),
          // SizedBox(
          //   height: mq.height * 0.01,
          // ),
          show_tile(data.emailId, Icons.alternate_email_outlined, 'Email',
              field: all_textfields.textfield('No data ',
                  isEnabled: false, fieldController: email_cltr)),
          show_tile('+91 ${data.mobileNo ?? 'no data '}', Icons.phone_outlined,
              'Mobile',
              field: all_textfields.textfield('No data ',
                  isEnabled: false, fieldController: mobileNo_cltr)),
          show_tile(
              data.iciciDepartmentName, Icons.group_outlined, 'Department',
              field: all_textfields.textfield('No data ',
                  isEnabled: false, fieldController: department_cltr)),
          show_tile(data.designationName, Icons.person_outline_outlined,
              'Designation',
              field: all_textfields.textfield('No data ',
                  isEnabled: false, fieldController: designation_cltr)),
          // Divider(
          //   color: Colors.grey,
          //   thickness: 0.9,
          // ),
          SizedBox(
            height: mq.height * 0.03,
          ),
          togle_tile(Icons.dark_mode, 'Dark Mode', (value) {
            setState(() {
              isChecked_dark = value;
            });
          }, isChecked_dark),
          togle_tile(Icons.notifications_off_outlined, 'Silent Notifications',
              (value) {
            setState(() {
              isChecked_silent = value;
            });
          }, isChecked_silent),
        ],
      ),
    );
  }

  Widget show_tile(final String data, final IconData icon, final String label,
      {final TextFormField field}) {
    return ListTile(
        contentPadding: EdgeInsets.all(0),
        minLeadingWidth: 10,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Icon(
            icon,
            size: 33,
            color: customcolor.orangelight,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Text(label,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: ResponsiveFlutter.of(context).fontSize(1.8))),
        ),
        subtitle: field

        //  Text(
        //   data,
        //   style: textstyleclass.normal_bold(context).copyWith(
        //       fontWeight: FontWeight.normal,
        //       fontSize: ResponsiveFlutter.of(context).fontSize(2),
        //       color: Colors.black),
        // ),
        );
  }

  Widget togle_tile(final IconData icon, final String label,
      ValueSetter valuesetter, bool changevalue) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      minLeadingWidth: 10,
      leading: Icon(
        icon,
        size: 33,
        color: customcolor.orangelight,
      ),
      title: Text(label,
          style: textstyleclass.normal_bold(context).copyWith(
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveFlutter.of(context).fontSize(2.3))),
      trailing: Switch(
        activeTrackColor: customcolor.orangelight,
        activeColor: customcolor.orange,
        value: changevalue,
        onChanged: (value) {
          valuesetter(value);
        },
      ),
    );
  }

  Future<void> logout_fetch(String api_name) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    final uri =
        Uri.http(api_data.URL1, api_data.URL2 + api_name, {'EmployeeId': id});

    // Utils(context).startLoading();
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
          logout_resp = LogoutUser.fromJson(jsonDecode(responce.body));
          logout_resp == null ? logout_bool = false : logout_bool = true;
        });
        Utils(context).stopLoading();
        if (logout_resp.n == 1) {
          // ignore: use_build_context_synchronously
          All_widgets.showToastMessage(logout_resp.msg, context);
          final prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const login()),
              (route) => false);
        } else {
          All_widgets.showToastMessage(logout_resp.msg, context);
        }

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

  Future<void> employesdetails_fetch(String api_name) async {
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
          empdetail_resp = EmpDetail.fromJson(jsonDecode(responce.body));
          empdetail_resp == null
              ? empdetail_bool = false
              : empdetail_bool = true;
        });
        break;
      case 404:
        All_widgets.showToastMessage('404 occured', context);

        break;
      case 401:
        All_widgets.expire_dialog(context);
        break;

      default:
        All_widgets.showToastMessage('Something went wrong ', context);
    }
  }

  Future<void> upload_profile_image(File passed_img) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    final uri = Uri.http(
      api_data.URL1,
      api_data.URL2 + 'UploadProfile',
    );
    var body = {
      "EmployeeId": id,
      "FileName": passed_img.path.split("/").last,
      "Base64": base64Encode(File(passed_img.path).readAsBytesSync())
    };
    // log(body.toString());
    final responce = await http.post(uri,
        headers: {'Apikey': api_data.api_key, 'authToken': '${token}-${id}'},
        body: body);
    log(responce.body);

    setState(() {
      upload_resp = UploadProfile.fromJson(jsonDecode(responce.body));
    });
  }

  Future<void> convert_image(
    String doc_encp,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    final uri = Uri.http(api_data.URL1, 'file', {
      'token': '${token}-${id}',
      'docname': 'f0b4605578d243c88c0fecaf26edcc64',
      'extension': 'jpg',
      'isProfile': '0'
    });
    final responce = await http.get(
      uri,
      // headers: {'Apikey': api_data.api_key, 'authToken': '${token}-${id}'},
    );

    print('hereeeeeeeeeeeeeeeeeeeee');
    log(uri.toString());
    log(responce.statusCode.toString());
    print('ggggggggggggggggggggggg');
    print(responce.body);
  }

  //THIS FUNCITION FOR ERROR SHOW
  Future<void> upload_profile_image_OLD(File passed_img) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String id = prefs.getString('id');

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://' + api_data.URL1 + '/' + api_data.URL2 + 'UploadProfile'));
    log(request.url.toString());

    request.headers['Apikey'] = api_data.api_key;
    request.headers['authToken'] = token + '-' + id;
    request.fields['FileName'] = passed_img.path.split("/").last;
    request.fields['Base64'] =
        base64Encode(File(passed_img.path).readAsBytesSync()).toString();

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    log(response.body);
    // RESPONCE/
    //  {"Message":"The request entity's media type 'multipart/form-data' is not supported for this resource.","ExceptionMessage":"No MediaTypeFormatter is available to read an object of type 'EmployeeProfile' from content with media type 'multipart/form-data'.","ExceptionType":"System.Net.Http.UnsupportedMediaTypeException","StackTrace":"   at System.Net.Http.HttpContentExtensions.ReadAsAsync[T](HttpContent content, Type type, IEnumerable`1 formatters, IFormatterLogger formatterLogger, CancellationToken cancellationToken)\r\n   at System.Web.Http.ModelBinding.FormatterParameterBinding.ReadContentAsync(HttpRequestMessage request, Type type, IEnumerable`1 formatters, IFormatterLogger formatterLogger, CancellationToken cancellationToken)"}
  }
}
// http://icicicomplianceapi.onerooftechnologies.com/file?token=652EE043C1124F2CAE1BA1854E37B869-72&docname=f0b4605578d243c88c0fecaf26edcc64&extension=jpg&isProfile=0
// http://icicicomplianceapi.onerooftechnologies.com/api/v1/file?token=652EE043C1124F2CAE1BA1854E37B869-72&docname=f0b4605578d243c88c0fecaf26edcc64&extension=jpg&isProfile=0