import 'package:flutter/material.dart';
import 'package:magicbook_app/models/ScheduleDetailModel.dart';

class ScheduleDetailCard extends StatelessWidget {
  final ScheduleDetailModel scheduleDetail;
  ScheduleDetailCard({Key key,this.scheduleDetail}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
      elevation: 2,
      child:Container(
        padding: const EdgeInsets.only(left: 16.0,right: 16.0),
        child: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(scheduleDetail.dayOfWeek,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
          ),
          
         
          Expanded(
            child:  Text('${scheduleDetail.startTime} - ${scheduleDetail.endTime}',textAlign: TextAlign.center,),
            flex: 2,
          ),
           Expanded(
            child: Text('${scheduleDetail.maxPatientCount}',textAlign: TextAlign.end,),
          ),
          
         
        ],
      ), 
      )
      
      )
    );
  }
}

