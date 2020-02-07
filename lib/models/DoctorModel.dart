import 'package:magicbook_app/models/SpecialityModel.dart';

class DoctorModel{
  int id;
  String name;
  String createdUser;
  String modifiedUser;
  int recordStatus;
  String serialId;
  String sama;
  String degree;
  String phoneNo;
  String photo;
  String profilePhoto;
  int status;
  int clinicId;
  int speciality_id;
  SpecialityModel speciality;
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
  DoctorModel({this.id,this.name,this.status,this.recordStatus,this.serialId,this.sama,this.degree,this.phoneNo,this.photo,this.profilePhoto,this.clinicId,this.createdUser,this.modifiedUser,this.speciality_id,this.speciality,this.f1,
        this.f2,
        this.f3,
        this.f4,
        this.f5,
        this.n1,
        this.n2,
        this.n3,
        this.n4,
        this.n5});
  factory DoctorModel.fromJson(Map<String,dynamic> json)=>DoctorModel(
    id:json["id"],
    name: json["name"],
    recordStatus: json["recordStatus"],
    serialId: json["serialId"],
    sama: json["sama"],
    degree: json["degree"],
    phoneNo: json["phoneNo"],
    photo: json["photo"],
    profilePhoto: json["profilePhoto"],
    status:json["status"],
    clinicId: json["clinicId"],
    createdUser: json['createdUser'],
    modifiedUser: json['modifiedUser'],
    speciality_id: json['speciality_id'],
    speciality: SpecialityModel.fromJson(json["speciality"]!=null?json["speciality"]:{}),
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
  Map<String,dynamic> toJson()=>{
    "id":this.id,
    "name":this.name,
    "sama":this.sama,
    "degree":this.degree,
    "phoneNo":this.phoneNo,
    "recordStatus":this.recordStatus,
    "status":this.status,
    "clinicId":this.clinicId,
    "createdUser":this.createdUser,
    'speciality_id':this.speciality_id,
    "modifiedUser":this.modifiedUser,
    "photo":this.photo,
    "profilePhoto":this.profilePhoto,
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
  };
}