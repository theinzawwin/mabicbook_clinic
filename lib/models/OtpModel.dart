// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
    String phoneNo;
    String key;
    String otpCode;

    OtpModel({
        this.phoneNo,
        this.key,
        this.otpCode,
    });

    factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        phoneNo: json["phoneNo"],
        key: json["key"],
        otpCode: json["otpCode"],
    );

    Map<String, dynamic> toJson() => {
        "phoneNo": phoneNo,
        "key": key,
        "otpCode": otpCode,
    };
}
