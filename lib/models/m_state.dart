// To parse this JSON data, do
//
//     final statemodel = statemodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Statemodel statemodelFromJson(String str) => Statemodel.fromJson(json.decode(str));

String statemodelToJson(Statemodel data) => json.encode(data.toJson());

class Statemodel {
    Statemodel({
        @required this.statelist,
        @required this.response,
    });

    final List<Statelist> statelist;
    final Response response;

    factory Statemodel.fromJson(Map<String, dynamic> json) => Statemodel(
        statelist: List<Statelist>.from(json["Statelist"].map((x) => Statelist.fromJson(x))),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "Statelist": List<dynamic>.from(statelist.map((x) => x.toJson())),
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

class Statelist {
    Statelist({
        @required this.id,
        @required this.stateName,
        @required this.defaultSelected,
    });

    final int id;
    final String stateName;
    final int defaultSelected;

    factory Statelist.fromJson(Map<String, dynamic> json) => Statelist(
        id: json["Id"],
        stateName: json["StateName"],
        defaultSelected: json["DefaultSelected"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "StateName": stateName,
        "DefaultSelected": defaultSelected,
    };
}
