// To parse this JSON data, do
//
//     final pie = pieFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Pie pieFromJson(String str) => Pie.fromJson(json.decode(str));

String pieToJson(Pie data) => json.encode(data.toJson());

class Pie {
    Pie({
        @required this.dashboardmodelcount,
        @required this.response,
    });

    final Dashboardmodelcount dashboardmodelcount;
    final Response response;

    factory Pie.fromJson(Map<String, dynamic> json) => Pie(
        dashboardmodelcount: Dashboardmodelcount.fromJson(json["Dashboardmodelcount"]),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "Dashboardmodelcount": dashboardmodelcount.toJson(),
        "response": response.toJson(),
    };
}

class Dashboardmodelcount {
    Dashboardmodelcount({
        @required this.inProgess,
        @required this.completed,
        @required this.reopen,
        @required this.dueDate,
        @required this.totalTask,
        @required this.unReadNotification,
    });

    final int inProgess;
    final int completed;
    final int reopen;
    final int dueDate;
    final int totalTask;
    final int unReadNotification;

    factory Dashboardmodelcount.fromJson(Map<String, dynamic> json) => Dashboardmodelcount(
        inProgess: json["InProgess"],
        completed: json["Completed"],
        reopen: json["Reopen"],
        dueDate: json["DueDate"],
        totalTask: json["TotalTask"],
        unReadNotification: json["UnReadNotification"],
    );

    Map<String, dynamic> toJson() => {
        "InProgess": inProgess,
        "Completed": completed,
        "Reopen": reopen,
        "DueDate": dueDate,
        "TotalTask": totalTask,
        "UnReadNotification": unReadNotification,
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
