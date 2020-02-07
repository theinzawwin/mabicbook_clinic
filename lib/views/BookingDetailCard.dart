import 'package:flutter/material.dart';
import 'package:magicbook_app/models/BookingDoctorDetailModel.dart';
import 'package:magicbook_app/models/BookingModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';

class BookingDetailCard extends StatelessWidget {

 // final MagicManager manager= MagicManager();
  final ValueChanged<BookingModel> onUpdateStatus;
  final BookingModel bookingDetail;
  
    updateStatus(int status){
      bookingDetail.status=status;
      onUpdateStatus(bookingDetail);
    }
  BookingDetailCard({Key key,this.bookingDetail,@required this.onUpdateStatus}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child:/*Card(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(bookingDetail.patientName),
            Text("Age: ${bookingDetail.patientAge}"),
            Text("Gender: ${bookingDetail.patientGender}"),
            RaisedButton(
              onPressed: onUpdateStatus,
              child: Text('Acept'),
            )
          ],
        )
        ,
      )*/
       Card(
        elevation: 2.0,
       
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           
            Row(
              
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               
               Expanded(
                  child:  Text('${bookingDetail.startTime}- ${bookingDetail.endTime}',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),overflow: TextOverflow.visible,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  
                     Text('Max Patient Count: ',style: TextStyle(fontSize: 16.0),overflow: TextOverflow.ellipsis),
                      Text("${bookingDetail.maxPatientCount}",style: TextStyle(fontSize:16.0,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
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
                Expanded(
                  child: GestureDetector(
                  onTap: (){
                      
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingDetail(clinicId: clinicId,bookingDate: bookingDate,doctorId: booking.doctorId,status: 1,)), //ScheduleDetail
                    );
                    */
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${bookingDetail.patientName}',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                      Text("${bookingDetail.patientGender}",textAlign: TextAlign.center,),
                      Text("${bookingDetail.patientAge}",textAlign: TextAlign.center,),
                       Text("${bookingDetail.patientPhoneNo}",textAlign: TextAlign.center,),
                    ],
                  ),
                ),
                )
                ,
               /*Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                    onPressed: (){
                      updateStatus(2);
                    },
                    child: Text('Accept'),
                     padding: EdgeInsets.fromLTRB(3, 3, 3, 3)
                  ),
                  
             
               RaisedButton(
                
                    onPressed: (){

                    },
                    child: Text('Reject') ,
                    padding: EdgeInsets.fromLTRB(3, 3, 3, 3)
                  ),
               
                    ]
               )
               */
                
               /* Expanded(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Reject',style: TextStyle(fontSize: 18.0),),
                      Text("${booking.acceptCount}",textAlign: TextAlign.center,),
                    ],
                  ),
                ),*/
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
            SizedBox(
              height: 10.0,
            ),
           
            bookingDetail.status==1? Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:  RaisedButton(
                    color: Colors.green,
                    onPressed: (){
                      updateStatus(2);
                    },
                    child: Text('Accept'),
                     padding: EdgeInsets.fromLTRB(3, 3, 3, 3)
                  ),
                )
                  ,
                  SizedBox(
                    width: 5.0,
                  ),
                  
              Expanded(
                child: RaisedButton(
                    color: Colors.red,
                    onPressed: (){
                      updateStatus(3);
                    },
                    child: Text('Reject') ,
                    padding: EdgeInsets.fromLTRB(3, 3, 3, 3)
                  ),
              )
               ,
              ]
            ):Container(),
            SizedBox(height: 5.0,)
          ],
        ) ,
        ) ,
      ),
    );
  }
}