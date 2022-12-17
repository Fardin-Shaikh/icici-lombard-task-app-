// To parse this JSON data, do
//
//     final priority = priorityFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Priority priorityFromJson(String str) => Priority.fromJson(json.decode(str));

String priorityToJson(Priority data) => json.encode(data.toJson());

class Priority {
    Priority({
        @required this.taskPrioritymodellList,
        @required this.response,
    });

    final List<TaskPrioritymodellList> taskPrioritymodellList;
    final Response response;

    factory Priority.fromJson(Map<String, dynamic> json) => Priority(
        taskPrioritymodellList: List<TaskPrioritymodellList>.from(json["TaskPrioritymodellList"].map((x) => TaskPrioritymodellList.fromJson(x))),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "TaskPrioritymodellList": List<dynamic>.from(taskPrioritymodellList.map((x) => x.toJson())),
        "response": response.toJson(),
    };
}

class Response {
    Response({
        @required this.n,
        @required this.msg,
        @required this.status,
        @required this.secureText,
        @required this.requestTimeStamp,
    });

    final int n;
    final String msg;
    final String status;
    final dynamic secureText;
    final dynamic requestTimeStamp;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        n: json["n"],
        msg: json["Msg"],
        status: json["Status"],
        secureText: json["SecureText"],
        requestTimeStamp: json["RequestTimeStamp"],
    );

    Map<String, dynamic> toJson() => {
        "n": n,
        "Msg": msg,
        "Status": status,
        "SecureText": secureText,
        "RequestTimeStamp": requestTimeStamp,
    };
}

class TaskPrioritymodellList {
    TaskPrioritymodellList({
        @required this.id,
        @required this.taskPriorityName,
    });

    final int id;
    final String taskPriorityName;

    factory TaskPrioritymodellList.fromJson(Map<String, dynamic> json) => TaskPrioritymodellList(
        id: json["Id"],
        taskPriorityName: json["TaskPriorityName"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "TaskPriorityName": taskPriorityName,
    };
}
