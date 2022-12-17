import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:icici_staff_app/designe/textfield.dart';
import 'package:icici_staff_app/staticData/static_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/m_assignhead.dart';
import '../../models/m_categorylist.dart';
import '../../models/m_departlist.dart';
import '../../models/m_department.dart';
import '../../models/m_employerole.dart';
import '../../models/m_state.dart';
import '../../models/m_statustask.dart';
import '../../models/post_createtask.dart';
import '../../models/priority_m.dart';
import '../../staticData/internetcheck.dart';
import '../WIDGETS.dart';
import 'package:http/http.dart' as http;
import 'package:intl/src/intl/date_format.dart';

class filterby extends StatefulWidget {
  const filterby();

  @override
  State<filterby> createState() => _filterbyState();
}

class _filterbyState extends State<filterby> {
  TextEditingController title_cltr = TextEditingController();
  TextEditingController description_cltr = TextEditingController();
  TextEditingController start_date_cltr = TextEditingController(); //
  TextEditingController prority_cltr = TextEditingController();
  TextEditingController department_cltr = TextEditingController();
  TextEditingController assignhead_cltr = TextEditingController();
  TextEditingController state_cltr = TextEditingController();
  TextEditingController due_date_cltr = TextEditingController();
  TextEditingController category_cltr = TextEditingController();
  TextEditingController employerole_cltr = TextEditingController();
  TextEditingController status_cltr = TextEditingController();
  TextEditingController departmentinn_cltr = TextEditingController();

  ///RESPONCE VARIABLES
  Priority priority_resp;
  Departlist departmnet_resp;
  Statemodel state_resp;
  Assignhead assignhead_resp;
  Createtask_post create;
  Categorylist category_resp;
  EmployeRole employerole_resp;
  Statustask status_resp;
  Department departmentlist_resp;
  //SAVE LIST VARIABLE
  List<String> proority_name_list = [];
  List<String> proority_id_list = [];
  List<String> department_name_list = [];
  List<String> department_id_list = [];
  List<String> state_name_list = [];
  List<String> state_id_list = [];
  List<String> assignhead_name_list = [];
  List<String> assignhead_id_list = [];
  List<String> category_name_list = [];
  List<String> category_id_list = [];
  List<String> employerole_name_list = [];
  List<String> employerole_id_list = [];
  List<String> status_name_list = [];
  List<String> status_id_list = [];
  List<String> departmentlist_name_list = [];
  List<String> departmentlist_id_list = [];

  //SHOW DROP DOWN VARIABLE
  bool priority_dropdown = false;
  bool department_dropdown = false;
  bool state_dropdown = false;
  bool assignhead_dropdown = false;
  bool category_dropdown = false;
  bool employerole_dropdown = false;
  bool status_dropdown = false;
  bool departmentinn_dropdown = false;
  bool department_field_show = false;
  //CONTAINEING VALUE VARIABLES
  String priority_id;
  String department_id;
  String state_id;
  String assignhead_id;
  String category_id;
  String picked_date;
  String employerole_id;
  String status_id;
  String departmentlist_id;
  File _image;
  //CAUSUAL VARIABLES
  GlobalKey<FormState> status_key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    CK.inst.internet(context, (value) {
      if (value) {
        fetch_all_apis();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.all(20),
      width: mq.width * 0.85,
      height: mq.height * 0.69,
      // color: customcolor.blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                layer1(),
                Positioned(
                  left: 0,
                  top: 300,
                  child: All_widgets.dropdown_stack_conateiner(
                    priority_dropdown,
                    proority_name_list,
                    mq.width * 0.74,
                    mq.height * 0.2,
                    (index) {
                      setState(() {
                        prority_cltr.text = proority_name_list[index];
                        priority_dropdown = false;
                        for (var i = 0; i < proority_name_list.length; i++) {
                          if (prority_cltr.text == proority_name_list[index]) {
                            priority_id = proority_name_list[index];
                            log(priority_id);
                          }
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 475,
                  child: All_widgets.dropdown_stack_conateiner(
                    state_dropdown,
                    state_name_list,
                    mq.width * 0.74,
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
                  top: 733,
                  child: All_widgets.dropdown_stack_conateiner(
                    department_dropdown,
                    department_name_list,
                    mq.width * 0.74,
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
                        department_fetch('DepartmentList', (value) {
                          departmentlist_resp =
                              Department.fromJson(jsonDecode(value));
                        }, department_id)
                            .whenComplete(() {
                          setState(
                            () {
                              log(departmentlist_resp.response.n.toString() +
                                  'this value is given ');
                              if (departmentlist_resp.response.n == 1) {
                                departmentlist_name_list =
                                    List<String>.generate(
                                        departmentlist_resp
                                            .irdaiDepartmentmodelList.length,
                                        (index) => departmentlist_resp
                                            .irdaiDepartmentmodelList[index]
                                            .irdaiDepartmentName);
                                departmentlist_id_list = List<String>.generate(
                                    departmentlist_resp
                                        .irdaiDepartmentmodelList.length,
                                    (index) => departmentlist_resp
                                        .irdaiDepartmentmodelList[index].id
                                        .toString());
                                print('fffffffffffffffffffffffffffff');
                                print(departmentlist_name_list.toString() +
                                    'depsrtment name list ');
                                print(departmentlist_id_list.toString() +
                                    'depsrtment id list ');
                                departmentlist_id_list.length > 0
                                    ? department_field_show = true
                                    : department_field_show = false;
                              }
                            },
                          );
                        });
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 298,
                  child: All_widgets.dropdown_stack_conateiner(
                    department_dropdown,
                    department_name_list,
                    mq.width * 0.74,
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
                  top: 390,
                  child: All_widgets.dropdown_stack_conateiner(
                    category_dropdown,
                    category_name_list,
                    mq.width * 0.74,
                    mq.height * 0.2,
                    (index) {
                      setState(() {
                        category_cltr.text = category_name_list[index];
                        category_dropdown = false;
                        for (var i = 0; i < category_name_list.length; i++) {
                          if (category_cltr.text == category_name_list[index]) {
                            category_id = category_id_list[index];
                            log(category_id);
                          }
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 210,
                  child: All_widgets.dropdown_stack_conateiner(
                    assignhead_dropdown,
                    assignhead_name_list,
                    mq.width * 0.74,
                    mq.height * 0.2,
                    (index) {
                      setState(() {
                        assignhead_cltr.text = assignhead_name_list[index];
                        assignhead_dropdown = false;
                        for (var i = 0; i < assignhead_name_list.length; i++) {
                          if (assignhead_cltr.text ==
                              assignhead_name_list[index]) {
                            assignhead_id = assignhead_id_list[index];
                            log(assignhead_id);
                          }
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 560,
                  child: All_widgets.dropdown_stack_conateiner(
                    employerole_dropdown,
                    employerole_name_list,
                    mq.width * 0.74,
                    mq.height * 0.2,
                    (index) {
                      setState(() {
                        employerole_cltr.text = employerole_name_list[index];
                        employerole_dropdown = false;
                        for (var i = 0; i < employerole_name_list.length; i++) {
                          if (employerole_cltr.text ==
                              employerole_name_list[index]) {
                            employerole_id = employerole_id_list[index];
                            log(employerole_id);
                          }
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 650,
                  child: All_widgets.dropdown_stack_conateiner(
                    status_dropdown,
                    status_name_list,
                    mq.width * 0.74,
                    mq.height * 0.2,
                    (index) {
                      setState(() {
                        status_cltr.text = status_name_list[index];
                        status_dropdown = false;
                        for (var i = 0; i < status_name_list.length; i++) {
                          if (status_cltr.text == status_name_list[index]) {
                            status_id = status_id_list[index];
                            log(status_id);
                          }
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 750,
                  child: All_widgets.dropdown_stack_conateiner(
                    departmentinn_dropdown,
                    departmentlist_name_list,
                    mq.width * 0.74,
                    mq.height * 0.2,
                    (index) {
                      setState(() {
                        departmentinn_cltr.text =
                            departmentlist_name_list[index];
                        departmentinn_dropdown = false;
                        for (var i = 0;
                            i < departmentlist_name_list.length;
                            i++) {
                          if (departmentinn_cltr.text ==
                              departmentlist_name_list[index]) {
                            departmentlist_id = departmentlist_id_list[index];
                            log(departmentlist_id);
                          }
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget layer1() {
    var mq = MediaQuery.of(context).size;
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Filter By ',
            style: textstyleclass.normal_bold(context).copyWith(
                  fontSize: ResponsiveFlutter.of(context).fontSize(3),
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Clear All',
                  style: textstyleclass.text_button(context),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel))
            ],
          ),
        ],
      ),
      SizedBox(height: mq.height * 0.03),
      all_textfields.textfield('Enter Title',
          suffixicon: Icon(null, color: customcolor.dark_grey_icons)),
      SizedBox(height: mq.height * 0.05),
      all_textfields.textfield('Select head',
          suffixicon: Icon(
              assignhead_dropdown
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: customcolor.dark_grey_icons),
          fieldController: assignhead_cltr,
          isreadOnly: true, ontap_callback: () {
        setState(() {
          assignhead_dropdown = !assignhead_dropdown;
        });
      }),
      SizedBox(height: mq.height * 0.05),
      all_textfields.textfield(
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
      ),
      SizedBox(height: mq.height * 0.05),
      all_textfields.textfield('Select Category',
          suffixicon: Icon(
              category_dropdown
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: customcolor.dark_grey_icons),
          fieldController: category_cltr,
          isreadOnly: true, ontap_callback: () {
        setState(() {
          category_dropdown = !category_dropdown;
        });
      }),
      SizedBox(height: mq.height * 0.05),
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
      SizedBox(height: mq.height * 0.05),
      all_textfields.textfield('Select Employee Name',
          suffixicon: Icon(
              employerole_dropdown
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: customcolor.dark_grey_icons),
          fieldController: employerole_cltr,
          isreadOnly: true, ontap_callback: () {
        setState(() {
          employerole_dropdown = !employerole_dropdown;
        });
      }),
      SizedBox(height: mq.height * 0.05),
      Form(
        key: status_key,
        child: all_textfields.textfield('Select Task Status',
            suffixicon: Icon(
                status_dropdown
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: customcolor.dark_grey_icons),
            fieldController: status_cltr,
            isreadOnly: true, ontap_callback: () {
          setState(() {
            status_dropdown = !status_dropdown;
          });
        },
            validator:
                RequiredValidator(errorText: 'Required for Filtering task')),
      ),
      SizedBox(height: mq.height * 0.05),
      all_textfields.textfield('Select Department Type',
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
      Visibility(
        visible: department_field_show,
        child: Column(
          children: [
            SizedBox(height: mq.height * 0.05),
            //add department level api
            all_textfields.textfield('Select Department',
                suffixicon: Icon(
                    departmentinn_dropdown
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: customcolor.dark_grey_icons),
                fieldController: departmentinn_cltr,
                isreadOnly: true, ontap_callback: () {
              setState(() {
                departmentinn_dropdown = !departmentinn_dropdown;
              });
            }),
          ],
        ),
      ),
      SizedBox(height: mq.height * 0.05),
      all_textfields.textfield(
        'Select Due Date',
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

          setState(() {
            due_date_cltr.text = DateFormat("d MMM y ").format(date);
            var picked_date = DateFormat("d MMM y 5:00").format(date);
          });
        },
      ),
      SizedBox(height: mq.height * 0.05),
      Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              if (status_key.currentState.validate()) {
                filter_fetch(
                    'GetMyTaskDetails', status_id, (value) {}, state_id,
                    departmentid: departmentlist_id,
                    departtypeid: department_id,
                    taskpriority: priority_id,
                    taskcategory: category_id);
              }
            },
            child: Text('Apply Filter')),
      )
    ]);
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
    lists_fetch(
      'GetTaskCategoryList',
      (value) {
        category_resp = Categorylist.fromJson(jsonDecode(value));
      },
    ).whenComplete(() => {
          setState(
            () {
              print(category_resp.response.n.toString() +
                  "sdfghjklsdfghjkldfghjkl");
              if (category_resp.response.n == 1) {
                category_name_list = List<String>.generate(
                    category_resp.taskcategorylist.length,
                    (index) =>
                        category_resp.taskcategorylist[index].taskCategoryName);
                category_id_list = List<String>.generate(
                    category_resp.taskcategorylist.length,
                    (index) =>
                        category_resp.taskcategorylist[index].id.toString());
                print('fffffffffffffffffffffffffffff');
                print(category_name_list.toString());
                print(category_id_list.toString());
              }
            },
          )
        });
    lists_fetch('EmployeebyRole', (value) {
      employerole_resp = EmployeRole.fromJson(jsonDecode(value));
    }, enalbe_roleid_n_userid: true)
        .whenComplete(() => {
              setState(
                () {
                  if (employerole_resp.response.n == 1) {
                    employerole_name_list = List<String>.generate(
                        employerole_resp.employeemodellist.length,
                        (index) =>
                            employerole_resp
                                .employeemodellist[index].firstName +
                            " " +
                            employerole_resp.employeemodellist[index].lastName);
                    employerole_id_list = List<String>.generate(
                        employerole_resp.employeemodellist.length,
                        (index) => employerole_resp
                            .employeemodellist[index].role
                            .toString());
                    print(employerole_name_list.toString());
                    print(employerole_id_list.toString());
                  }
                },
              )
            });
    lists_fetch(
      'GetStatusList',
      (value) {
        status_resp = Statustask.fromJson(jsonDecode(value));
      },
    ).whenComplete(() => {
          setState(
            () {
              if (status_resp.response.n == 1) {
                status_name_list = List<String>.generate(
                    status_resp.statuslist.length,
                    (index) => status_resp.statuslist[index].statusName);
                status_id_list = List<String>.generate(
                    status_resp.statuslist.length,
                    (index) => status_resp.statuslist[index].id.toString());
                print('fffffffffffffffffffffffffffff');
                print(status_name_list.toString());
                print(status_id_list.toString());
              }
            },
          )
        });
  }

  Future<void> lists_fetch(String api_name, ValueSetter assign_value,
      {bool enable_rolehead, bool enalbe_roleid_n_userid}) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    final String role_id = prefs.getString('role_id');

    final uri = Uri.http(
        api_data.URL1,
        api_data.URL2 + api_name,
        enalbe_roleid_n_userid == null
            ? (enable_rolehead != null ? {'RoleId': role_id} : {})
            : {'RoleId': role_id, 'UserId': id});
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

  Future<void> department_fetch(String api_name, ValueSetter assign_value,
      String TaskDepartmentTypeId) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');

    final uri = Uri.http(api_data.URL1, api_data.URL2 + api_name,
        {'TaskDepartmentTypeId': TaskDepartmentTypeId});
    final responce = await http.get(
      uri,
      headers: {'Apikey': api_data.api_key, 'authToken': '${token}-${id}'},
    );

    log(uri.toString());
    print('fardin is the ');
    log(responce.statusCode.toString());
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
        All_widgets.expire_dialog(context);
        break;

      default:
        All_widgets.showToastMessage('Something went wrong ', context);
    }
  }

  Future<void> filter_fetch(
    String api_name,
    String statusid,
    ValueSetter assign_value,
    state, {
    title,
    departmentid,
    // headid,
    departtypeid,
    taskpriority,
    taskcategory,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    final uri = Uri.http(
      api_data.URL1,
      api_data.URL2 + api_name,
    );
    final pass_body = {
      "EmployeeId": id,
      "StatusId": statusid,
      "TitleName": title ?? "",
      // "HeadId": headid ,
      "DepartmentTypeId": departtypeid,
      "DepartmentId": departmentid ?? "",
      "TaskPriority": taskpriority,
      "TaskCategory": taskcategory,
      "StateId": state,
      "TaskDueDate": "12/05/2021"
    };
    final responce = await http.post(uri,
        headers: {'Apikey': api_data.api_key, 'authToken': '${token}-${id}'},
        body: pass_body);

    log(uri.toString());
    log(responce.statusCode.toString());

    switch (responce.statusCode) {
      case 200:
        log(responce.body);
        assign_value(responce.body);

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
}

var nanme = {
  "Id": 70518,
  "TaskId": "20221284",
  "TaskOwnerId": 72,
  "TaskOwnerName": "Jay Jain",
  "TaskOwnerShortName": "JJ",
  "TaskTitle": "fardinttile 25",
  "TaskDescription": "Test",
  "TaskDueDate": "10 Sep 2022 05:00",
  "TaskPriority": 2,
  "TaskPriorityName": "Moderate",
  "TaskCategory": 10007,
  "TaskCategoryName": "Submission",
  "DepartmentTypeId": 30025,
  "TaskDepartmentTypeName": "binding",
  "DepartmentId": 40035,
  "DepartmentName": "it",
  "State": 17,
  "StateName": "Kerala",
  "AssignTo": 2,
  "AssignToName": "Amit Dhumal",
  "AssignToShortName": "AD",
  "ParentTaskId": 0,
  "UserId": 0,
  "Status": 1,
  "StatusName": "In-Progress",
  "RoleId": 2,
  "RoleName": "Owner",
  "CreatedOn": "15 Dec 2022",
  "CreatedBy": 72,
  "CreatedByShortName": "JJ",
  "IsReopen": 0,
  "ReopenTaskfromthis": 0,
  "Remark": null,
  "CreatedByName": "Jay Jain",
  "xmlstr": null,
  "DueDatePassed": 1,
  "OverrideperviousFile": null,
  "filelist": [],
  "SecureText": null,
  "RequestTimeStamp": null
};
