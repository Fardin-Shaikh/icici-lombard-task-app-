// To parse this JSON data, do
//
//     final uploadProfile = uploadProfileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UploadProfile uploadProfileFromJson(String str) => UploadProfile.fromJson(json.decode(str));

String uploadProfileToJson(UploadProfile data) => json.encode(data.toJson());

class UploadProfile {
    UploadProfile({
        @required this.employeeprofile,
        @required this.response,
    });

    final Employeeprofile employeeprofile;
    final Response response;

    factory UploadProfile.fromJson(Map<String, dynamic> json) => UploadProfile(
        employeeprofile: Employeeprofile.fromJson(json["Employeeprofile"]),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "Employeeprofile": employeeprofile.toJson(),
        "response": response.toJson(),
    };
}

class Employeeprofile {
    Employeeprofile({
        @required this.employeeId,
        @required this.fileName,
        @required this.base64,
        @required this.fileExtension,
        @required this.secureText,
        @required this.requestTimeStamp,
    });

    final String employeeId;
    final dynamic fileName;
    final String base64;
    final String fileExtension;
    final dynamic secureText;
    final dynamic requestTimeStamp;

    factory Employeeprofile.fromJson(Map<String, dynamic> json) => Employeeprofile(
        employeeId: json["EmployeeId"],
        fileName: json["FileName"],
        base64: json["Base64"],
        fileExtension: json["FileExtension"],
        secureText: json["SecureText"],
        requestTimeStamp: json["RequestTimeStamp"],
    );

    Map<String, dynamic> toJson() => {
        "EmployeeId": employeeId,
        "FileName": fileName,
        "Base64": base64,
        "FileExtension": fileExtension,
        "SecureText": secureText,
        "RequestTimeStamp": requestTimeStamp,
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
