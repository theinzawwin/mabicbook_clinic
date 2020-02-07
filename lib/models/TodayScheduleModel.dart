import 'dart:convert';

TodayScheduleModel todayScheduleModelFromJson(String str) => TodayScheduleModel.fromJson(json.decode(str));

String todayScheduleModelToJson(TodayScheduleModel data) => json.encode(data.toJson());

class TodayScheduleModel {
    String endTime;
    String startTime;
    int doctorId;
    String sama;
    String doctorName;
    String profilePhoto;
    String degree;

    TodayScheduleModel({
        this.endTime,
        this.startTime,
        this.doctorId,
        this.sama,
        this.doctorName,
        this.profilePhoto,
        this.degree,
    });

    factory TodayScheduleModel.fromJson(Map<String, dynamic> json) => TodayScheduleModel(
        endTime: json["endTime"],
        startTime: json["startTime"],
        doctorId: json["doctorId"],
        sama: json["sama"],
        doctorName: json["doctorName"],
        profilePhoto: json["profilePhoto"],
        degree: json["degree"],
    );

    Map<String, dynamic> toJson() => {
        "endTime": endTime,
        "startTime": startTime,
        "doctorId": doctorId,
        "sama": sama,
        "doctorName": doctorName,
        "profilePhoto": profilePhoto,
        "degree": degree,
    };
}