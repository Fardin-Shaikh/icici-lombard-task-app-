// To parse this JSON data, do
//
//     final assignhead = assignheadFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Assignhead assignheadFromJson(String str) => Assignhead.fromJson(json.decode(str));

String assignheadToJson(Assignhead data) => json.encode(data.toJson());

class Assignhead {
    Assignhead({
        @required this.rolemodelList,
        @required this.response,
    });

    final List<RolemodelList> rolemodelList;
    final Response response;

    factory Assignhead.fromJson(Map<String, dynamic> json) => Assignhead(
        rolemodelList: List<RolemodelList>.from(json["rolemodelList"].map((x) => RolemodelList.fromJson(x))),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "rolemodelList": List<dynamic>.from(rolemodelList.map((x) => x.toJson())),
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

class RolemodelList {
    RolemodelList({
        @required this.id,
        @required this.roleName,
        @required this.headerRole,
    });

    final int id;
    final String roleName;
    final int headerRole;

    factory RolemodelList.fromJson(Map<String, dynamic> json) => RolemodelList(
        id: json["Id"],
        roleName: json["RoleName"],
        headerRole: json["HeaderRole"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "RoleName": roleName,
        "HeaderRole": headerRole,
    };
}
