class Createtask_post {
  String taskOwnerId;
  String taskTitle;
  String taskDescription;
  String taskDueDate;
  String taskPriority;
  String taskCategory;
  String departmentTypeId;
  String departmentId;
  String state;
  String userId;
  String assignTo;
  List<FileList> fileList;

  Createtask_post(
      {this.taskOwnerId,
      this.taskTitle,
      this.taskDescription,
      this.taskDueDate,
      this.taskPriority,
      this.taskCategory,
      this.departmentTypeId,
      this.departmentId,
      this.state,
      this.userId,
      this.assignTo,
      this.fileList});

  Createtask_post.fromJson(Map<String, dynamic> json) {
    taskOwnerId = json['TaskOwnerId'];
    taskTitle = json['TaskTitle'];
    taskDescription = json['TaskDescription'];
    taskDueDate = json['TaskDueDate'];
    taskPriority = json['TaskPriority'];
    taskCategory = json['TaskCategory'];
    departmentTypeId = json['DepartmentTypeId'];
    departmentId = json['DepartmentId'];
    state = json['State'];
    userId = json['UserId'];
    assignTo = json['AssignTo'];
    if (json['FileList'] != null) {
      fileList = <FileList>[];
      json['FileList'].forEach((v) {
        fileList.add(new FileList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TaskOwnerId'] = this.taskOwnerId;
    data['TaskTitle'] = this.taskTitle;
    data['TaskDescription'] = this.taskDescription;
    data['TaskDueDate'] = this.taskDueDate;
    data['TaskPriority'] = this.taskPriority;
    data['TaskCategory'] = this.taskCategory;
    data['DepartmentTypeId'] = this.departmentTypeId;
    data['DepartmentId'] = this.departmentId;
    data['State'] = this.state;
    data['UserId'] = this.userId;
    data['AssignTo'] = this.assignTo;
    if (this.fileList != null) {
      data['FileList'] = this.fileList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FileList {
  String fileName;
  String base64;

  FileList({this.fileName, this.base64});

  FileList.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
    base64 = json['Base64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileName'] = this.fileName;
    data['Base64'] = this.base64;
    return data;
  }
}
