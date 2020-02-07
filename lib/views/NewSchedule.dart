import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/ClinicUserModel.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/models/ScheduleDetailModel.dart';
import 'package:magicbook_app/models/ScheduleModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:magicbook_app/views/NewScheduleDetail.dart';
import 'package:http/http.dart' as http;
import 'DoctorDropDownCard.dart';
import 'ScheduleDetailCard.dart';

class NewSchedule extends StatefulWidget {
  final MagicManager manager= MagicManager();
  @override
  _NewScheduleState createState() => _NewScheduleState();
}

class _NewScheduleState extends State<NewSchedule> {
  final df = new DateFormat("yyyy-MM-dd");
int _doctorId;
ClinicModel _clinicModel;
ClinicUserModel cUser;
  String _startDate='From Date';
  String _endDate='To Date';
  int autoAccept=1;
  List<ScheduleDetailModel> detailList=[];
   List<DoctorModel> doctorList;
List<DropdownMenuItem<int>> doctorDropDownList;
  List<DropdownMenuItem<int>> getDoctorDropDown() {
    List<DropdownMenuItem<int>> items = new List();
    if(doctorList!=null){
      for (DoctorModel t in doctorList) {
      items.add(
         DropdownMenuItem(
           
          value:t.id,
          child: DoctorDropDownCard(doctor: t,)
        
      ));
    }
    }
    
    return items;
  }
  void changeDoctor(int value){
    setState(() {
     _doctorId=value;
    });
  }
  void insert(ScheduleDetailModel sh) async{
    if(sh.dayOfWeek.toLowerCase()!="All Days".toLowerCase()){
      setState(() {
        detailList.add(sh);
      });
      
    }else{
      setState(() {
         detailList= widget.manager.daysOfWeek.map((v)=>ScheduleDetailModel(dayOfWeek: v,startTime: sh.startTime,endTime: sh.endTime,maxPatientCount: sh.maxPatientCount,f1: "",f2:"",f3:"",f4:"",f5:"",n1:0,n2:0,n3:0,n4:0,n5:0)).toList();
    print('Detail Count ${detailList.length}');
      });
    
    }
  }
  void changeAutoAccept(int val){
    setState(() {
     autoAccept=val; 
    });
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    widget.manager.getClinicUser().then((val)=>this.cUser=val);
    widget.manager.getClinicInfo().then(       
        (val){
          setState(() {
          _clinicModel = val;
          if(_clinicModel!=null){
            widget.manager.getDoctorList(_clinicModel.id).then((val){
              setState(() {
              doctorList=val; 
              });
            });
          }
        });
        }
    );
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Schedule'),
      ),
      body: Container(
      margin: const EdgeInsets.all(8.0),
     //  child:SingleChildScrollView(
      child: Form(
          key: _formKey,
         
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             
              DropdownButtonHideUnderline(
              child: DropdownButton(   
                    isExpanded: true,              
                    value: _doctorId,
                      hint: Text('Select Doctor'),
                      style: Theme.of(context).textTheme.title,
                      items:getDoctorDropDown() ,
                        onChanged: changeDoctor
                   
                      
                    ),
             
                    ), 
                    Divider(
                              height: 10.0,              
                      ),
                      Row(
                        children: <Widget>[
                          Text('Auto Accept'),
                          SizedBox(width: 20.0,),
                          Radio(
                          value: 1,
                          groupValue: autoAccept,
                          onChanged: changeAutoAccept,
                        ),
                        Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 16.0
                          ),
                        ),
                          Radio(
                        value: 2,
                        groupValue: autoAccept,
                        onChanged: changeAutoAccept,
                      ),
                      Text('No',
                      style:TextStyle(
                        fontSize: 16.0
                      )
                      ),
                  
                        ],
                      ),
                      Divider(height: 16.0,),

                    Row(
                       mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                         
                          child:RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 1.0,
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    theme: DatePickerTheme(
                                      containerHeight: 210.0,
                                    ),
                                    showTitleActions: true,
                                    minTime: DateTime(1997, 1, 1),
                                    maxTime: DateTime(2022, 12, 31),
                                    onConfirm: (date) {
                                 // print('confirm $date');
                                  _startDate =df.format(date);
                                     // '${date.year}-${date.month}-${date.day}';
                                  setState(() {});
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.date_range,
                                                size: 18.0,
                                              ),
                                              Text(
                                                " $_startDate",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              color: Colors.white,
                            ), 
                        ),
                          SizedBox(width: 10.0,),
                           Expanded(
                             child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 1.0,
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    theme: DatePickerTheme(
                                      containerHeight: 210.0,
                                    ),
                                    showTitleActions: true,
                                    minTime: DateTime(1997, 1, 1),
                                    maxTime: DateTime(2022, 12, 31),
                                    
                                    onConfirm: (date) {
                                  //print('confirm $date');

                                  _endDate =df.format(date);
                                      //'${date.year}-${date.month}-${date.day}';
                                  setState(() {});
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.date_range,
                                                size: 18.0,
                                              ),
                                              Text(
                                                " $_endDate",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              color: Colors.white,
                            ),
                           )
                            
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 100.0,
                      child:RaisedButton(
                      
                      child: Text('New Duty'),
                      onPressed: () async{
                         /* showDialog(
                      context: context,
                      child: NewScheduleDetail()
                          );*/
                          ScheduleDetailModel result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewScheduleDetail()),
                          );
                         // Fluttertoast.showToast(msg: 'Day of Week '+result.dayOfWeek,toastLength: Toast.LENGTH_LONG);
                          if(result!=null){
                            insert(result);
                          }
                      },
                    ) ,
                    ),
                     SizedBox(
                      width: 100.0,
                      child:RaisedButton(
                      
                      child: Text('Save'),
                      onPressed: () async{
                         /* showDialog(
                      context: context,
                      child: NewScheduleDetail()
                          );*/
                          
                         // Fluttertoast.showToast(msg: 'Day of Week '+result.dayOfWeek,toastLength: Toast.LENGTH_LONG);
                         _saveSchedule();
                      },
                    ) ,
                    ),
                    Expanded(
                    
                child: ListView.builder
              (
                itemCount: detailList.length,
                itemBuilder: ( ctxt, index) {
                  return  ScheduleDetailCard(scheduleDetail:detailList[index]);
                }
            ),
              
          
        
                    )
                    ,
         
                    
            ],
          ),
          )   
    ),
    );
     
  }
  _saveSchedule()async{
    bool valid=_formKey.currentState.validate();
    if(valid){
      ScheduleModel schedule = ScheduleModel(createdUser:cUser.phoneNo,modifiedUser: cUser.phoneNo,startDate: _startDate,endDate: _endDate,autoAccept: autoAccept,details: detailList,f1: "",f2:"",f3:"",f4:"",f5:"",n1:0,n2:0,n3:0,n4:0,n5:0);
      http.Response response=await widget.manager.saveSchedule(body: schedule.toJson(),clinicId: _clinicModel.id,doctorId: _doctorId);
      if(response.statusCode==200){
        Map result=json.decode(response.body);
        if(result["code"]==MagicStatus.SUCCESS){
          ScheduleModel schedule=ScheduleModel.fromJson(result["data"]);
          print("Schedule Saved Id ${schedule.id}");
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
        }else if(result["code"]==MagicStatus.SAVE_ERROR){
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
        }else{
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
        }
      }
    }
  }
}