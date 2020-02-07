import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:magicbook_app/models/BookingDoctorDetailModel.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/views/BookingDoctorCard.dart';
import 'package:http/http.dart' as http;
class BookingListTest extends StatefulWidget {
  ClinicModel clinicModel;
  BookingListTest({Key key,this.clinicModel}):super(key:key);
  MagicManager manager= MagicManager();
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingListTest> with  WidgetsBindingObserver{
   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String _bookDate;
   final df = new DateFormat("yyyy-MM-dd");
   
  List<BookingDoctorDetailModel> bookingDetailList;
  showDateByBookingList(String date) async{
    widget.manager.getBookingDoctorDetailList(clinicId:3,bookingDate: date).then((val){
     setState(() {
      http.Response response=val;
      if(response.statusCode==200){
        Map result=json.decode(response.body);
        if(result["data"]!=null){
        
            List<dynamic> body=result["data"];
             
            bookingDetailList=body
          .map(
            (dynamic item) => BookingDoctorDetailModel.fromJson(item),
          )
          .toList();
         
          
        }else{
         
           bookingDetailList=[]; 
        
        }
      }
       });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
  
    super.initState();
     WidgetsBinding.instance.addObserver(this);
      _bookDate=df.format(DateTime.now());
    showDateByBookingList(_bookDate);
  }
  @override
  void dispose() {
    // TODO: implement dispose
     WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("APP_STATE: $state");

    if(state == AppLifecycleState.resumed){
      // user returned to our app
     print("APP_STATE: $state");
    }else if(state == AppLifecycleState.inactive){
      // app is inactive
    }else if(state == AppLifecycleState.paused){
      // user quit our app temporally
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Text('Booking'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child:SingleChildScrollView(
            key:_formKey ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
       children:<Widget>[
         Card(
           child:  Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.max,
           children: <Widget>[
            // DateTimeField()           
                      Expanded(                        
                          child:RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 1.0,
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    theme: DatePickerTheme(
                                      containerHeight: 210.0,
                                    ),
                                    showTitleActions: true,
                                    minTime: DateTime(1997, 1, 1),
                                    maxTime: DateTime(2022, 12, 31),
                                    onConfirm: (date) {
                                 // print('confirm $date');
                                 
                                     // '${date.year}-${date.month}-${date.day}';
                                  setState(() {
                                     _bookDate =df.format(date);
                                     showDateByBookingList(_bookDate);
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.date_range,
                                                size: 18.0,
                                              ),
                                              Text(
                                                " $_bookDate",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Icon(
                                    Icons.search
                                    )
                                  ],
                                ),
                              ),
                              color: Colors.white,
                            ), 
                        )
           ],
         ),
         )
        ,
              
            Container(
            
              child: bookingDetailList!=null? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
           itemCount: bookingDetailList.length,
                itemBuilder: ( ctxt, index) {
                  return  BookingDoctorCard(booking:bookingDetailList[index],bookingDate: _bookDate,clinicId: widget.clinicModel.id,);
                }
        ):CircularProgressIndicator(),
             ) 
            
          ],
      
     ),
        )
      
      ) 
    );
  }
}