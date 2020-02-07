import 'package:flutter/foundation.dart';
import 'package:magicbook_app/models/township_model.dart';

class ClinicModel{
   int id;
   String nameEng;
   String nameMyan;
   int doctorCount;
   int userCount;
   String phone;
   int township_id;
   String address;
   String createdUser;
   String modifiedUser;

   String logo;
  String latitude;
  String longitude;
  TownshipModel township;
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
 
  ClinicModel({this.id, this.nameEng, this.nameMyan, this.doctorCount, this.userCount, this.phone, this.township_id, this.address,this.createdUser,this.modifiedUser,this.logo,this.latitude,this.longitude, this.f1,
        this.f2,
        this.f3,
        this.f4,
        this.f5,
        this.n1,
        this.n2,
        this.n3,
        this.n4,
        this.n5,this.township});
  factory ClinicModel.fromJson(Map<String,dynamic> json) => ClinicModel(
    id: json["id"],
    nameEng:json["nameEng"],
    nameMyan:json["nameMyan"],
     doctorCount:json["doctorCount"], 
     userCount:json["userCount"],
      phone:json["phone"],
     township_id:json["township_id"],
      address:json["address"],
      createdUser: json["createdUser"],
      modifiedUser: json["modifiedUser"],
      latitude: json["latitude"]??"",
      longitude: json["longitude"]??"",
      logo: json["logo"],
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
        township: TownshipModel.fromJson(json["township"]!=null?json["township"]:{})
      );
      Map<String, dynamic> toJson() => {
        "id":this.id,
        "nameEng":this.nameEng,
        "nameMyan":this.nameMyan,
        "doctorCount":this.doctorCount,
        "userCount":this.userCount,
        "phone":this.phone,
        "township_id":this.township_id,
        "address":this.address,
        "createdUser":this.createdUser,
        "modifiedUser":this.modifiedUser,
        "latitude":this.latitude??"",
        "longitude":this.longitude??"",
        "logo":this.logo??"",
         "f1": f1??"",
        "f2": f2??"",
        "f3": f3??"",
        "f4": f4 ??"",
        "f5": f5 ??"",
        "n1": n1,
        "n2": n2,
        "n3": n3,
        "n4": n4,
        "n5": n5,
       // "township":township.toJson()
      };
}