import 'package:flutter/material.dart';
import 'package:magicbook_app/models/BookingDoctorDetailModel.dart';
import 'package:magicbook_app/views/BookingDetail.dart';

class BookingDoctorCard extends StatelessWidget {
  final BookingDoctorDetailModel booking;
  String bookingDate;
  int clinicId;
  BookingDoctorCard({Key key,this.booking,this.bookingDate,this.clinicId}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2.0,
       
        child:Padding(
          padding: const EdgeInsets.all(1.0),
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           
            Row(
              
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               
               Expanded(
                  child:  Text(booking.doctorName,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),overflow: TextOverflow.visible,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                     Text('Max Patient Count: ',style: TextStyle(fontSize: 16.0),overflow: TextOverflow.ellipsis),
                      Text("${booking.maxPatientCount}",style: TextStyle(fontSize:16.0,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
                  ],
                ),
            
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
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                
                  onPressed: (){                  
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingDetail(clinicId: clinicId,bookingDate: bookingDate,doctorId: booking.doctorId,status: 1,)), //ScheduleDetail
                    );
                  },
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Pending',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.blue), ),
                      Text("${booking.pendingCount}",textAlign: TextAlign.center,style:TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    if(booking.acceptCount>0){
                       Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingDetail(clinicId: clinicId,bookingDate: bookingDate,doctorId: booking.doctorId,status: 2,)), //ScheduleDetail
                    );
                    }
                    
                  },
                  child:Column(
                    children: <Widget>[
                      Text('Accept',style: TextStyle(fontSize: 18.0,color: Colors.green),),
                      Text("${booking.acceptCount}",style:TextStyle(color: Colors.green)),
                    ],
                  ), 
                ),
                
                FlatButton(
                  onPressed: (){
                    if(booking.rejectCount>0){
                       Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingDetail(clinicId: clinicId,bookingDate: bookingDate,doctorId: booking.doctorId,status: 3,)), //ScheduleDetail
                    );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Reject',style: TextStyle(fontSize: 18.0,color: Colors.red),),
                      Text("${booking.rejectCount}",textAlign: TextAlign.center,style: TextStyle(color: Colors.red),),
                    ],
                  ),
                )
               
               
                /*Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Text('Max Patient',style: TextStyle(fontSize: 18.0),),
                      Text("${booking.maxPatientCount}"),
                    ],
                  ),
                )
                  */
                 
              ],
            ),
            SizedBox(height: 10.0,)
          ],
        ) ,
        ) ,
      ),
    );
  }
}