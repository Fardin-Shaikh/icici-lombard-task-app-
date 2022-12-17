import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:icici_staff_app/screens/WIDGETS.dart';
import 'package:icici_staff_app/screens/dashboard/inside_task.dart';
import 'package:icici_staff_app/screens/notification.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:icici_staff_app/staticData/static_data.dart';
import 'package:http/http.dart' as http;
import '../../models/m_mytask.dart';
import '../../models/m_pie.dart';
import '../../staticData/internetcheck.dart';
import '../profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => DdashboardState();
}

class DdashboardState extends State<Dashboard> {
  Size mq;
  int selectedindex = 0;

  List<Color> colorList = [
    customcolor.yellowtext,
    customcolor.redtext,
    customcolor.blue_textbutton,
    customcolor.green_chip_front,
  ];
  Pie pie_resp;
  bool pie_bool = false;
  double inprogress = 0;
  double dueDate = 0;
  double reopened = 0;
  double completed = 0;
  double totaltask = 0;
  Mytask inprogresstask_resp;
  bool inprogresstask_bool = false;
  Mytask completetask_resp;
  bool completetask_bool = false;
  Mytask reopenedtask_resp;
  bool reopenedtask_bool = false;
  Mytask duedatetask_resp;
  bool duedatetask_bool = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String username;
  String encp_image;

  @override
  void initState() {
    super.initState();

    CK.inst.internet(context, (val) {
      if (val) {
        log('haseinternet');
        share().whenComplete(() {
          Timer(const Duration(seconds: 1), () {
            paidata_fetch(
              'GetDashboardCount',
            );
            task_fetch(
              'GetMyTaskDetails',
              '1',
              (value) {
                inprogresstask_resp = Mytask.fromJson(jsonDecode(value));
              },
            ).whenComplete(() => {
                  setState(
                    () {
                      inprogresstask_resp == null
                          ? inprogresstask_bool = false
                          : inprogresstask_bool = true;
                    },
                  )
                });
          });
        });
      }
    });
  }

  Future<void> share() async {
    final prefs = await SharedPreferences.getInstance();

    username = await prefs.getString('fname');
    encp_image = await prefs.getString('pimage');
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
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.search,
          //     color: customcolor.orangelight,
          //   ),
          // ),
          SizedBox(width: mq.width * 0.03),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Notif()));
            },
            icon: Icon(
              Icons.notifications,
              color: customcolor.orangelight,
            ),
          ),
          SizedBox(width: mq.width * 0.05),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            All_widgets.big_text('Hi, ${username ?? 'User'}',
                'Lets do something productive today', mq, context),
            SizedBox(
              height: mq.height * 0.03,
            ),
            Container(
              height: mq.height * 0.03,
              width: double.infinity,
              //  color: Colors.red,
              child: Text(
                'Task Progress',
                style: textstyleclass.normal_bold(context),
              ),
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Card(
              elevation: 8,
              // color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                // height: mq.height * 0.2,
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: pie_bool
                        ? Row(
                            children: [
                              PieChart(
                                dataMap: {
                                  "In-Progres        ${inprogress.toInt()}":
                                      inprogress,
                                  "Due Date          ${dueDate.toInt()}":
                                      dueDate,
                                  "Re Open            ${reopened.toInt()}":
                                      reopened,
                                  "Completed       ${completed.toInt()}":
                                      completed,
                                },
                                animationDuration: Duration(milliseconds: 1000),
                                chartLegendSpacing: 35,
                                chartRadius:
                                    MediaQuery.of(context).size.width * 0.27,
                                colorList: colorList,
                                initialAngleInDegree: 0,
                                chartType: ChartType.ring,
                                ringStrokeWidth: 10,
                                centerText: "Total Task ${totaltask.toInt()}",
                                legendOptions: const LegendOptions(
                                  showLegendsInRow: false,
                                  legendPosition: LegendPosition.right,
                                  showLegends: true,
                                  legendShape: BoxShape.circle,
                                  legendTextStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValueBackground: true,
                                  showChartValues: false,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 1,
                                ),
                                // gradientList: ---To add gradient colors---
                                // emptyColorGradient: ---Empty Color gradient---
                              ),
                              Container(
                                color: Colors.green,
                                width: mq.width * 0.02,
                              ),
                            ],
                          )
                        : All_widgets.Loading_screen()),
              ),
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Container(
              height: mq.height * 0.04,
              width: double.infinity,
              //  color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Task',
                    style: textstyleclass.normal_bold(context),
                  ),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       'Upload',
                  //       style: textstyleclass.text_button(context),
                  //     ))
                ],
              ),
            ),
            SizedBox(
              height: mq.height * 0.01,
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
                              task_fetch(
                                '',
                                '1',
                                (value) {
                                  inprogresstask_resp =
                                      Mytask.fromJson(jsonDecode(value));
                                },
                              ).whenComplete(() {
                                setState(() {
                                  inprogresstask_resp == null
                                      ? inprogresstask_bool = false
                                      : inprogresstask_bool = true;
                                });
                              });

                              break;
                            case 1:
                              print(value);
                              task_fetch(
                                'GetMyTaskDetails',
                                '2',
                                (value) {
                                  completetask_resp =
                                      Mytask.fromJson(jsonDecode(value));
                                },
                              ).whenComplete(() {
                                setState(() {
                                  completetask_resp == null
                                      ? completetask_bool = false
                                      : completetask_bool = true;
                                });
                              });

                              break;
                            case 2:
                              print(value);
                              task_fetch(
                                'GetMyTaskDetails',
                                '3',
                                (value) {
                                  reopenedtask_resp =
                                      Mytask.fromJson(jsonDecode(value));
                                },
                              ).whenComplete(() {
                                setState(() {
                                  reopenedtask_resp == null
                                      ? reopenedtask_bool = false
                                      : reopenedtask_bool = true;
                                });
                              });

                              break;
                            case 3:
                              print(value);
                              task_fetch(
                                'GetTaskDueDate',
                                '3',
                                (value) {
                                  duedatetask_resp =
                                      Mytask.fromJson(jsonDecode(value));
                                },
                                due_dater_api_enable: true,
                              ).whenComplete(() {
                                setState(() {
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
                    // padding: EdgeInsets.symmetric(horizontal: 10),
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
                    height: mq.height * 0.01,
                  ),
                  SizedBox(
                    // color: Colors.red,
                    height: mq.height * 0.6,
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
          ],
        ),
      ),
    );
  }

  Widget card_view(List<TaskList> data) => ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      primary: true,
      itemBuilder: (BuildContext ctxt, int index) {
        switch (data[index].taskPriority) {
          case 2:
            return task_card(
                customcolor.chip_back,
                customcolor.chip_forground,
                data[index].taskPriorityName,
                data[index].taskId,
                data[index].taskTitle,
                data[index].taskDescription,
                data[index].taskDueDate,
                data[index].createdByName,
                data[index]);
            break;
          case 1:
            return task_card(
                customcolor.red_chip_back,
                customcolor.red_chip_front,
                data[index].taskPriorityName,
                data[index].taskId,
                data[index].taskTitle,
                data[index].taskDescription,
                data[index].taskDueDate,
                data[index].createdByName,
                data[index]);
            break;
          case 3:
            return task_card(
                customcolor.green_chip_back,
                customcolor.green_chip_front,
                data[index].taskPriorityName,
                data[index].taskId,
                data[index].taskTitle,
                data[index].taskDescription,
                data[index].taskDueDate,
                data[index].createdByName,
                data[index]);
            break;

          default:
            return task_card(
                customcolor.green_chip_back,
                customcolor.green_chip_front,
                'Low',
                data[index].taskId,
                data[index].taskTitle,
                data[index].taskDescription,
                data[index].taskDueDate,
                data[index].createdByName,
                data[index]);
        }
      });

  Widget task_card(
    final Color background,
    final Color forground,
    final String priority_name,
    final String taskid,
    final String task_title,
    final String tasksubtitle,
    final String date,
    final String createby,
    final TaskList data,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Detail_task(
                        passed_data: data,
                      )));
        },
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          borderOnForeground: false,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                child: Container(
                    decoration: const BoxDecoration(
                        color: customcolor.Ice_blur,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(40.0),
                        )),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 6),
                        child: Text(
                          taskid,
                          style: TextStyle(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2),
                              fontWeight: FontWeight.w500,
                              color: customcolor.blue),
                        ))),
              ),
              Container(
                // height: mq.height * 0.18,
                width: double.infinity,
                // color: Colors.lightGreenAccent,
                child: Column(
                  children: [
                    ListTile(
                        title: Text(task_title,
                            style: textstyleclass.normal_bold(context).copyWith(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2.5),
                                color: customcolor.blue)),
                        subtitle: Text(tasksubtitle,
                            style: textstyleclass.normal_bold(context).copyWith(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(1.7),
                                color: customcolor.black)),
                        trailing: Container(
                          decoration: BoxDecoration(
                              color: background,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 7),
                          child: Text(priority_name,
                              style: textstyleclass
                                  .normal_bold(context)
                                  .copyWith(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.7),
                                      color: forground)),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.grey,
                                size: 18,
                              ),
                              SizedBox(
                                width: mq.width * 0.02,
                              ),
                              Text(
                                date,
                                style: textstyleclass
                                    .normal_bold(context)
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(1.7)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * 0.02,
                          ),
                          Text(
                            'Created By : ${createby}',
                            style: textstyleclass.normal_bold(context).copyWith(
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(1.7),
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: mq.height * 0.02,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void paidata_fetch(String api_name) async {
    final prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');
    final String token = prefs.getString('token');
    print('ASGJLASDGJL;SDGJKL;DFGJKL;SDGJKL');
    print(token);

    final uri =
        Uri.http(api_data.URL1, api_data.URL2 + api_name, {'UserId': id});

    final responce = await http.get(
      uri,
      headers: {'Apikey': api_data.api_key, 'authToken': '${token}-${id}'},
    );
    log('333333333333333333333333333333333333333333333333333333333');
    log(id);
    log(token);
    log(uri.toString());
    log(responce.statusCode.toString());

    switch (responce.statusCode) {
      case 200:
        log(responce.body);
        setState(() {
          pie_resp = Pie.fromJson(jsonDecode(responce.body));
          pie_resp == null ? pie_bool = false : pie_bool = true;
          inprogress = pie_resp.dashboardmodelcount.inProgess.toDouble();
          dueDate = pie_resp.dashboardmodelcount.dueDate.toDouble();
          reopened = pie_resp.dashboardmodelcount.reopen.toDouble();
          completed = pie_resp.dashboardmodelcount.completed.toDouble();
          totaltask = pie_resp.dashboardmodelcount.totalTask.toDouble();
        });

        break;
      case 404:
        All_widgets.showToastMessage('404 occured', context);

        break;
      case 401:
        All_widgets.showToastMessage(
          'unauthorized ',
          context,
        );
        All_widgets.expire_dialog(context, show: true);

        break;

      default:
        All_widgets.showToastMessage('Something went wrong ', context);
    }
  }

  Future<void> task_fetch(
    String api_name,
    String statusid,
    ValueSetter assign_value, {
    bool due_dater_api_enable,
  }) async {
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
        All_widgets.expire_dialog(context, show: true);
        break;

      default:
      // All_widgets.showToastMessage('Something went wrong ', context);
    }
  }
}
