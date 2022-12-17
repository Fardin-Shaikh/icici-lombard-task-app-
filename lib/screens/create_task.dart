import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:icici_staff_app/designe/textfield.dart';
import 'package:icici_staff_app/models/m_mytask.dart';
import 'package:icici_staff_app/models/m_state.dart';
import 'package:icici_staff_app/models/priority_m.dart';
import 'package:icici_staff_app/screens/Login.dart';
import 'package:icici_staff_app/screens/WIDGETS.dart';
import 'package:icici_staff_app/screens/profile.dart';
import 'package:icici_staff_app/staticData/internetcheck.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:icici_staff_app/staticData/static_data.dart';
import '../models/m_assignhead.dart';
import '../models/m_departlist.dart';
import 'package:intl/src/intl/date_format.dart';

import '../models/post_createtask.dart';

class Create_task extends StatefulWidget {
  final TaskList passed_data;
  final bool fillcontrollers;
  const Create_task({Key key, this.fillcontrollers, this.passed_data})
      : super(key: key);

  @override
  State<Create_task> createState() => Create_taskState();
}

class Create_taskState extends State<Create_task> {
  Size mq;
  TextEditingController title_cltr; //= TextEditingController();
  TextEditingController description_cltr = TextEditingController();
  TextEditingController due_date_cltr = TextEditingController();
  TextEditingController prority_cltr = TextEditingController();
  TextEditingController department_cltr = TextEditingController();
  TextEditingController assigntask_cltr = TextEditingController();
  TextEditingController state_cltr = TextEditingController();
  TextEditingController title2_cltr = TextEditingController();
  TextEditingController due_date2_cltr = TextEditingController();
  TextEditingController role_cltr = TextEditingController();
  TextEditingController assigntask2_cltr = TextEditingController();
  bool is_subtask_visible = false;

  ///RESPONCE VARIABLES
  Priority priority_resp;
  Departlist departmnet_resp;
  Statemodel state_resp;
  Assignhead assignhead_resp;
  Createtask_post create;
  //SAVE LIST VARIABLE
  List<String> proority_name_list = [];
  List<String> proority_id_list = [];
  List<String> department_name_list = [];
  List<String> department_id_list = [];
  List<String> state_name_list = [];
  List<String> state_id_list = [];
  List<String> assignhead_name_list = [];
  List<String> assignhead_id_list = [];

  //SHOW DROP DOWN VARIABLE
  bool priority_dropdown = false;
  bool department_dropdown = false;
  bool state_dropdown = false;
  bool assignhead_dropdown = false;
  //CONTAINEING VALUE VARIABLES
  String priority_id;
  String department_id;
  String state_id;
  String assignehead_id;
  String picked_date;
  File _image;
  //Upload in body variable
  List<Map<String, String>> image_list = [];
  List<JsonEncoder> image_encorder_list = [];
  String img64;
  List<Map<String, dynamic>> filejson = [];
  List<File> uploadfilepath = [];

  @override
  void initState() {
    super.initState();
    CK.inst.internet(context, (value) {
      if (value) {
        fetch_all_apis();
      }
    });
    if (widget.fillcontrollers == true) {
      log('sdfgjkjksdfghjkl');
      title_cltr = TextEditingController(text: widget.passed_data.taskTitle);
      description_cltr =
          TextEditingController(text: widget.passed_data.taskDescription);
      due_date_cltr =
          TextEditingController(text: widget.passed_data.taskDueDate);
      prority_cltr =
          TextEditingController(text: widget.passed_data.taskPriorityName);
      department_cltr = TextEditingController(
          text: widget.passed_data.taskDepartmentTypeName);
      state_cltr = TextEditingController(text: widget.passed_data.stateName);
      assigntask_cltr =
          TextEditingController(text: widget.passed_data.assignToName);
      // print(widget.passed_data.taskTitle);
      // £££££££££££££££££££££££££££
      //// check null valus e have being passed and tried TExtediting contolller
      // setState(() {
      //   // title_cltr = TextEditingController(text: widget.passed_data.taskTitle);
      // });
    }
  }

  void fetch_all_apis() {
    lists_fetch('TaskPriority', (value) {
      priority_resp = Priority.fromJson(jsonDecode(value));
    }).whenComplete(() => {
          setState(
            () {
              if (priority_resp.response.n == 1) {
                proority_name_list = List<String>.generate(
                    priority_resp.taskPrioritymodellList.length,
                    (index) => priority_resp
                        .taskPrioritymodellList[index].taskPriorityName);
                proority_id_list = List<String>.generate(
                    priority_resp.taskPrioritymodellList.length,
                    (index) => priority_resp.taskPrioritymodellList[index].id
                        .toString());

                log(proority_name_list.toString());
                log(proority_id_list.toString());
              }
            },
          )
        });

    lists_fetch('TaskDepartmentTypeList', (value) {
      departmnet_resp = Departlist.fromJson(jsonDecode(value));
    }).whenComplete(() => {
          setState(
            () {
              if (departmnet_resp.response.n == 1) {
                department_name_list = List<String>.generate(
                    departmnet_resp.taskdepartmenttypeslist.length,
                    (index) => departmnet_resp
                        .taskdepartmenttypeslist[index].taskDepartmentTypeName);
                department_id_list = List<String>.generate(
                    departmnet_resp.taskdepartmenttypeslist.length,
                    (index) => departmnet_resp.taskdepartmenttypeslist[index].id
                        .toString());

                log(department_name_list.toString());
                log(department_id_list.toString());
              }
            },
          )
        });
    lists_fetch('GetStateList', (value) {
      state_resp = Statemodel.fromJson(jsonDecode(value));
    }).whenComplete(() => {
          setState(
            () {
              if (state_resp.response.n == 1) {
                state_name_list = List<String>.generate(
                    state_resp.statelist.length,
                    (index) => state_resp.statelist[index].stateName);
                state_id_list = List<String>.generate(
                    state_resp.statelist.length,
                    (index) => state_resp.statelist[index].id.toString());

                log(state_name_list.toString());
                log(state_id_list.toString());
              }
            },
          )
        });
    lists_fetch('AssignableRole', (value) {
      assignhead_resp = Assignhead.fromJson(jsonDecode(value));
    }, enable_rolehead: true)
        .whenComplete(() => {
              setState(
                () {
                  if (assignhead_resp.response.n == 1) {
                    assignhead_name_list = List<String>.generate(
                        assignhead_resp.rolemodelList.length,
                        (index) =>
                            assignhead_resp.rolemodelList[index].roleName);
                    assignhead_id_list = List<String>.generate(
                        assignhead_resp.rolemodelList.length,
                        (index) =>
                            assignhead_resp.rolemodelList[index].id.toString());

                    log(assignhead_name_list.toString());
                    log(assignhead_id_list.toString());
                  }
                },
              )
            });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: customcolor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: customcolor.back_white,
        toolbarHeight: 200,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1648183185045-7a5592e66e9c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHByb2lmaWxlJTIwcGhvdG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
            ),
          ),
        ),
      ),
      body: main_widget(),
    );
  }

  Widget main_widget() {
    // print(widget.passed_data.taskTitle);
    return ListView(
      children: [
        widget.fillcontrollers != true
            ? All_widgets.big_text('Create Task',
                'Create task timeline and assign to team', mq, context)
            : All_widgets.big_text('Update Task',
                'Update task timeline and assign to team', mq, context),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                all_field_column(),
                Positioned(
                  right: 0,
                  top: 218,
                  child: All_widgets.dropdown_stack_conateiner(
                    priority_dropdown,
                    proority_name_list,
                    mq.width * 0.4,
                    mq.height * 0.2,
                    (index) {
                      setState(() {
                        prority_cltr.text = proority_name_list[index];
                        priority_dropdown = false;
                        for (var i = 0; i < proority_name_list.length; i++) {
                          if (prority_cltr.text == proority_name_list[index]) {
                            priority_id = proority_id_list[index];
                            log(priority_id);
                          }
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 290,
                  child: All_widgets.dropdown_stack_conateiner(
                    department_dropdown,
                    department_name_list,
                    mq.width * 0.4,
                    mq.height * 0.2,
                    (index) {
                      setState(() {
                        department_cltr.text = department_name_list[index];
                        department_dropdown = false;
                        for (var i = 0; i < department_name_list.length; i++) {
                          if (department_cltr.text ==
                              department_name_list[index]) {
                            department_id = department_id_list[index];
                            log(department_id);
                          }
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 360,
                  child: All_widgets.dropdown_stack_conateiner(
                    state_dropdown,
                    state_name_list,
                    mq.width * 0.4,
                    mq.height * 0.2,
                    (index) {
                      setState(() {
                        state_cltr.text = state_name_list[index];
                        state_dropdown = false;
                        for (var i = 0; i < state_name_list.length; i++) {
                          if (state_cltr.text == state_name_list[index]) {
                            state_id = state_id_list[index];
                            log(state_id);
                          }
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 435,
                  child: All_widgets.dropdown_stack_conateiner(
                    assignhead_dropdown,
                    assignhead_name_list,
                    mq.width * 0.4,
                    mq.height * 0.2,
                    (index) {
                      setState(() {
                        assigntask_cltr.text = assignhead_name_list[index];
                        assignhead_dropdown = false;
                        for (var i = 0; i < assignhead_name_list.length; i++) {
                          if (assigntask_cltr.text ==
                              assignhead_name_list[index]) {
                            assignehead_id = assignhead_id_list[index];
                            log(assignehead_id);
                          }
                        }
                      });
                    },
                  ),
                )
              ],
            ))
      ],
    );
  }

  Widget all_field_column() {
    return Column(
      children: [
        SizedBox(height: mq.height * 0.03),
        all_textfields.textfield(
          'Enter Title',
          fieldController: title_cltr,
        ),
        SizedBox(height: mq.height * 0.03),
        all_textfields.textfield('Enter Description',
            fieldController: description_cltr),
        SizedBox(height: mq.height * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: mq.width * 0.4,
              child: all_textfields.textfield(
                'Enter Due Date',
                suffixicon: const Icon(
                  Icons.calendar_today_rounded,
                  color: customcolor.orangelight,
                ),
                fieldController: due_date_cltr,
                isreadOnly: true,
                ontap_callback: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  log(picked_date.toString());
                  setState(() {
                    due_date_cltr.text = DateFormat("d MMM y ").format(date);
                    picked_date = DateFormat("d MMM y 5:00").format(date);
                  });
                  print(picked_date);
                },
              ),
            ),
            SizedBox(
                width: mq.width * 0.4,
                child: all_textfields.textfield(
                  'Set Prority',
                  suffixicon: Icon(
                      priority_dropdown
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: customcolor.dark_grey_icons),
                  fieldController: prority_cltr,
                  isreadOnly: true,
                  ontap_callback: () {
                    setState(() {
                      priority_dropdown = !priority_dropdown;
                    });
                  },
                )),
          ],
        ),
        SizedBox(height: mq.height * 0.03),
        all_textfields.textfield('Select Department',
            suffixicon: Icon(
                department_dropdown
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: customcolor.dark_grey_icons),
            fieldController: department_cltr,
            isreadOnly: true, ontap_callback: () {
          setState(() {
            department_dropdown = !department_dropdown;
          });
        }),
        SizedBox(height: mq.height * 0.03),
        all_textfields.textfield('State',
            suffixicon: Icon(
                state_dropdown
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: customcolor.dark_grey_icons),
            fieldController: state_cltr,
            isreadOnly: true, ontap_callback: () {
          setState(() {
            state_dropdown = !state_dropdown;
          });
        }),
        SizedBox(height: mq.height * 0.03),
        all_textfields.textfield('Assign Task Head',
            suffixicon: Icon(
                assignhead_dropdown
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: customcolor.dark_grey_icons),
            fieldController: assigntask_cltr,
            isreadOnly: true, ontap_callback: () {
          setState(() {
            assignhead_dropdown = !assignhead_dropdown;
          });
        }),
        SizedBox(height: mq.height * 0.03),
        Container(
          // height: mq.height * 0.06,
          width: double.infinity,
          //  color: Colors.red,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Attachments',
                    style: textstyleclass.normal_bold(context).copyWith(
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.3)),
                  ),
                  TextButton(
                    onPressed: () {
                      All_widgets.imagepop(context, (value) {
                        setState(() {
                          _image = value;
                          if (_image != null) {
                            uploadfilepath.add(_image);
                            log(uploadfilepath.length.toString());
                          }
                        });
                      });
                    },
                    child: Text('Upload',
                        style: textstyleclass.text_button(context)),
                  )
                ],
              ),
              SizedBox(height: mq.height * 0.01),
              uploadfilepath.length == 0
                  ? Container()
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 15,
                              childAspectRatio: 5),
                      itemCount: uploadfilepath.length,
                      itemBuilder: (context, index) {
                        return Container(
                            // height: mq.height * 0.05,
                            // width: mq.width * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.image),
                                      SizedBox(
                                        width: mq.width * 0.02,
                                      ),
                                      SizedBox(
                                        width: mq.width * 0.2,
                                        child: Text(
                                          '${uploadfilepath[index].path.split("/").last}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        setState(() {
                                          uploadfilepath.removeAt(index);
                                        });
                                      },
                                      icon: Icon(Icons.clear))
                                ],
                              ),
                            ));
                      },
                    ),
            ],
          ),
        ),
        // ListTile(
        //   title: Text(
        //           'Add Sub-tasks',
        //           style: textstyleclass.normal_bold(context),
        //         ),
        //         subtitle: Text(
        //           'Sub-Task 1'
        //         ),
        //   trailing:TextButton(
        //             onPressed: () {},
        //             child: Text(
        //               '+ Add Sub-Task',
        //               style: textstyleclass.text_button(context)),
        //             ) ,
        // ),
        Container(
          // height: mq.height * 0.06,
          width: double.infinity,
          //  color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Sub-tasks',
                    style: textstyleclass.normal_bold(context).copyWith(
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.3)),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        is_subtask_visible = !is_subtask_visible;
                      });
                    },
                    child: Text('+ Add Sub-Task',
                        style: textstyleclass.text_button(context)),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Sub-Task 1',
                    style: textstyleclass.subtitle(context).copyWith(
                        fontSize: ResponsiveFlutter.of(context).fontSize(2)),
                  )
                ],
              )
            ],
          ),
        ),
        Visibility(
          visible: is_subtask_visible,
          child: Column(
            children: [
              SizedBox(height: mq.height * 0.03),
              all_textfields.textfield(
                'Enter Title',
                fieldController: title2_cltr,
              ),
              SizedBox(height: mq.height * 0.03),
              all_textfields.textfield(
                'Enter Due Date',
                suffixicon: const Icon(
                  Icons.calendar_today_rounded,
                  color: customcolor.orangelight,
                ),
                fieldController: due_date2_cltr,
                isreadOnly: true,
                ontap_callback: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  log(picked_date.toString());
                  setState(() {
                    due_date2_cltr.text = DateFormat("d MMM y ").format(date);

                    var picked_date = DateFormat("d MMM y 5:00").format(date);
                  });
                  print(picked_date);
                },
              ),
              SizedBox(height: mq.height * 0.03),
              all_textfields.textfield(
                'Select Role',
                suffixicon: Icon(Icons.keyboard_arrow_down,
                    color: customcolor.dark_grey_icons),
                fieldController: role_cltr,
              ),
              SizedBox(height: mq.height * 0.03),
              all_textfields.textfield(
                'Assign to',
                suffixicon: Icon(Icons.keyboard_arrow_down,
                    color: customcolor.dark_grey_icons),
                fieldController: assigntask2_cltr,
              ),
              SizedBox(height: mq.height * 0.03),
              Container(
                height: mq.height * 0.06,
                width: double.infinity,
                //  color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attachments',
                      style: textstyleclass.normal_bold(context).copyWith(
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(2.4)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Upload',
                          style: textstyleclass.text_button(context)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mq.height * 0.03,
        ),

        ElevatedButton(
            onPressed: () {
              // create.taskOwnerId = '72';
              // create.taskTitle = 'sometitle';
              // create.taskDescription = 'somedisp';
              // create.taskDueDate = '10 Sep 2022 5:00';
              // create.taskPriority = '2';
              // create.taskCategory = '10007';
              // create.departmentTypeId = '30025';
              // create.departmentId = '40035';
              // create.state = '17';
              // create.userId = '72';
              // create.assignTo = '2';
              // create.fileList[0].fileName = _image.path.split("/").last;
              // create.fileList[0].base64 =
              //     base64Encode(File(_image.path).readAsBytesSync());
              // setState(() {});
              CREATE_TASK_TEST();
            },
            child: Text(
              "Create Task",
              style: TextStyle(
                  fontSize: ResponsiveFlutter.of(context).fontSize(2.2)),
            ))
      ],
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   title_cltr.dispose();
  //   description_cltr.dispose();
  //   due_date_cltr.dispose();
  //   prority_cltr.dispose();
  //   department_cltr.dispose();
  //   assigntask_cltr.dispose();
  //   title2_cltr.dispose();
  //   due_date2_cltr.dispose();
  //   role_cltr.dispose();
  //   assigntask2_cltr.dispose();
  // }

  Future<void> lists_fetch(String api_name, ValueSetter assign_value,
      {bool enable_rolehead}) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    final String role_id = prefs.getString('role_id');

    final uri = Uri.http(api_data.URL1, api_data.URL2 + api_name,
        enable_rolehead != null ? {'RoleId': role_id} : {});
    final responce = await http.get(
      uri,
      headers: {'Apikey': api_data.api_key, 'authToken': '${token}-${id}'},
    );

    log(uri.toString());
    // log(responce.statusCode.toString());
    // log(responce.body);
    switch (responce.statusCode) {
      case 200:
        log(responce.body);
        assign_value(responce.body);
        break;
      case 404:
        All_widgets.showToastMessage('404 occured', context);

        break;
      case 401:
        All_widgets.showToastMessage('unauthorized ', context);

        All_widgets.expire_dialog(context);
        break;

      default:
        All_widgets.showToastMessage('Something went wrong ', context);
    }
  }

///////////////////////////////////////
//NEW
  Createtaskapinewfardin() async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    final uri = Uri.http(
      api_data.URL1,
      api_data.URL2 + 'AddTaskDetails',
    );
    List<Map<String, dynamic>> filejson = [];

    for (int i = 0; i < uploadfilepath.length; i++) {
      filejson.add({
        "FileName": uploadfilepath[i].path.split("/").last,
        "Base64": "data:image/png;base64," +
            base64Encode(File(uploadfilepath[i].path).readAsBytesSync()),
      });
    }

    dynamic jsonbody = {
      "TaskOwnerId": "72",
      "TaskTitle": "Test3sep",
      "TaskDescription": "Test",
      "TaskDueDate": "10 Sep 2022 5:00",
      "TaskPriority": "2",
      "TaskCategory": "10007",
      "DepartmentTypeId": "30025",
      "DepartmentId": "40035",
      "State": "17",
      "UserId": "72",
      "AssignTo": "2",
      "FileList": filejson.toString()
    };
    final responce = await http.post(uri,
        headers: {'Apikey': api_data.api_key, 'authToken': '${token}-${id}'},
        body: jsonbody);
    print('##################33');
    print(responce.body);
  }

//////////////////////////////////////////////
  ///
  ///
  Future<void> CREATE_TASK_TEST() async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    final uri = Uri.http(
      api_data.URL1,
      api_data.URL2 + 'AddTaskDetails',
    );
    List<Map<String, dynamic>> filejson = [];
    // print('length of file ');
    // print(uploadfilepath.length);
    // for (int i = 0; i < uploadfilepath.length; i++) {
    //   filejson.add({
    //     "FileName": uploadfilepath[i].path.split("/").last,
    //     "Base64": base64Encode(File(uploadfilepath[i].path).readAsBytesSync()),
    //   });
    // }
    var body = {
      "TaskOwnerId": "72",
      "TaskTitle": "fardinttile 25",
      "TaskDescription": "Test",
      "TaskDueDate": "10 Sep 2022 5:00",
      "TaskPriority": "2",
      "TaskCategory": "10007",
      "DepartmentTypeId": "30025",
      "DepartmentId": "40035",
      "State": "17",
      "UserId": "72",
      "AssignTo": "2",
      "FileList": filejson
    };
    // log(body.toString());
    final responce = await http.post(uri,
        headers: {'Apikey': api_data.api_key, 'authToken': '${token}-${id}'},
        body: jsonEncode(body));
    print('##################33');
    print(responce.body);
  }

  Future<void> new_task_create(Createtask_post ct,
      {bool enable_rolehead}) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://' + api_data.URL1 + api_data.URL2 + 'AddTaskDetails'));
    log(request.url.toString());
    request.headers['Apikey'] = api_data.api_key;
    request.headers['authToken'] = token + '-' + id;
    request.fields['TaskOwnerId'] = ct.taskOwnerId;
    request.fields['TaskTitle'] = ct.taskTitle;
    request.fields['TaskDescription'] = ct.taskDescription;
    request.fields['TaskDueDate'] = ct.taskDueDate;
    request.fields['TaskPriority'] = ct.taskPriority;
    request.fields['TaskCategory'] = ct.taskCategory;
    request.fields['DepartmentTypeId'] = ct.departmentTypeId;
    request.fields['DepartmentId'] = ct.departmentId;
    request.fields['State'] = ct.state;
    request.fields['UserId'] = ct.userId;
    request.fields['AssignTo'] = ct.assignTo;
    request.fields['FileList'] = ct.fileList.toString();
    // request.files.add(http.MultipartFile.fromBytes(
    //     'OutfitImage', File(_image.path).readAsBytesSync(),
    //     filename: _image.path));
    var res =
        await request.send(); //rest is stream responce converto  responce type
    var response = await http.Response.fromStream(res);
    log(response.body);

    // "FileList":
    // jsonEncode([jsonEncode({"FileName": "sample.jpg", "Base64": img64})])
    //   log(uri.toString());
    //   log(responce.statusCode.toString());
    //   log(responce.body);
    //   switch (responce.statusCode) {
    //     case 200:
    //       log(responce.body);
    //       assign_value(responce.body);
    //       break;
    //     case 404:
    //       All_widgets.showToastMessage('404 occured', context);

    //       break;
    //     case 401:
    //       All_widgets.showToastMessage('unauthorized ', context);

    //       All_widgets.expire_dialog(context);
    //       break;

    //     default:
    //       All_widgets.showToastMessage('Something went wrong ', context);
    //   }
    // }
  }
}
