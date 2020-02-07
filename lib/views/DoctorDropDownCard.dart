import 'package:flutter/material.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/models/DoctorModel.dart';

class DoctorDropDownCard extends StatelessWidget {
  final DoctorModel doctor;
  DoctorDropDownCard({Key key,this.doctor}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
      elevation: 1.0,
      
      child:Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(doctor.name,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
          SizedBox(width: 10,),
          Text('(${doctor.sama})',style: TextStyle(fontSize: 14.0,color: Colors.black87),overflow: TextOverflow.ellipsis)
        ],
      ),
      ) 
    ),
    );
    
  }
}