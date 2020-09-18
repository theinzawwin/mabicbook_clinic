import 'package:flutter/material.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/models/ScheduleDetailModel.dart';
import 'package:magicbook_app/models/ScheduleModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/views/ScheduleDetail.dart';
import 'package:magicbook_app/views/ScheduleManageList.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ScheduleListTab extends StatefulWidget {
  DoctorModel doctor;
 
  ScheduleListTab({Key key,this.doctor}):super(key:key);
  MagicManager manager= MagicManager();
  @override
  _ScheduleListTabState createState() => _ScheduleListTabState();
}

class _ScheduleListTabState extends State<ScheduleListTab> with SingleTickerProviderStateMixin {
   // ProgressDialog pr;
   TabController _tabController;
   ClinicModel clinicModel;
   List<ScheduleDetailModel> detailList;
   ScheduleModel scheduleModel;
   @override
  void initState() {
    // TODO: implement initState
    /*pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
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
        pr.show();
        */
     widget.manager.getClinicInfo().then(       
        (val){
          setState(() {
          clinicModel = val;
       widget.manager.getScheduleListByDoctorAndClinic(clinicId:clinicModel.id, doctorId:widget.doctor.id).then(
         (val){
           setState(() {
             scheduleModel=val;

               detailList=scheduleModel!=null ?scheduleModel.details:[];
               print('Schedule Detail List ${detailList.length}');
             //  pr.dismiss();
           });
         }
       );
                
        }
          );
        }
        
    );
     _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.doctor.name} Schedule"),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
          new Tab(icon: new Icon(Icons.schedule),text: 'Manage Schedule'),
          new Tab(
            icon: new Icon(Icons.calendar_today),text: 'Schedule Calendar',
          )
         
        ],
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,),
        bottomOpacity: 1,
      ),
      body: TabBarView(
          children: [
            ScheduleDetail(scheduleModel:scheduleModel,),
            ScheduleManageList(doctor: widget.doctor,scheduleList: detailList),
      ],
      controller: _tabController,),
    );
  }
}