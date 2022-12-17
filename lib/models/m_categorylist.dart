// To parse this JSON data, do
//
//     final categorylist = categorylistFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Categorylist categorylistFromJson(String str) => Categorylist.fromJson(json.decode(str));

String categorylistToJson(Categorylist data) => json.encode(data.toJson());

class Categorylist {
    Categorylist({
        @required this.taskcategorylist,
        @required this.response,
    });

    final List<Taskcategorylist> taskcategorylist;
    final Response response;

    factory Categorylist.fromJson(Map<String, dynamic> json) => Categorylist(
        taskcategorylist: List<Taskcategorylist>.from(json["Taskcategorylist"].map((x) => Taskcategorylist.fromJson(x))),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "Taskcategorylist": List<dynamic>.from(taskcategorylist.map((x) => x.toJson())),
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

class Taskcategorylist {
    Taskcategorylist({
        @required this.id,
        @required this.taskCategoryName,
    });

    final int id;
    final String taskCategoryName;

    factory Taskcategorylist.fromJson(Map<String, dynamic> json) => Taskcategorylist(
        id: json["Id"],
        taskCategoryName: json["TaskCategoryName"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "TaskCategoryName": taskCategoryName,
    };
}
