// To parse this JSON data, do
//
//     final employeRole = employeRoleFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EmployeRole employeRoleFromJson(String str) => EmployeRole.fromJson(json.decode(str));

String employeRoleToJson(EmployeRole data) => json.encode(data.toJson());

class EmployeRole {
    EmployeRole({
        @required this.employeemodellist,
        @required this.response,
    });

    final List<Employeemodellist> employeemodellist;
    final Response response;

    factory EmployeRole.fromJson(Map<String, dynamic> json) => EmployeRole(
        employeemodellist: List<Employeemodellist>.from(json["Employeemodellist"].map((x) => Employeemodellist.fromJson(x))),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "Employeemodellist": List<dynamic>.from(employeemodellist.map((x) => x.toJson())),
        "response": response.toJson(),
    };
}

class Employeemodellist {
    Employeemodellist({
        @required this.id,
        @required this.firstName,
        @required this.middleName,
        @required this.lastName,
        @required this.mobileNo,
        @required this.emailId,
        @required this.employeeId,
        @required this.bloodGroup,
        @required this.gender,
        @required this.dateOfBirth,
        @required this.profileImage,
        @required this.fileExtension,
        @required this.role,
        @required this.department,
        @required this.designation,
        @required this.silentNotification,
        @required this.iciciDepartmentName,
        @required this.designationName,
        @required this.roleName,
        @required this.darkTheme,
        @required this.createPermission,
        @required this.assignPermission,
        @required this.lastLoginTimeStamp,
    });

    final int id;
    final String firstName;
    final String middleName;
    final String lastName;
    final String mobileNo;
    final String emailId;
    final String employeeId;
    final dynamic bloodGroup;
    final String gender;
    final dynamic dateOfBirth;
    final String profileImage;
    final dynamic fileExtension;
    final int role;
    final int department;
    final int designation;
    final int silentNotification;
    final String iciciDepartmentName;
    final String designationName;
    final String roleName;
    final int darkTheme;
    final int createPermission;
    final int assignPermission;
    final dynamic lastLoginTimeStamp;

    factory Employeemodellist.fromJson(Map<String, dynamic> json) => Employeemodellist(
        id: json["Id"],
        firstName: json["FirstName"],
        middleName: json["MiddleName"] == null ? null : json["MiddleName"],
        lastName: json["LastName"],
        mobileNo: json["MobileNo"] == null ? null : json["MobileNo"],
        emailId: json["EmailId"],
        employeeId: json["EmployeeId"],
        bloodGroup: json["BloodGroup"],
        gender: json["Gender"],
        dateOfBirth: json["DateOfBirth"],
        profileImage: json["ProfileImage"] == null ? null : json["ProfileImage"],
        fileExtension: json["FileExtension"],
        role: json["Role"],
        department: json["Department"],
        designation: json["Designation"],
        silentNotification: json["SilentNotification"],
        iciciDepartmentName: json["ICICIDepartmentName"] == null ? null : json["ICICIDepartmentName"],
        designationName: json["DesignationName"] == null ? null : json["DesignationName"],
        roleName: json["RoleName"],
        darkTheme: json["DarkTheme"],
        createPermission: json["CreatePermission"],
        assignPermission: json["AssignPermission"],
        lastLoginTimeStamp: json["LastLoginTimeStamp"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "FirstName": firstName,
        "MiddleName": middleName == null ? null : middleName,
        "LastName": lastName,
        "MobileNo": mobileNo == null ? null : mobileNo,
        "EmailId": emailId,
        "EmployeeId": employeeId,
        "BloodGroup": bloodGroup,
        "Gender": gender,
        "DateOfBirth": dateOfBirth,
        "ProfileImage": profileImage == null ? null : profileImage,
        "FileExtension": fileExtension,
        "Role": role,
        "Department": department,
        "Designation": designation,
        "SilentNotification": silentNotification,
        "ICICIDepartmentName": iciciDepartmentName == null ? null : iciciDepartmentName,
        "DesignationName": designationName == null ? null : designationName,
        "RoleName": roleName,
        "DarkTheme": darkTheme,
        "CreatePermission": createPermission,
        "AssignPermission": assignPermission,
        "LastLoginTimeStamp": lastLoginTimeStamp,
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
