
import 'package:flutter/material.dart';
import 'package:magicbook_app/models/TodayScheduleModel.dart';

class TodayScheduleCard extends StatelessWidget {
  final TodayScheduleModel today;
  TodayScheduleCard({Key key,this.today}):super(key:key);
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
              
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               Text('From '),
               Text('${today.startTime} ',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),overflow: TextOverflow.visible,),
               Text('- To '),
               Text('${today.endTime}',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),overflow: TextOverflow.visible,)
               /*Expanded(
                  child:  Text('${today.startTime}- ${today.endTime}',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),overflow: TextOverflow.visible,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  
                     Text('Max Patient Count: ',style: TextStyle(fontSize: 16.0),overflow: TextOverflow.ellipsis),
                      Text("${bookingDetail.maxPatientCount}",style: TextStyle(fontSize:16.0,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
                  ],
                ),
              */
              ],
            )
            ,
            Divider(
              color: Theme.of(context).primaryColor,
              height: 15,
              thickness: 1.0,
            ),
            SizedBox(
              height: 10.0,
            ),
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
                        Text(today.doctorName, style: TextStyle(color: Colors.deepPurple,fontSize: 20.0,fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.0,),
                        Text(today.sama,style:Theme.of(context).textTheme.subtitle),
                        SizedBox(height: 5,),
                        Text(today.degree,style:Theme.of(context).textTheme.subtitle),
                        
                    ],
                  ),
                ),
               
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