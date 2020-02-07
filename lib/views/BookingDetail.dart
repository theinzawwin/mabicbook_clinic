import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magicbook_app/models/BookingModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:http/http.dart' as http;
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:magicbook_app/views/BookingDetailCard.dart';
import 'package:progress_dialog/progress_dialog.dart';
class BookingDetail extends StatefulWidget {
  int clinicId;
  String bookingDate;
  int doctorId;
  int status;
  MagicManager manager = new MagicManager();
  BookingDetail({Key key,this.clinicId,this.bookingDate,this.doctorId,this.status}):super(key:key);
  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
   String title="";
  ProgressDialog pr;
  List<BookingModel> bookingList;
  BookingModel bookingModel;
  void onStatusUpdate(BookingModel bookModel){
    setState(() {
      this.bookingModel=bookModel; 
       Map data={
        "id":bookingModel.id,
        "status":bookingModel.status,
      };
      pr.show();
      widget.manager.updateBookingStatus(body:data).then((val){
        http.Response response=val;
        if(response.statusCode==200){
          Map body=json.decode(response.body);
          if(body["code"]==MagicStatus.SUCCESS){
            
            setState(() {
               bookingList.remove(bookingModel);
            });
           
     
          }else{
            Fluttertoast.showToast(msg: "Error",toastLength: Toast.LENGTH_LONG);
          }
          if(pr.isShowing())
            pr.hide();
        }
        if(pr.isShowing())
            pr.hide();
      });
     
      // print('Id is ${bookingModel.id} and Status is ${bookingModel.status}');
    });
  
  }
  getBookingDetailList(int clinicId,String bookingDate,int doctorId, int status) async{
    widget.manager.getBookingListByDoctorAndStatus(clinicId: clinicId,bookingDate: bookingDate,doctorId: doctorId,status: status).then((val){
      setState(() {
        http.Response response=val;
      if(response.statusCode==200){
        Map result=json.decode(response.body);
        if(result["data"]!=null){
        
            List<dynamic> body=result["data"];
             
            bookingList=body
          .map(
            (dynamic item) => BookingModel.fromJson(item),
          )
          .toList();
         
          
        }else{
         
           bookingList=[]; 
        
        }
      }
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if(bookingModel!=null){
        if(bookingModel.status==1){
          title="Booking Pending List";
        }else if(bookingModel.status==2){
          title="Booking Accept List";
        }else{
          title="Booking Reject List";
        } 
      }
      
    });
    getBookingDetailList(this.widget.clinicId,this.widget.bookingDate,this.widget.doctorId,this.widget.status);
  }
  @override
  Widget build(BuildContext context) {
      pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
     pr.style(message: 'Showing some progress...');
    
    //Optional
    pr.style(
          message: 'Please wait...',
          borderRadius: 10.0,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progressTextStyle: TextStyle(
              color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
          messageTextStyle: TextStyle(
              color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
        );
       
       
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Detail"),
      ),
      body: Container(
      margin: const EdgeInsets.all(16.0),
      child: bookingList!=null? ListView.builder(
             
           itemCount: bookingList.length,
                itemBuilder: ( ctxt, index) {
                  BookingModel bookModel=bookingList[index];
                  return  BookingDetailCard(bookingDetail: bookModel,onUpdateStatus:onStatusUpdate,);
                }
        ):CircularProgressIndicator(),
    ),
    );
    
    
  }
}