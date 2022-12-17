import 'package:meta/meta.dart';
import 'dart:convert';

Mytask mytaskFromJson(String str) => Mytask.fromJson(json.decode(str));

String mytaskToJson(Mytask data) => json.encode(data.toJson());

class Mytask {
    Mytask({
        @required this.taskList,
        @required this.filelist,
        @required this.response,
    });

    final List<TaskList> taskList;
    final List<Filelist> filelist;
    final Response response;

    factory Mytask.fromJson(Map<String, dynamic> json) => Mytask(
        taskList: List<TaskList>.from(json["TaskList"].map((x) => TaskList.fromJson(x))),
        filelist: List<Filelist>.from(json["filelist"].map((x) => Filelist.fromJson(x))),
        response: Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "TaskList": List<dynamic>.from(taskList.map((x) => x.toJson())),
        "filelist": List<dynamic>.from(filelist.map((x) => x.toJson())),
        "response": response.toJson(),
    };
}

class Filelist {
    Filelist({
        @required this.id,
        @required this.taskId,
        @required this.fileLink,
        @required this.fileName,
        @required this.fileExtension,
        @required this.base64,
        @required this.taskComplete,
    });

    final int id;
    final int taskId;
    final String fileLink;
    final String fileName;
    final String fileExtension;
    final dynamic base64;
    final int taskComplete;

    factory Filelist.fromJson(Map<String, dynamic> json) => Filelist(
        id: json["Id"],
        taskId: json["TaskId"],
        fileLink: json["FileLink"],
        fileName: json["FileName"],
        fileExtension: json["FileExtension"],
        base64: json["Base64"],
        taskComplete: json["TaskComplete"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "TaskId": taskId,
        "FileLink": fileLink,
        "FileName": fileName,
        "FileExtension": fileExtension,
        "Base64": base64,
        "TaskComplete": taskComplete,
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

class TaskList {
    TaskList({
        @required this.id,
        @required this.taskId,
        @required this.taskOwnerId,
        @required this.taskOwnerName,
        @required this.taskOwnerShortName,
        @required this.taskTitle,
        @required this.taskDescription,
        @required this.taskDueDate,
        @required this.taskPriority,
        @required this.taskPriorityName,
        @required this.taskCategory,
        @required this.taskCategoryName,
        @required this.departmentTypeId,
        @required this.taskDepartmentTypeName,
        @required this.departmentId,
        @required this.departmentName,
        @required this.state,
        @required this.stateName,
        @required this.assignTo,
        @required this.assignToName,
        @required this.assignToShortName,
        @required this.parentTaskId,
        @required this.userId,
        @required this.status,
        @required this.statusName,
        @required this.roleId,
        @required this.roleName,
        @required this.createdOn,
        @required this.createdBy,
        @required this.createdByShortName,
        @required this.isReopen,
        @required this.reopenTaskfromthis,
        @required this.remark,
        @required this.createdByName,
        @required this.xmlstr,
        @required this.dueDatePassed,
        @required this.overrideperviousFile,
        @required this.filelist,
        @required this.secureText,
        @required this.requestTimeStamp,
    });

    final int id;
    final String taskId;
    final int taskOwnerId;
    final String taskOwnerName;
    final String taskOwnerShortName;
    final String taskTitle;
    final String taskDescription;
    final String taskDueDate;
    final int taskPriority;
    final String taskPriorityName;
    final int taskCategory;
    final String taskCategoryName;
    final int departmentTypeId;
    final String taskDepartmentTypeName;
    final int departmentId;
    final String departmentName;
    final int state;
    final String stateName;
    final int assignTo;
    final String assignToName;
    final String assignToShortName;
    final int parentTaskId;
    final int userId;
    final int status;
    final String statusName;
    final int roleId;
    final String roleName;
    final String createdOn;
    final int createdBy;
    final String createdByShortName;
    final int isReopen;
    final int reopenTaskfromthis;
    final dynamic remark;
    final String createdByName;
    final dynamic xmlstr;
    final int dueDatePassed;
    final dynamic overrideperviousFile;
    final List<Filelist> filelist;
    final dynamic secureText;
    final dynamic requestTimeStamp;

    factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
        id: json["Id"],
        taskId: json["TaskId"],
        taskOwnerId: json["TaskOwnerId"],
        taskOwnerName: json["TaskOwnerName"],
        taskOwnerShortName: json["TaskOwnerShortName"],
        taskTitle: json["TaskTitle"],
        taskDescription: json["TaskDescription"],
        taskDueDate: json["TaskDueDate"],
        taskPriority: json["TaskPriority"],
        taskPriorityName: json["TaskPriorityName"],
        taskCategory: json["TaskCategory"],
        taskCategoryName: json["TaskCategoryName"],
        departmentTypeId: json["DepartmentTypeId"],
        taskDepartmentTypeName: json["TaskDepartmentTypeName"],
        departmentId: json["DepartmentId"],
        departmentName: json["DepartmentName"],
        state: json["State"],
        stateName: json["StateName"],
        assignTo: json["AssignTo"],
        assignToName: json["AssignToName"],
        assignToShortName: json["AssignToShortName"],
        parentTaskId: json["ParentTaskId"],
        userId: json["UserId"],
        status: json["Status"],
        statusName: json["StatusName"],
        roleId: json["RoleId"],
        roleName: json["RoleName"],
        createdOn: json["CreatedOn"],
        createdBy: json["CreatedBy"],
        createdByShortName: json["CreatedByShortName"],
        isReopen: json["IsReopen"],
        reopenTaskfromthis: json["ReopenTaskfromthis"],
        remark: json["Remark"],
        createdByName: json["CreatedByName"],
        xmlstr: json["xmlstr"],
        dueDatePassed: json["DueDatePassed"],
        overrideperviousFile: json["OverrideperviousFile"],
        filelist: List<Filelist>.from(json["filelist"].map((x) => Filelist.fromJson(x))),
        secureText: json["SecureText"],
        requestTimeStamp: json["RequestTimeStamp"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "TaskId": taskId,
        "TaskOwnerId": taskOwnerId,
        "TaskOwnerName": taskOwnerName,
        "TaskOwnerShortName": taskOwnerShortName,
        "TaskTitle": taskTitle,
        "TaskDescription": taskDescription,
        "TaskDueDate": taskDueDate,
        "TaskPriority": taskPriority,
        "TaskPriorityName": taskPriorityName,
        "TaskCategory": taskCategory,
        "TaskCategoryName": taskCategoryName,
        "DepartmentTypeId": departmentTypeId,
        "TaskDepartmentTypeName": taskDepartmentTypeName,
        "DepartmentId": departmentId,
        "DepartmentName": departmentName,
        "State": state,
        "StateName": stateName,
        "AssignTo": assignTo,
        "AssignToName": assignToName,
        "AssignToShortName": assignToShortName,
        "ParentTaskId": parentTaskId,
        "UserId": userId,
        "Status": status,
        "StatusName": statusName,
        "RoleId": roleId,
        "RoleName": roleName,
        "CreatedOn": createdOn,
        "CreatedBy": createdBy,
        "CreatedByShortName": createdByShortName,
        "IsReopen": isReopen,
        "ReopenTaskfromthis": reopenTaskfromthis,
        "Remark": remark,
        "CreatedByName": createdByName,
        "xmlstr": xmlstr,
        "DueDatePassed": dueDatePassed,
        "OverrideperviousFile": overrideperviousFile,
        "filelist": List<dynamic>.from(filelist.map((x) => x.toJson())),
        "SecureText": secureText,
        "RequestTimeStamp": requestTimeStamp,
    };
}
