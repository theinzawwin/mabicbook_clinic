// To parse this JSON data, do
//
//     final passwordModel = passwordModelFromJson(jsonString);

import 'dart:convert';

PasswordModel passwordModelFromJson(String str) => PasswordModel.fromJson(json.decode(str));

String passwordModelToJson(PasswordModel data) => json.encode(data.toJson());

class PasswordModel {
    int id;
    String phoneNo;
    String oldPassword;
    String newPassword;

    PasswordModel({
        this.id,
        this.phoneNo,
        this.oldPassword,
        this.newPassword,
    });

    factory PasswordModel.fromJson(Map<String, dynamic> json) => PasswordModel(
        id: json["id"],
        phoneNo: json["phoneNo"],
        oldPassword: json["oldPassword"],
        newPassword: json["newPassword"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phoneNo": phoneNo,
        "oldPassword": oldPassword,
        "newPassword": newPassword,
    };
}
