import 'package:meta/meta.dart';
import 'dart:convert';

LogoutUser logoutUserFromJson(String str) => LogoutUser.fromJson(json.decode(str));

String logoutUserToJson(LogoutUser data) => json.encode(data.toJson());

class LogoutUser {
    LogoutUser({
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

    factory LogoutUser.fromJson(Map<String, dynamic> json) => LogoutUser(
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
