import 'dart:convert';
import 'dart:developer';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:icici_staff_app/models/m_mytask.dart';
import 'package:icici_staff_app/screens/WIDGETS.dart';
import 'package:icici_staff_app/screens/mytask/filterby.dart';
import 'package:icici_staff_app/screens/profile.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:http/http.dart' as http;
import 'package:icici_staff_app/staticData/static_data.dart';

import '../../staticData/internetcheck.dart';

class MyTask extends StatefulWidget {
  const MyTask({key});

  @override
  State<MyTask> createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  Size mq;
  List<int> Dummy_list = [1, 2, 0, 2, 1, 0];
  Mytask inprogresstask_resp;
  bool inprogresstask_bool = false;
  Mytask completetask_resp;
  bool completetask_bool = false;
  Mytask reopenedtask_resp;
  bool reopenedtask_bool = false;
  Mytask duedatetask_resp;
  bool duedatetask_bool = false;

  @override
  void initState() {
    super.initState();
    CK.inst.internet(context, (value_internet) {
      if (value_internet) {
        task_fetch('GetMyTaskDetails', '1', (value) {
          inprogresstask_resp = Mytask.fromJson(jsonDecode(value));
        }).whenComplete(() => {
              setState(
                () {
                  inprogresstask_resp == null
                      ? inprogresstask_bool = false
                      : inprogresstask_bool = true;
                },
              )
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
        // toolbarHeight: 200,
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
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: customcolor.orangelight,
              )),
          SizedBox(width: mq.width * 0.05),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => FluidDialog(
                    // Set the first page of the dialog.
                    rootPage: FluidDialogPage(
                        alignment: Alignment
                            .center, //Aligns the dialog to the bottom left.
                        builder: (context) => filterby(
                         
                        )

                        // This can be any widget.
                        ),
                  ),
                );
              },
              icon: Icon(
                Icons.filter_alt_outlined,
                color: customcolor.orangelight,
              )),
          SizedBox(width: mq.width * 0.05),
        ],
      ),
      body: ListView(
        children: [
          All_widgets.big_text(
              'My Task', 'Track all your tasks in one place', mq, context),
          SizedBox(
            height: mq.height * 0.03,
          ),
          DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: ListView(
              primary: false,
              shrinkWrap: true,
              children: [
                TabBar(
                  onTap: ((value) {
                    CK.inst.internet(context, (internet_check) {
                      if (internet_check) {
                        switch (value) {
                          case 0:
                            print(value);
                            task_fetch('GetMyTaskDetails', '1', (value) {
                              inprogresstask_resp =
                                  Mytask.fromJson(jsonDecode(value));
                            }).whenComplete(() {
                              setState(() {
                                inprogresstask_resp == null
                                    ? inprogresstask_bool = false
                                    : inprogresstask_bool = true;
                              });
                            });

                            break;
                          case 1:
                            print(value);
                            task_fetch('GetMyTaskDetails', '2', (value) {
                              completetask_resp =
                                  Mytask.fromJson(jsonDecode(value));
                            }).whenComplete(() {
                              setState(() {
                                completetask_resp == null
                                    ? completetask_bool = false
                                    : completetask_bool = true;
                              });
                            });

                            break;
                          case 2:
                            print(value);
                            task_fetch('GetMyTaskDetails', '3', (value) {
                              reopenedtask_resp =
                                  Mytask.fromJson(jsonDecode(value));
                            }).whenComplete(() {
                              setState(() {
                                reopenedtask_resp == null
                                    ? reopenedtask_bool = false
                                    : reopenedtask_bool = true;
                              });
                            });

                            break;
                          case 3:
                            print(value);
                            task_fetch('GetTaskDueDate', '3', (value) {
                              duedatetask_resp =
                                  Mytask.fromJson(jsonDecode(value));
                            }, due_dater_api_enable: true)
                                .whenComplete(() {
                              setState(() {
                                print(
                                    'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
                                duedatetask_resp == null
                                    ? duedatetask_bool = false
                                    : duedatetask_bool = true;
                              });
                            });

                            break;
                          default:
                        }
                      }
                    });
                  }),
                  isScrollable: true,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelPadding: EdgeInsets.symmetric(horizontal: 35),
                  tabs: const [
                    Tab(
                      text: "In-Progress",
                    ),
                    Tab(
                      text: "Completed",
                    ),
                    Tab(
                      text: "Re-opened",
                    ),
                    Tab(
                      text: "Due-Date",
                    ),
                  ],
                  labelColor: customcolor.morang_dark,
                  indicator: RectangularIndicator(
                    color: customcolor.morang_light,
                    paintingStyle: PaintingStyle.fill,
                    bottomLeftRadius: 25,
                    bottomRightRadius: 25,
                    topRightRadius: 25,
                    topLeftRadius: 25,
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.58,
                  child: TabBarView(children: [
                    inprogresstask_bool
                        ? card_view(inprogresstask_resp.taskList)
                        : All_widgets.Loading_screen(),
                    completetask_bool
                        ? card_view(completetask_resp.taskList)
                        : All_widgets.Loading_screen(),
                    reopenedtask_bool
                        ? card_view(reopenedtask_resp.taskList)
                        : All_widgets.Loading_screen(),
                    duedatetask_bool
                        ? card_view(duedatetask_resp.taskList)
                        : All_widgets.Loading_screen(),
                  ]),
                )
              ],
            ),
          ),
          SizedBox(
            height: mq.height * 0.02,
          ),
        ],
      ),
    );
  }

  Widget test_name() {
    return Container(
      // height: 200,
      color: Colors.pinkAccent,
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 200,
          itemBuilder: (BuildContext ctxt, int index) {
            return Container(
              margin: EdgeInsets.all(5),
              color: Colors.amber,
              height: 10,
            );
          }),
    );
  }

  Widget card_view(List<TaskList> data) => ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 15),
      itemBuilder: (BuildContext ctxt, int index) {
        switch (data[index].taskPriority) {
          case 2:
            return task_card(
              customcolor.chip_back,
              customcolor.chip_forground,
              data[index].taskPriorityName,
              data[index].taskTitle,
              data[index].taskDueDate,
            );
            break;
          case 1:
            return task_card(
              customcolor.red_chip_back,
              customcolor.red_chip_front,
              data[index].taskPriorityName,
              data[index].taskTitle,
              data[index].taskDueDate,
            );
            break;
          case 3:
            return task_card(
              customcolor.green_chip_back,
              customcolor.green_chip_front,
              data[index].taskPriorityName,
              data[index].taskTitle,
              data[index].taskDueDate,
            );
            break;

          default:
            return task_card(
              customcolor.green_chip_back,
              customcolor.green_chip_front,
              data[index].taskPriorityName,
              data[index].taskTitle,
              data[index].taskDueDate,
            );
        }
      });

  task_card(
    final Color background,
    final Color forground,
    final String text,
    final String task_title,
    final String date,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        borderOnForeground: false,
        child: Container(
          // height: mq.height * 0.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task_title,
                    style: textstyleclass.normal_bold(context).copyWith(
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                        color: customcolor.blue)),
                SizedBox(
                  height: mq.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: customcolor.greentext,
                      size: 18,
                    ),
                    SizedBox(
                      width: mq.width * 0.02,
                    ),
                    Text(
                      date,
                      style: textstyleclass.normal_bold(context).copyWith(
                          fontWeight: FontWeight.w500,
                          color: customcolor.greentext,
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(1.7)),
                    ),
                  ],
                ),
                SizedBox(
                  height: mq.height * 0.02,
                ),
                Container(
                  // color: Colors.amber,
                  width: double.infinity,
                  height: mq.height * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          circleav('AJ'),
                          Positioned(left: 30, child: circleav('FS')),
                          Positioned(left: 60, child: circleav('KJ')),
                          Positioned(left: 90, child: circleav('AK')),
                          // Positioned(
                          //     left: 120,
                          //     child: CircleAvatar(
                          //       backgroundColor: Colors.grey,
                          //       child: Center(
                          //           child: Icon(
                          //         Icons.more_horiz_outlined,
                          //         size: 33,
                          //         color: customcolor.dark_grey_icons,
                          //       )),
                          //     )),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: background,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        child: Text(text,
                            style: textstyleclass.normal_bold(context).copyWith(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(1.7),
                                color: forground)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circleav(final String short_name) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.orange,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange,
        child: Center(
          child: Text(
            short_name,
          ),
        ),
      ),
    );
  }

  Future<void> task_fetch(
      String api_name, String statusid, ValueSetter assign_value,
      {bool due_dater_api_enable}) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    final uri = Uri.http(
      api_data.URL1,
      api_data.URL2 + api_name,
    );
    final responce = await http.post(uri,
        headers: {'Apikey': api_data.api_key, 'authToken': '${token}-${id}'},
        body: (due_dater_api_enable == true)
            ? {"EmployeeId": id}
            : {"EmployeeId": id, "StatusId": statusid});

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
