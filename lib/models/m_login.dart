import 'package:meta/meta.dart';
import 'dart:convert';

EmpDetail empDetailFromJson(String str) => EmpDetail.fromJson(json.decode(str));

String empDetailToJson(EmpDetail data) => json.encode(data.toJson());

class EmpDetail {
  EmpDetail({
    @required this.employeemodel,
    @required this.token,
    @required this.response,
  });

  final Employeemodel employeemodel;
  final String token;
  final Response response;

  factory EmpDetail.fromJson(Map<String, dynamic> json) => EmpDetail(
        employeemodel: Employeemodel.fromJson(json["Employeemodel"]),
        token: json["Token"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "Employeemodel": employeemodel.toJson(),
        "Token": token,
        "response": response.toJson(),
      };
}

class Employeemodel {
  Employeemodel({
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
  final dynamic middleName;
  final String lastName;
  final dynamic mobileNo;
  final String emailId;
  final String employeeId;
  final dynamic bloodGroup;
  final String gender;
  final dynamic dateOfBirth;
  final String profileImage;
  final String fileExtension;
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
  final String lastLoginTimeStamp;

  factory Employeemodel.fromJson(Map<String, dynamic> json) => Employeemodel(
        id: json["Id"],
        firstName: json["FirstName"],
        middleName: json["MiddleName"],
        lastName: json["LastName"],
        mobileNo: json["MobileNo"],
        emailId: json["EmailId"],
        employeeId: json["EmployeeId"],
        bloodGroup: json["BloodGroup"],
        gender: json["Gender"],
        dateOfBirth: json["DateOfBirth"],
        profileImage: json["ProfileImage"],
        fileExtension: json["FileExtension"],
        role: json["Role"],
        department: json["Department"],
        designation: json["Designation"],
        silentNotification: json["SilentNotification"],
        iciciDepartmentName: json["ICICIDepartmentName"],
        designationName: json["DesignationName"],
        roleName: json["RoleName"],
        darkTheme: json["DarkTheme"],
        createPermission: json["CreatePermission"],
        assignPermission: json["AssignPermission"],
        lastLoginTimeStamp: json["LastLoginTimeStamp"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "FirstName": firstName,
        "MiddleName": middleName,
        "LastName": lastName,
        "MobileNo": mobileNo,
        "EmailId": emailId,
        "EmployeeId": employeeId,
        "BloodGroup": bloodGroup,
        "Gender": gender,
        "DateOfBirth": dateOfBirth,
        "ProfileImage": profileImage,
        "FileExtension": fileExtension,
        "Role": role,
        "Department": department,
        "Designation": designation,
        "SilentNotification": silentNotification,
        "ICICIDepartmentName": iciciDepartmentName,
        "DesignationName": designationName,
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
