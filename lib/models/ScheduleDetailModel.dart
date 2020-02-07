
class ScheduleDetailModel {
    int id;
    String createdDate;
    String modifiedDate;
    String dayOfWeek;
    String startTime;
    String endTime;
    int maxPatientCount;
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

    ScheduleDetailModel({
        this.id,
        this.createdDate,
        this.modifiedDate,
        this.dayOfWeek,
        this.startTime,
        this.endTime,
        this.maxPatientCount,
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
    });

    factory ScheduleDetailModel.fromJson(Map<String, dynamic> json) => ScheduleDetailModel(
        id: json["id"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        dayOfWeek: json["dayOfWeek"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        maxPatientCount: json["maxPatientCount"],
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
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "dayOfWeek": dayOfWeek,
        "startTime": startTime,
        "endTime": endTime,
        "maxPatientCount": maxPatientCount,
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
    };
}
