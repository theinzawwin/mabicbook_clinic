import 'package:flutter/material.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  DoctorCard({Key key,this.doctor}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
      margin: const EdgeInsets.all(4.0),
      
      child:Padding(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                 width: 75.0,
                  height: 75.0,
                child: CircleAvatar(
                
                backgroundImage:AssetImage('images/doctor.png'), /*Image(
                  image:AssetImage('images/doctor.png'),
                  height: 100,
                ),*/
                
              ),
              )
              
              ,
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(doctor.name, style: TextStyle(color: Colors.deepPurple,fontSize: 18.0)),
                        SizedBox(height: 5,),
                        Text(doctor.degree,style:Theme.of(context).textTheme.body1),
                        SizedBox(height: 10.0,),
                        Text(doctor.sama,style:Theme.of(context).textTheme.body1)
                    ],
                  ),
                )
            ],
          )
         ,
          
        ],
      ), padding: const EdgeInsets.all(10.0),
      ) 
    ),
    );
  }
}