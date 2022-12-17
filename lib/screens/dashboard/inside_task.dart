import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:icici_staff_app/designe/custom_color.dart';
import 'package:icici_staff_app/models/m_mytask.dart';
import 'package:icici_staff_app/screens/create_task.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class Detail_task extends StatefulWidget {
  final TaskList passed_data;
  Detail_task({Key key, this.passed_data}) : super(key: key);

  @override
  State<Detail_task> createState() => _Detail_taskState();
}

class _Detail_taskState extends State<Detail_task> {
  Size mq;

  @override
  Widget build(BuildContext context) {
    TaskList data = widget.passed_data;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 8),
        child: ListView(
          children: [
            Text(data.taskTitle, style: textstyleclass.heading(context)),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: customcolor.Ice_blur,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: Text('#${data.taskId}',
                      style: textstyleclass.normal_bold(context).copyWith(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.9),
                          color: customcolor.blue)),
                ),
                SizedBox(
                  width: mq.width * 0.04,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: customcolor.chip_back,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: Text('Priority - ${data.taskPriorityName}',
                      style: textstyleclass.normal_bold(context).copyWith(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.9),
                          color: customcolor.orange)),
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      data.taskDueDate,
                      style: textstyleclass.normal_bold(context).copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(1.7)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 18,
                    ),
                    SizedBox(
                      width: mq.width * 0.02,
                    ),
                    Text(
                      data.taskOwnerName,
                      style: textstyleclass.normal_bold(context).copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(1.7)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Text(
              'Description ',
              style: textstyleclass.text_button(context),
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Text(
              data.taskDescription,
              style: textstyleclass
                  .normal_bold(context)
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Text(
              'Participants ',
              style: textstyleclass.text_button(context),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: const [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
                ),
                Positioned(
                    left: 30,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1619895862022-09114b41f16f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
                    )),
                Positioned(
                    left: 60,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1628890920690-9e29d0019b9b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                    )),
                Positioned(
                    left: 90,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                    )),
                Positioned(
                    left: 120,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Center(
                          child: Icon(
                        Icons.more_horiz_outlined,
                        size: 33,
                        color: customcolor.dark_grey_icons,
                      )),
                    )),
              ],
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            inside_card(),
            SizedBox(height: mq.height * 0.05),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    print(widget.passed_data.assignToName);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Create_task(
                                  fillcontrollers: true,
                                  passed_data: widget.passed_data,
                                )));
                  },
                  child: Text(
                    'Update/Assign Task',
                    style: TextStyle(
                        fontSize: ResponsiveFlutter.of(context).fontSize(1.9)),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget inside_card() => Card(
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
                        '#${widget.passed_data.taskId}',
                        style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
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
                      title: Text(widget.passed_data.taskTitle,
                          style: textstyleclass.normal_bold(context).copyWith(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5),
                              color: customcolor.blue)),
                      subtitle: Text(widget.passed_data.taskDescription,
                          style: textstyleclass.normal_bold(context).copyWith(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(1.7),
                              color: customcolor.black)),
                      trailing: Text(
                        widget.passed_data.statusName,
                        style: textstyleclass
                            .text_button(context)
                            .copyWith(color: customcolor.chip_forground),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
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
                              widget.passed_data.taskDueDate,
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
                          'Created By : ${widget.passed_data.taskOwnerName}',
                          style: textstyleclass.normal_bold(context).copyWith(
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(1.7),
                              color: Colors.grey),
                        ),
                        Divider(
                          color: customcolor.dark_grey_icons,
                          height: 25,
                        ),
                        Container(
                          // color: Colors.red,
                          height: mq.height * 0.05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: customcolor.chip_back,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 7),
                                child: Text(widget.passed_data.taskPriorityName,
                                    style: textstyleclass
                                        .normal_bold(context)
                                        .copyWith(
                                            fontSize:
                                                ResponsiveFlutter.of(context)
                                                    .fontSize(1.7),
                                            color: customcolor.chip_forground)),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.chat),
                                  SizedBox(
                                    width: mq.width * 0.02,
                                  ),
                                  Text(
                                    "Added Note",
                                    style: textstyleclass.normal_bold(context),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
