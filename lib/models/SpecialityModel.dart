class SpecialityModel {
    int id;
    String createDate;
    String modifiedDate;
    String createdUser;
    String modifiedUser;
    int recordStatus;
    String nameEng;
    String nameMyan;
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

    SpecialityModel({
        this.id,
        this.createDate,
        this.modifiedDate,
        this.createdUser,
        this.modifiedUser,
        this.recordStatus,
        this.nameEng,
        this.nameMyan,
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

    factory SpecialityModel.fromJson(Map<String, dynamic> json) => SpecialityModel(
        id: json["id"],
        createDate: json["createDate"],
        modifiedDate: json["modifiedDate"],
        createdUser: json["createdUser"],
        modifiedUser: json["modifiedUser"],
        recordStatus: json["recordStatus"],
        nameEng: json["nameEng"],
        nameMyan: json["nameMyan"],
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
        "createDate": createDate,
        "modifiedDate": modifiedDate,
        "createdUser": createdUser,
        "modifiedUser": modifiedUser,
        "recordStatus": recordStatus,
        "nameEng": nameEng,
        "nameMyan": nameMyan,
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