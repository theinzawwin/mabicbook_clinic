import 'package:flutter/material.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/views/DoctorCard.dart';
import 'package:magicbook_app/views/ScheduleDetail.dart';

import 'DoctorDropDownCard.dart';
import 'ScheduleListTab.dart';
import 'ScheduleManageList.dart';

class ScheduleList extends StatefulWidget {
  final MagicManager manager= MagicManager();
  @override
  _ScheduleListState createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _doctorId;
  ClinicModel clinicModel;
  Future<List<DoctorModel>> doctorList;
  List<DropdownMenuItem<int>> doctorDropDownList;
  List<DropdownMenuItem<int>> getDoctorDropDown() {
    List<DropdownMenuItem<int>> items = new List();
    for (DoctorModel t in widget.manager.dotorList) {
      items.add(
         DropdownMenuItem(
           
          value:t.id,
          child: DoctorDropDownCard(doctor: t,)
        
      ));
    }
    return items;
  }
  void changeDoctor(int value){
    setState(() {
     _doctorId=value;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    //doctorDropDownList=getDoctorDropDown();
    widget.manager.getClinicInfo().then(       
        (val){
          setState(() {
          clinicModel = val;
         doctorList= widget.manager.getDoctorList(clinicModel.id);
        });
        }
    );
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule List')
      ),
      body: Container(
      margin: const EdgeInsets.all(16.0),
      child: FutureBuilder<List<DoctorModel>>(
        future: doctorList,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder
              (
                itemCount: snapshot.data.length,
                itemBuilder: ( ctxt, index) {
                  DoctorModel doctor=snapshot.data[index];
                  return GestureDetector(
                    child: DoctorCard(doctor:doctor),
                    onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScheduleListTab(doctor: doctor,)), //ScheduleDetail
                    );
                  },
                  );
               
                }
            );
          }
         
        return CircularProgressIndicator();
        }
       
        ),
         
      ), 
     floatingActionButton:  FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
        Navigator.pushNamed(context, '/newSchedule');
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.green,
      ),
      
    );
  }
}