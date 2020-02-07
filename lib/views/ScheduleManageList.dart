import 'package:flutter/material.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/models/ScheduleDetailModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';

import 'ScheduleDetailCard.dart';

class ScheduleManageList extends StatefulWidget {
  DoctorModel doctor;
  ScheduleManageList({Key key,this.doctor}):super(key:key);
  MagicManager manager= MagicManager();
  @override
  _ScheduleManageListState createState() => _ScheduleManageListState();
}

class _ScheduleManageListState extends State<ScheduleManageList> {
  List<ScheduleDetailModel> _scheduleList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scheduleList=widget.manager.scheduleList;
  }
  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      appBar: AppBar(
        title: Text('Manage Schedule'),
      ),
      body: */Container(
        margin: const EdgeInsets.all(16.0),
        child: ListView.builder
              (
                itemCount: _scheduleList.length,
                itemBuilder: ( ctxt, index) {
                  return  ScheduleDetailCard(scheduleDetail:_scheduleList[index]);
                }
            ),
              
          
       
    );
  }
}