import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:magicbook_app/models/ScheduleDetailModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';

class ScheduleCalendarDetail extends StatefulWidget {
  MagicManager manager= MagicManager();
  @override
  _ScheduleCalendarDetailState createState() => _ScheduleCalendarDetailState();
}

class _ScheduleCalendarDetailState extends State<ScheduleCalendarDetail> {
  List<ScheduleDetailModel> detailList;

   Map _events = {};
    /*DateTime(2019, 11, 1): [
      {'name': 'Event A', 'isDone': true},
    ],
    DateTime(2019, 11, 4): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2019, 11, 5): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2019, 11, 13): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
    DateTime(2019, 11, 15): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
    DateTime(2019, 11, 26): [
      {'name': 'Event A', 'isDone': false},
    ],
  }; */
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
        Map<dynamic,dynamic> eobject={};
        //evList.add(eobject);
        List<ScheduleDetailModel> sdList=dayList[adate.weekday];
        for(int d=0;d<sdList.length;d++){
          ScheduleDetailModel sd=sdList[d];
          eobject["name"]="${sd.startTime} - ${sd.endTime}";
          eobject["isDone"]=true;
          evList.add(eobject);
        }
      //  dayList[adate.weekday].forEach((d)=>(evList.add(eobject["name"]="${d.startTime} - ${d.endTime}")  ));
           // evList["isDone"]=true;);
        
          
        eventTime[DateTime(adate.year,adate.month,adate.day)]=evList;
        //days.add(adate);
      } // true
      /*8if(adate.weekday==1 || adate.weekday==4){
        days.add(adate);
      }
      */

     
    }
    return eventTime;
  }
  
  @override
  void initState() {
    // TODO: implement initState
    detailList=widget.manager.scheduleList;
    /*List<DateTime> dateList= calculateDaysInterval(DateTime.now(), DateTime(2019,12,30));
dateList.map((val)=>print(val)).toList();
*/ _events= getEventList(DateTime(2019,11,10), DateTime(2020,6,30));
   // List<ScheduleDetailModel> dList=test[1];
   // dList.forEach((d)=>print(d.dayOfWeek));
   print(_events);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Calendar'),
      ),
      body: SafeArea(
        
        child: Container(
          margin:const EdgeInsets.all(16.0),
            child: Column(
                 mainAxisSize: MainAxisSize.max,
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
            ),
          ),
        ),
    
    );
  }
  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
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