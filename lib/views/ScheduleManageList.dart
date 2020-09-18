import 'package:flutter/material.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/models/ScheduleDetailModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';

import 'ScheduleDetailCard.dart';

class ScheduleManageList extends StatefulWidget {
  DoctorModel doctor;
  List<ScheduleDetailModel> scheduleList;
  ScheduleManageList({Key key,this.doctor,this.scheduleList}):super(key:key);
  MagicManager manager= MagicManager();
  @override
  _ScheduleManageListState createState() => _ScheduleManageListState();
}

class _ScheduleManageListState extends State<ScheduleManageList> {
  List<ScheduleDetailModel> _scheduleList;
  int autoAccept=1;
   void changeAutoAccept(int val){
    setState(() {
     autoAccept=val; 
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_scheduleList=widget.manager.scheduleList;
    setState(() {
      _scheduleList=widget.scheduleList;
      print('Schedule Length ${_scheduleList.length}');
    });
  }
  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      appBar: AppBar(
        title: Text('Manage Schedule'),
      ),
      body: */Container(
        margin: const EdgeInsets.all(16.0),
        
        child:   
           Column(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
          Expanded(
          
            child: 
           ListView.builder
              (
                shrinkWrap: true,
                itemCount: _scheduleList.length,
                itemBuilder: ( ctxt, index) {
                  return  ScheduleDetailCard(scheduleDetail:_scheduleList[index]);
                }
            ),
          )
         
              
        ]
        )
         
          
       
    );
  }
}