class ClinicUserModel{
  int id;
  String createdUser;
    String serialId;
    String phoneNo;
    int status;
    String password;
    String name;
    String logo;
    String alertTo;
    String photo;
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

    ClinicUserModel({
      this.id,
        this.createdUser,
        this.serialId,
        this.phoneNo,
        this.status,
        this.password,
        this.name,
        this.logo,
        this.alertTo,
        this.photo,
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

    factory ClinicUserModel.fromJson(Map<String, dynamic> json) => ClinicUserModel(
        id:json["id"],
        createdUser: json["createdUser"],
        serialId: json["serialId"],
        phoneNo: json["phoneNo"],
        status: json["status"],
        password: json["password"],
        name: json["name"],
        logo: json["logo"],
        alertTo: json["alertTo"],
        photo: json["photo"],
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
        "id":id,
        "createdUser": createdUser,
        "serialId": serialId,
        "phoneNo": phoneNo,
        "status": status,
        "password": password,
        "name": name,
        "logo": logo,
        "alertTo": alertTo,
        "photo": photo,
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