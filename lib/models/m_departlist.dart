// To parse this JSON data, do
//
//     final departlist = departlistFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Departlist departlistFromJson(String str) => Departlist.fromJson(json.decode(str));

String departlistToJson(Departlist data) => json.encode(data.toJson());

class Departlist {
    Departlist({
        @required this.taskdepartmenttypeslist,
        @required this.response,
    });

    final List<Taskdepartmenttypeslist> taskdepartmenttypeslist;
    final Response response;

    factory Departlist.fromJson(Map<String, dynamic> json) => Departlist(
        taskdepartmenttypeslist: List<Taskdepartmenttypeslist>.from(json["Taskdepartmenttypeslist"].map((x) => Taskdepartmenttypeslist.fromJson(x))),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "Taskdepartmenttypeslist": List<dynamic>.from(taskdepartmenttypeslist.map((x) => x.toJson())),
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

class Taskdepartmenttypeslist {
    Taskdepartmenttypeslist({
        @required this.id,
        @required this.taskDepartmentTypeName,
    });

    final int id;
    final String taskDepartmentTypeName;

    factory Taskdepartmenttypeslist.fromJson(Map<String, dynamic> json) => Taskdepartmenttypeslist(
        id: json["Id"],
        taskDepartmentTypeName: json["TaskDepartmentTypeName"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "TaskDepartmentTypeName": taskDepartmentTypeName,
    };
}
