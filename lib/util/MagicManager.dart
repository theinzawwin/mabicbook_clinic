
import 'dart:io';

import 'package:magicbook_app/models/BookingSummaryModel.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/ClinicUserModel.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/models/ScheduleDetailModel.dart';
import 'package:magicbook_app/models/ScheduleModel.dart';
import 'package:magicbook_app/models/SpecialityModel.dart';
import 'package:magicbook_app/models/TodayScheduleModel.dart';
import 'package:magicbook_app/models/township_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:magicbook_app/util/MagicShared.dart';
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MagicManager{
  MagicShared shared=MagicShared();
  static String url="http://192.168.100.241:9090/";
  Future<http.Response> signUpUser({Map body}) async {
    String api=url+"clinicUser/signup?apiKey=mDoctor";
    return http.post(api,headers: {"Content-Type": "application/json"},body: json.encode(body)).then((http.Response response){
    final int statusCode = response.statusCode;
    if(statusCode<200 || statusCode>400 || json==null){
      throw new Exception('Error while fetching data');
    }
    return response;
  });
}
  Future<http.Response> signIn({Map body}) async {
    try{
    String api=url+"clinicUser/signin?apiKey=mDoctor";
    return http.post(api,headers: {"Content-Type": "application/json"},body: json.encode(body)).then((http.Response response){
    final int statusCode = response.statusCode;
    if(statusCode<200 || statusCode>400 || json==null){
      throw new Exception('Error while fetching data');
    }
    return response;
  });
  }catch(e){
    throw e;
  }
}
   Future<http.Response> saveClinic({Map body,int townshipId}) async {
    String api=url+"clinic/save?apiKey=mDoctor&townshipId=$townshipId";
    return http.post(api,headers: {"Content-Type": "application/json"},body: json.encode(body)).then((http.Response response){
    final int statusCode = response.statusCode;
    if(statusCode<200 || statusCode>400 || json==null){
      throw new Exception('Error while fetching data');
    }
    return response;
  });
}
  Future<http.Response> saveDoctor({Map body,int clinicId,int specialityId}) async {
    String api=url+"doctor/save?apiKey=mDoctor&clinicId=$clinicId&specialityId=$specialityId";
    return http.post(api,headers: {"Content-Type": "application/json"},body: json.encode(body)).then((http.Response response){
    final int statusCode = response.statusCode;
    if(statusCode<200 || statusCode>400 || json==null){
      throw new Exception('Error while fetching data');
    }
    return response;
    });
  }
     Future<http.Response> saveSchedule({Map body,int clinicId,int doctorId}) async {
    String api=url+"schedule/save?apiKey=mDoctor&clinicId=$clinicId&doctorId=$doctorId";
    return http.post(api,headers: {"Content-Type": "application/json"},body: json.encode(body)).then((http.Response response){
    final int statusCode = response.statusCode;
    if(statusCode<200 || statusCode>400 || json==null){
      throw new Exception('Error while fetching data');
    }
    return response;
    });
  } 
    Future<http.Response> uploadFile({File image,String path}) async {
            try {
          String api=url+"fileUpload/uploadImage?apiKey=mDoctor";
          final mimeTypeData =
              lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
          final imageUploadRequest =
              http.MultipartRequest('POST', Uri.parse(api));
          // Attach the file in the request
          final file = await http.MultipartFile.fromPath('file', image.path,
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
          // Explicitly pass the extension of the image with request body
          // Since image_picker has some bugs due which it mixes up
          // image extension with file name like this filenamejpge
          // Which creates some problem at the server side to manage
          // or verify the file extension
          //imageUploadRequest.fields['ext'] = mimeTypeData[1];
          imageUploadRequest.fields['fPath'] = path;
          //imageUploadRequest.fields["id"]='101';
          //imageUploadRequest.fields["file"]=file;
          imageUploadRequest.files.add(file);
      
            final streamedResponse = await imageUploadRequest.send();
            final response = await http.Response.fromStream(streamedResponse);
            
              return response;
      
            }catch(e){
              throw e;
            }
    }

     Future<ScheduleModel> getScheduleListByDoctorAndClinic({int clinicId,int doctorId})async{
      try{
      String api=url+"schedule/findByDoctorAndClinic?apiKey=mDoctor&clinicId=$clinicId&doctorId=$doctorId";
      http.Response response=await http.get(api);//.then((http.Response response){
       final int statusCode = response.statusCode;
       ScheduleModel scheduleModel;
        if(statusCode<200 || statusCode>400 || json==null){
          throw new Exception('Error while fetching data');
        }
        if (response.statusCode == 200) {
          /*List<dynamic> body = json.decode(response.body)["data"];
        scheduleModel =  body.map((dynamic item) => ScheduleModel.fromJson(item),).toList().last;
          */
          Map result=json.decode(response.body);
          if(result["code"]==MagicStatus.SUCCESS){
            //  Map body = result["data"]??{};
                result.putIfAbsent('data', () => {});
                scheduleModel = ScheduleModel.fromJson(result["data"]!=null?result["data"]:{});
                }
                      
                return scheduleModel;
          } else{
            return scheduleModel;
          }
         }catch(e){
        throw e;
      }
      
        }
      
      
    Future<List<DoctorModel>> getDoctorList(int clinicId)async{
      try{
        String api=url+"doctor/findByClinicId?apiKey=mDoctor&clinicId=$clinicId";
      http.Response response=await http.get(api);//.then((http.Response response){
        List<DoctorModel> doctorList;
     // return response;
     if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)["data"];

     doctorList =body!=null? body
          .map(
            (dynamic item) => DoctorModel.fromJson(item),
          )
          .toList():[];

      return doctorList;
    } else{
      return doctorList;
    }
     
      }catch(e){
        throw e;
      }
      
   }
    Future<List<TodayScheduleModel>> getTodayScheduleList(int clinicId) async{
      String api=url+"schedule/getTodayScheduleList?apiKey=mDoctor&clinicId=$clinicId";
          http.Response response=await http.get(api);//.then((http.Response response){
            List<TodayScheduleModel> specialityList;
        // return response;
        final int statusCode = response.statusCode;
         if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception('Error while fetching data');
      }
        if (response.statusCode == 200) {
          List<dynamic> body = json.decode(utf8.decode(response.bodyBytes))["data"];

        specialityList = body
              .map(
                (dynamic item) => TodayScheduleModel.fromJson(item),
              )
              .toList();

          return specialityList;
        } else{
          return specialityList;
        }
    }

     Future<List<SpecialityModel>> getAllSpeciality()async{
          String api=url+"speciality/findAll?apiKey=mDoctor";
          http.Response response=await http.get(api);//.then((http.Response response){
            List<SpecialityModel> specialityList;
        // return response;
        if (response.statusCode == 200) {
          List<dynamic> body = json.decode(utf8.decode(response.bodyBytes))["data"];

        specialityList = body
              .map(
                (dynamic item) => SpecialityModel.fromJson(item),
              )
              .toList();

          return specialityList;
        } else{
          return specialityList;
        }
     }
    Future<List<TownshipModel>> getTownshipList()async{
      String api=url+"township/findAll?apiKey=mDoctor";
      http.Response response=await http.get(api);//.then((http.Response response){
        List<TownshipModel> townshipList;
     // return response;
     if (response.statusCode == 200) {
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes))["data"];

     townshipList = body
          .map(
            (dynamic item) => TownshipModel.fromJson(item),
          )
          .toList();

      return townshipList;
    } else{
      return townshipList;
    }
     
   }

    Future<http.Response> getBookingDoctorDetailList({int clinicId,String bookingDate}) async {
      String api=url+"booking/getDetailsCount?apiKey=mDoctor&clinicId=$clinicId&bookingDate=$bookingDate";
      return http.get(api).then((http.Response response){
      final int statusCode = response.statusCode;
      if(statusCode<200 || statusCode>400 || json==null){
        throw new Exception('Error while fetching data');
      }
      return response;
      });
    }
    Future<http.Response> getBookingListByDoctorAndStatus({int clinicId,String bookingDate,int doctorId,int status}) async {
      String api=url+"booking/getDetails?apiKey=mDoctor&clinicId=$clinicId&bookingDate=$bookingDate&doctorId=$doctorId&bookingStatus=$status";
      return http.get(api).then((http.Response response){
      final int statusCode = response.statusCode;
      if(statusCode<200 || statusCode>400 || json==null){
        throw new Exception('Error while fetching data');
      }
      return response;
      });
    }
    Future<BookingSummaryModel> getTodaySummary({int clinicId})async{
      try{
      String api=url+"booking/getSummary?apiKey=mDoctor&clinicId=$clinicId";
      http.Response response=await http.get(api);//.then((http.Response response){
       final int statusCode = response.statusCode;
       BookingSummaryModel scheduleModel;
        if(statusCode<200 || statusCode>400 || json==null){
          throw new Exception('Error while fetching data');
        }
        if (response.statusCode == 200) {
          /*List<dynamic> body = json.decode(response.body)["data"];
        scheduleModel =  body.map((dynamic item) => ScheduleModel.fromJson(item),).toList().last;
          */
          Map result=json.decode(response.body);
          if(result["code"]==MagicStatus.SUCCESS){
            //  Map body = result["data"]??{};
                result.putIfAbsent('data', () => {});
                scheduleModel = BookingSummaryModel.fromJson(result["data"]!=null?result["data"]:{});
                }
                      
                return scheduleModel;
          } else{
            return scheduleModel;
          }
         }catch(e){
        throw e;
      }
      
        }
      
    Future<http.Response> updateBookingStatus({Map body}) async {
    String api=url+"booking/updateStatus?apiKey=mDoctor";
    return http.post(api,headers: {"Content-Type": "application/json"},body: json.encode(body)).then((http.Response response){
    final int statusCode = response.statusCode;
    if(statusCode<200 || statusCode>400 || json==null){
      throw new Exception('Error while fetching data');
    }
    return response;
  });
    }

    Future<http.Response> sendOTP({Map body}) async {
    String api = url + "otp/send?apiKey=mDoctor";
    return http.post(api,headers: {"Content-Type": "application/json"},
            body: json.encode(body)).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception('Error while fetching data');
      }
      return response;
    });
  }

  Future<http.Response> verifyOTP({Map body}) async {
    String api = url + "otp/verify?apiKey=mDoctor";
    return http.post(api,headers: {"Content-Type": "application/json"},
            body: json.encode(body)).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception('Error while fetching data');
      }
      return response;
    });
  }

  Future<http.Response> resetPassword({Map body}) async {
    String api = url + "publicUser/resetPassword?apiKey=mDoctor";
    return http.post(api,headers: {"Content-Type": "application/json"},
            body: json.encode(body)).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception('Error while fetching data');
      }
      return response;
    });
  }

  Future<http.Response> changePassword({Map body}) async {
    String api = url + "publicUser/changePassword?apiKey=mDoctor";
    return http.post(api,headers: {"Content-Type": "application/json"},
            body: json.encode(body)).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception('Error while fetching data');
      }
      return response;
    });
  }

  saveClinicUser(Map data) async {

  shared.save("clinicUser", data);
  }
  saveClinicInfo(Map data) async{
    shared.save("clinic", data);
  }
    Future<ClinicModel> getClinicInfo()async{
      final prefs = await SharedPreferences.getInstance();
      String clinic_string=prefs.getString("clinic")??"";
      if(clinic_string!=""){
           Map data= json.decode(clinic_string==""?{}:clinic_string);
     // return json.decode(prefs.getString("clinic"));
      return ClinicModel.fromJson(data);
      }else{
        return null;
      }
     
    }
  Future<ClinicUserModel> getClinicUser() async{
    Map data=await shared.read("clinicUser");
    return ClinicUserModel.fromJson(data);
  }
  List<TownshipModel> townshipList= [
   TownshipModel(id:1, nameMyan:'Kamayut'),
   TownshipModel(id:2, nameMyan:'Hla Thar'),
   TownshipModel(id:3, nameMyan:'Insein'),
   TownshipModel(id:4, nameMyan:'Sanchaung')
  ];

  List<SpecialityModel> specialList=[
    SpecialityModel(id: 1,recordStatus: 1,nameMyan: "နှလုံးအထူးကု",nameEng: 'Sepcial Heart'),
    SpecialityModel(id: 2,recordStatus: 1,nameMyan: "ကျောက်ကပ်အထူးကု",nameEng: 'Sepcial Kidney'),
    SpecialityModel(id: 3,recordStatus: 1,nameMyan: "အရိုးကြောအထူးကု",nameEng: 'Sepcial Nerve'),
    SpecialityModel(id: 4,recordStatus: 1,nameMyan: "မျက်စိအထူးကု",nameEng: 'Sepcial Eye'),
  ];
  List<DoctorModel> dotorList=[
    DoctorModel(id: 1,name: 'Dr.Ko Ko Aung',sama: 'SAMA-23434',phoneNo: '092343434',degree: 'M.B.;B.S'),
    DoctorModel(id: 2,name: 'Dr.Zaw  Aung',sama: 'SAMA-23434',phoneNo: '092343434',degree: 'M.B.;B.S'),
    DoctorModel(id: 3,name: 'Dr.Khant Ko',sama: 'SAMA-23434',phoneNo: '092343434',degree: 'M.B.;B.S'),
    DoctorModel(id: 4,name: 'Dr.Thiri',sama: 'SAMA-23434',phoneNo: '092343434',degree: 'M.B.;B.S'),
    DoctorModel(id: 5,name: 'Dr.Nwe Nwe',sama: 'SAMA-23434',phoneNo: '092343434',degree: 'M.B.;B.S'),
    DoctorModel(id: 6,name: 'Dr.Ko Ko Aung',sama: 'SAMA-23434',phoneNo: '092343434',degree: 'M.B.;B.S'),
    DoctorModel(id: 7,name: 'Dr.Zaw  Aung',sama: 'SAMA-23434',phoneNo: '092343434',degree: 'M.B.;B.S'),
    DoctorModel(id: 8,name: 'Dr.Khant Ko',sama: 'SAMA-23434',phoneNo: '092343434',degree: 'M.B.;B.S'),
    DoctorModel(id: 9,name: 'Dr.Thiri',sama: 'SAMA-23434',phoneNo: '092343434',degree: 'M.B.;B.S'),
    DoctorModel(id: 10,name: 'Dr.Nwe Nwe',sama: 'SAMA-23434',phoneNo: '092343434',degree: 'M.B.;B.S'),
  ];
  
  List<ScheduleDetailModel> scheduleList=[
      ScheduleDetailModel(startTime: '9:00 AM',endTime: '11:00 AM',maxPatientCount: 40,dayOfWeek: 'Monday'),
       ScheduleDetailModel(startTime: '11:30 AM',endTime: '1:00 PM',maxPatientCount: 40,dayOfWeek: 'Monday'),
     ScheduleDetailModel(startTime: '9:00 AM',endTime: '11:00 AM',maxPatientCount: 40,dayOfWeek: 'Wednesday'),
    //ScheduleDetailModel(startTime: '9:00 AM',endTime: '11:00 AM',maxPaientCount: 40,status: 1,dayOfWeek: 'Thursday'),
    ScheduleDetailModel(startTime: '9:00 AM',endTime: '11:00 AM',maxPatientCount: 40,dayOfWeek: 'Friday'),
    ScheduleDetailModel(startTime: '4:00 PM',endTime: '8:00 PM',maxPatientCount: 40,dayOfWeek: 'Friday'),
   // ScheduleDetailModel(startTime: '9:00 AM',endTime: '11:00 AM',maxPaientCount: 40,status: 1,dayOfWeek: 'Satursday'),
    ScheduleDetailModel(startTime: '9:00 AM',endTime: '11:00 AM',maxPatientCount: 40,dayOfWeek: 'Sunday'),
  ];
  List<String> daysOfWeek=[
    'Monday','Tuesday','Wednesday','Thursday','Friday','Satursday','Sunday'
  ];
  Map<int,String> getDayMap()=>{
    1:"Monday",
    2:"Tuesday",
    3:"Wednesday",
    4:"Thursday",
    5:"Friday",
    6:"Satursday",
    7:"Sunday"
  };
}