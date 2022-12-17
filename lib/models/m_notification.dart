// To parse this JSON data, do
//
//     final notifi = notifiFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Notifi notifiFromJson(String str) => Notifi.fromJson(json.decode(str));

String notifiToJson(Notifi data) => json.encode(data.toJson());

class Notifi {
    Notifi({
        @required this.getNotificationModelList,
        @required this.extensionCount,
        @required this.response,
    });

    final List<GetNotificationModelList> getNotificationModelList;
    final String extensionCount;
    final Response response;

    factory Notifi.fromJson(Map<String, dynamic> json) => Notifi(
        getNotificationModelList: List<GetNotificationModelList>.from(json["GetNotificationModelList"].map((x) => GetNotificationModelList.fromJson(x))),
        extensionCount: json["ExtensionCount"],
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "GetNotificationModelList": List<dynamic>.from(getNotificationModelList.map((x) => x.toJson())),
        "ExtensionCount": extensionCount,
        "response": response.toJson(),
    };
}

class GetNotificationModelList {
    GetNotificationModelList({
        @required this.id,
        @required this.userId,
        @required this.notification,
        @required this.isRead,
        @required this.priorityId,
        @required this.createdOn,
        @required this.fcmNotificationId,
        @required this.body,
        @required this.title,
    });

    final int id;
    final int userId;
    final String notification;
    final int isRead;
    final int priorityId;
    final dynamic createdOn;
    final dynamic fcmNotificationId;
    final dynamic body;
    final dynamic title;

    factory GetNotificationModelList.fromJson(Map<String, dynamic> json) => GetNotificationModelList(
        id: json["Id"],
        userId: json["UserId"],
        notification: json["Notification"],
        isRead: json["IsRead"],
        priorityId: json["PriorityId"],
        createdOn: json["CreatedOn"],
        fcmNotificationId: json["fcmNotificationId"],
        body: json["Body"],
        title: json["Title"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "Notification": notification,
        "IsRead": isRead,
        "PriorityId": priorityId,
        "CreatedOn": createdOn,
        "fcmNotificationId": fcmNotificationId,
        "Body": body,
        "Title": title,
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
