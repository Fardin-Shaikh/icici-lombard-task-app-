// To parse this JSON data, do
//
//     final statustask = statustaskFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Statustask statustaskFromJson(String str) =>
    Statustask.fromJson(json.decode(str));

String statustaskToJson(Statustask data) => json.encode(data.toJson());

class Statustask {
  Statustask({
    @required this.statuslist,
    @required this.response,
  });

  final List<Statuslist> statuslist;
  final Response response;

  factory Statustask.fromJson(Map<String, dynamic> json) => Statustask(
        statuslist: List<Statuslist>.from(
            json["Statuslist"].map((x) => Statuslist.fromJson(x))),
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "Statuslist": List<dynamic>.from(statuslist.map((x) => x.toJson())),
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

class Statuslist {
  Statuslist({
    @required this.id,
    @required this.statusName,
  });

  final int id;
  final String statusName;

  factory Statuslist.fromJson(Map<String, dynamic> json) => Statuslist(
        id: json["Id"],
        statusName: json["StatusName"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "StatusName": statusName,
      };
}
