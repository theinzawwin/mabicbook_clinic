import 'package:flutter/material.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/TodayScheduleModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/views/TodayScheduleCard.dart';

class TodayScheduleList extends StatefulWidget {
  final MagicManager manager= MagicManager();
  ClinicModel clinicModel;
  TodayScheduleList({Key key,this.clinicModel}):super(key:key);
  @override
  _TodayScheduleListState createState() => _TodayScheduleListState();
}

class _TodayScheduleListState extends State<TodayScheduleList> {
  Future<List<TodayScheduleModel>> todayScheduleList;

  @override
  void initState() {
    // TODO: implement initState
    todayScheduleList=widget.manager.getTodayScheduleList(widget.clinicModel.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today Schedule'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child:FutureBuilder<List<TodayScheduleModel>>(
        future: todayScheduleList,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder
              (
                itemCount: snapshot.data.length,
                itemBuilder: ( ctxt, index) {
                  
                  return TodayScheduleCard(today:snapshot.data[index]);
                    
                  },
                  );
              
          
          }
         
        return CircularProgressIndicator();
        }
       
        ),
      ),
    );
  }
}