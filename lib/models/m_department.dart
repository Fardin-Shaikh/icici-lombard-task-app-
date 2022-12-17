// To parse this JSON data, do
//
//     final department = departmentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Department departmentFromJson(String str) => Department.fromJson(json.decode(str));

String departmentToJson(Department data) => json.encode(data.toJson());

class Department {
    Department({
        @required this.irdaiDepartmentmodelList,
        @required this.response,
    });

    final List<IrdaiDepartmentmodelList> irdaiDepartmentmodelList;
    final Response response;

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        irdaiDepartmentmodelList: List<IrdaiDepartmentmodelList>.from(json["IRDAIDepartmentmodelList"].map((x) => IrdaiDepartmentmodelList.fromJson(x))),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "IRDAIDepartmentmodelList": List<dynamic>.from(irdaiDepartmentmodelList.map((x) => x.toJson())),
        "response": response.toJson(),
    };
}

class IrdaiDepartmentmodelList {
    IrdaiDepartmentmodelList({
        @required this.id,
        @required this.irdaiDepartmentName,
        @required this.taskDepartmentType,
    });

    final int id;
    final String irdaiDepartmentName;
    final int taskDepartmentType;

    factory IrdaiDepartmentmodelList.fromJson(Map<String, dynamic> json) => IrdaiDepartmentmodelList(
        id: json["Id"],
        irdaiDepartmentName: json["IRDAIDepartmentName"],
        taskDepartmentType: json["TaskDepartmentType"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "IRDAIDepartmentName": irdaiDepartmentName,
        "TaskDepartmentType": taskDepartmentType,
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
