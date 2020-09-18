import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/models/ScheduleDetailModel.dart';
import 'package:magicbook_app/models/ScheduleModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:magicbook_app/views/ScheduleDetailCard.dart';
import 'package:http/http.dart' as http;

class ScheduleDetail extends StatefulWidget {
   DoctorModel doctor;
 // final List<ScheduleDetailModel> detailList;
  final ScheduleModel scheduleModel;
  final MagicManager manager= MagicManager();
  //ScheduleDetail({Key key,this.doctor}):super(key:key);
  ScheduleDetail({Key key,this.scheduleModel}):super(key:key);

  @override
  _ScheduleDetailState createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  List<ScheduleDetailModel> detailList;
  Future<ScheduleModel> scheduleModel;
  ClinicModel clinicModel;
   Map _events = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<ScheduleDetailModel> _scheduleList;
  Map weekDayMap={};
  Map patientTime={};
   Map scList={};
   List _selectedEvents=[];
  DateTime _selectedDay;
   void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
    print(_selectedEvents);
  }
List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    int totalDays=endDate.difference(startDate).inDays;
    List<int> values = [1,  5, 7];
    for (int i = 0; i <= totalDays; i++) {

      DateTime adate=startDate.add(Duration(days: i));
      if(values.contains(adate.weekday)){
        days.add(adate);
      } // true
      /*8if(adate.weekday==1 || adate.weekday==4){
        days.add(adate);
      }
      */

     
    }
    return days;
  }
  Map getEventList(DateTime startDate, DateTime endDate){
    Map eventTime={};
    Map<int,List<ScheduleDetailModel>> dayList={};
    List<DateTime> days = [];
    int totalDays=endDate.difference(startDate).inDays;
    List<int> weekDayList=[];
    for(int j=0; j<detailList.length;j++){
      String day=detailList[j].dayOfWeek;
      ScheduleDetailModel d=detailList[j];
      if(day=="Monday"){
          if(!weekDayList.contains(day))
          weekDayList.add(1);

          if(dayList[1]!=null)
          dayList[1].add(d);
          else{
              List<ScheduleDetailModel> sm=[];
             sm.add(d);
            dayList[1]=sm;
          }
         //List<ScheduleDetailModel> dlist=dayList[1];
      }
      
      else if(day=="Tuesday"){
         if(!weekDayList.contains(day))
         weekDayList.add(2);
          if(dayList[2]!=null){
             dayList[2].add(d);
          }
          else{
             List<ScheduleDetailModel> sm=[];
             sm.add(d);
            dayList[2]=sm;
          }
      }
       
      else if(day=="Wednesday"){
         if(!weekDayList.contains(day))
        weekDayList.add(3);
        if(dayList[3]!=null){
          dayList[3].add(d);
        }else{
            List<ScheduleDetailModel> sm=[];
             sm.add(d);
            dayList[3]=sm;
        }
          
      }
      
      else if(day=="Thursday"){
         if(!weekDayList.contains(day))
             weekDayList.add(4);
             if(dayList[4]!=null){
          dayList[4].add(d);
        }else{
            List<ScheduleDetailModel> sm=[];
             sm.add(d);
            dayList[4]=sm;
        }
      }
      else if(day=="Friday"){
         if(!weekDayList.contains(day))
          weekDayList.add(5);

            if(dayList[5]!=null){
          dayList[5].add(d);
        }else{
             List<ScheduleDetailModel> sm=[];
             sm.add(d);
            dayList[5]=sm;
        }
      }
      
      else if(day=="Satursday"){
         if(!weekDayList.contains(day))
          weekDayList.add(6);

            if(dayList[6]!=null){
          dayList[6].add(d);
        }else{
             List<ScheduleDetailModel> sm=[];
             sm.add(d);
            dayList[6]=sm;
        }
      }
        
      else if(day=="Sunday"){
           if(!weekDayList.contains(day))
            weekDayList.add(7);
            if(dayList[7]!=null){
          dayList[7].add(d);
        }else{
            List<ScheduleDetailModel> sm=[];
             sm.add(d);
            dayList[7]=sm;
        }
      }
       
    }
    //print(dayList);
    for (int i = 0; i <= totalDays; i++) {

      DateTime adate=startDate.add(Duration(days: i));
      if(weekDayList.contains(adate.weekday)){
        List<Map<dynamic,dynamic>> evList=[];
      
        //evList.add(eobject);
        List<ScheduleDetailModel> sdList=dayList[adate.weekday];
        sdList.forEach((d){
            Map<dynamic,dynamic> eobject={};
           eobject["name"]="${d.startTime} - ${d.endTime}";
          eobject["isDone"]=true;
          evList.add(eobject);
        });
         eventTime[DateTime(adate.year,adate.month,adate.day)]=evList;
        
      } // true
     
    }
    return eventTime;
  }
  
  @override
  void initState() {
    // TODO: implement initState
      super.initState();
    /*widget.manager.getClinicInfo().then(       
        (val){
          setState(() {
          clinicModel = val;
         scheduleModel=widget.manager.getScheduleListByDoctorAndClinic(clinicId:clinicModel.id, doctorId:widget.doctor.id);
       
          scheduleModel.then((val){
            setState(() {
               ScheduleModel sch=val;
               detailList=sch.details;
               _events=getEventList(DateTime.now(),dateFormat.parse(sch.endDate) );

            print("Print Date${sch.startDate} Event $_events");
            });
           
          });
        
        });
        }
    );
    */
     if(widget.scheduleModel!=null){
    setState(() {
     
       detailList=widget.scheduleModel.details;
    _events=getEventList(DateTime.now(),dateFormat.parse(widget.scheduleModel.endDate) );
      print("Print Date${widget.scheduleModel.startDate} Event $_events");
    
    });
    }
    
   
    /*if(clinicModel!=null){
      scheduleModel=widget.manager.getScheduleListByDoctorAndClinic(clinicId:clinicModel.id, doctorId:widget.doctor.id);
      if(scheduleModel!=null){
        scheduleModel.then((val){
          ScheduleModel sch=val;
          print("Print Date${sch.startDate}");
        });
      }
    }*/
      
     /* detailList=widget.manager.scheduleList;
    _events= getEventList(DateTime(2019,11,10), DateTime(2020,6,30));
    */
  
  }
  @override
  Widget build(BuildContext context) {
    return 
         Container(
          margin:const EdgeInsets.all(16.0),          
         
            child: Column(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           Calendar(
        eventColor: Colors.orange,
        
        events: _events,
        showTodayIcon: true,
        showArrows:true,
        isExpanded: true,
        isExpandable:true,
        
         /*dayBuilder: (BuildContext context, DateTime day) {
           return Text("$day");
         },
         */
         onDateSelected: (date) => _handleNewDate(date),
      ),
      _buildEventList()
        ],
        
          )    
         );
  }
  Widget _buildEventList() {
    return Expanded(
      child: 
      ListView.builder(
       // shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.5, color: Colors.black12),
                ),
              ),
              
              padding:
            const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
              child: ListTile(
                title: Text(_selectedEvents[index]['name'].toString()),
                onTap: () {},
              ),
            ),
        itemCount: _selectedEvents.length,
      ),
    );
  }
}