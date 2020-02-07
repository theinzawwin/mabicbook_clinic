import 'package:magicbook_app/models/ScheduleChangeModel.dart';
import 'package:magicbook_app/models/ScheduleDetailModel.dart';

class ScheduleModel{
int id;
    String createdDate;
    String modifiedDate;
    int recordStatus;
    String createdUser;
    String modifiedUser;
    String startDate;
    String endDate;
    int autoAccept;
    String f1;
    String f2;
    String f3;
    String f4;
    String f5;
    int n1;
    int n2;
    int n3;
    int n4;
    int n5;
    List<ScheduleDetailModel> details;
    List<ScheduleChangeModel> changes;

    ScheduleModel({
        this.id,
        this.createdDate,
        this.modifiedDate,
        this.recordStatus,
        this.createdUser,
        this.modifiedUser,
        this.startDate,
        this.endDate,
        this.autoAccept,
        this.f1,
        this.f2,
        this.f3,
        this.f4,
        this.f5,
        this.n1,
        this.n2,
        this.n3,
        this.n4,
        this.n5,
        this.details,
        this.changes
    });

    factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        recordStatus: json["recordStatus"],
        createdUser: json["createdUser"],
        modifiedUser: json["modifiedUser"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        autoAccept: json["autoAccept"],
        f1: json["f1"],
        f2: json["f2"],
        f3: json["f3"],
        f4: json["f4"],
        f5: json["f5"],
        n1: json["n1"],
        n2: json["n2"],
        n3: json["n3"],
        n4: json["n4"],
        n5: json["n5"],
        details:json["details"]!=null? List<ScheduleDetailModel>.from(json["details"].map((x) => ScheduleDetailModel.fromJson(x))):[],
        changes:json["changes"]!=null? List<ScheduleChangeModel>.from(json["changes"].map((x)=>ScheduleChangeModel.fromJson(x))):[]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "recordStatus": recordStatus,
        "createdUser": createdUser,
        "modifiedUser": modifiedUser,
        "startDate": startDate,//"${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": endDate,//"${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "autoAccept": autoAccept,
        "f1": f1,
        "f2": f2,
        "f3": f3,
        "f4": f4,
        "f5": f5,
        "n1": n1,
        "n2": n2,
        "n3": n3,
        "n4": n4,
        "n5": n5,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
    };
}

