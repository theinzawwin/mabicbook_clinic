import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:magicbook_app/models/ScheduleDetailModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
class NewScheduleDetail extends StatefulWidget {
 
  MagicManager manager= MagicManager();

  @override
  _NewScheduleDetailDetailState createState() => _NewScheduleDetailDetailState();
}
 class _NewScheduleDetailDetailState extends State<NewScheduleDetail>{
 final format = DateFormat("HH:mm a");
    final patientCountController = TextEditingController();
    String startTime;
    String endTime;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String dayOfWeek;
     String _dropdownError;
     String _patientCountError;
    List<String> dayList;
    List<DropdownMenuItem<String>> dayOfWeekDropDown;
  List<DropdownMenuItem<String>> getDayDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (String d in dayList) {
      items.add(
         DropdownMenuItem(
           
          value:d,
          child: Text(d)
        
      ));
    }
    return items;
  }
  @override
  void initState() {
    // TODO: implement initState
    dayList= widget.manager.daysOfWeek;
    dayList.insert(0, "All Days");
    dayOfWeekDropDown=getDayDropDown();
    
    super.initState();
  }
    void save(){
      ScheduleDetailModel sd=ScheduleDetailModel(dayOfWeek: dayOfWeek,maxPatientCount: int.parse(patientCountController.text),startTime: startTime,endTime: endTime,f1: "",f2:"",f3:"",f4:"",f5:"",n1:0,n2:0,n3:0,n4:0,n5:0);
      Navigator.pop(context, sd);
    }
    _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    if (dayOfWeek == null) {
      setState(() => _dropdownError = "Please select dayOfWeek!");
      _isValid = false;
    }
    if(patientCountController.text==null){
      
    }

    if (_isValid) {
      //form is valid
      save();
    }
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Schedule Time'),
        ),
        body:Container(
        padding: EdgeInsets.all(16.0),
       // height:  MediaQuery.of(context).size.height-50,
        //width: MediaQuery.of(context).size.width-50,
       
        child: SingleChildScrollView(
          child: Form(
            key:_formKey,
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    DropdownButton(   
                    isExpanded: true,              
                    value: dayOfWeek,
                      hint: Text('Select DayOfWeek'),
                      style: Theme.of(context).textTheme.title,
                      items:getDayDropDown() ,
                        onChanged: (val){
                          setState(() {
                           dayOfWeek=val; 
                          });
                        }
                   
                      
                    ),
             
                   
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                       mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 1.0,
                              onPressed: () {
                                DatePicker.showTimePicker(context,
                                    theme: DatePickerTheme(
                                      containerHeight: 210.0,
                                    ),
                                    showTitleActions: true,
                                    
                                    
                                    onConfirm: (date) {
                                  print('confirm $date');
                                  startTime ='${date.hour}:${date.minute}';
                                      //'${date.year} - ${date.month} - ${date.day}';
                                  setState(() {});
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                                    
                                  /*   final TimeOfDay timePicked = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),

                                    );
                                    if (timePicked != null)
                                      setState(() {
                                        _selectedTime = timePicked.replacing(hour: timePicked.hourOfPeriod);
                                      });
                                      */
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                child: Row(
                                 
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                Icons.date_range,
                                                size: 18.0,
                                              ),
                                              Text(
                                                " $startTime",
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
                                  ],
                                ),
                              ),
                              color: Colors.white,
                            ),
                        )
                        ,
                        SizedBox(
                          width: 20,
                        ),
                            Expanded(
                              child:  RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 1.0,
                              onPressed: () {
                                DatePicker.showTimePicker(context,
                                    theme: DatePickerTheme(
                                      containerHeight: 210.0,
                                    ),
                                    showTitleActions: true,
                                    
                                    
                                    onConfirm: (date) {
                                  print('confirm $date');
                                  endTime ='${date.hour}:${date.minute}';
                                      //'${date.year} - ${date.month} - ${date.day}';
                                  setState(() {});
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                                    
                                  /*   final TimeOfDay timePicked = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),

                                    );
                                    if (timePicked != null)
                                      setState(() {
                                        _selectedTime = timePicked.replacing(hour: timePicked.hourOfPeriod);
                                      });
                                      */
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
                                                " $endTime",
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
                                  ],
                                ),
                              ),
                              color: Colors.white,
                            ),
                            )
                           

                    ],)
                     ,
                     SizedBox(
                       height: 16.0,
                     ),
                     TextFormField(
                       controller: patientCountController,
                        keyboardType: TextInputType.number,
                       decoration: InputDecoration(
                         labelText: 'Patient Count',
                         hintText: '40 persons',
                         errorText: _patientCountError,
                       ),
                       validator: (val){
                         if(int.parse(val)==0){
                           return "Please type patient count";
                         }else{
                           return null;
                         }
                       },
                     ),
                     SizedBox(height: 16.0,),
                     SizedBox(
                       child: RaisedButton(
                          onPressed: (){
                              /*if (_formKey.currentState.validate()) {
                                bool _isValid = _formKey.currentState.validate();
                              _formKey.currentState.save();
                              //this.widget.presenter.onCalculateClicked(_weight, _height);
                              save();
                            }*/
                            _validateForm();
                          },
                          child:Text('Save'),
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                           color: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                                )
                        )
                         ,
                     )
                      
                    /* DateTimeField(
                      format: format,
                      
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.convert(time);
                      },
                    ),
                    */
                  ],
                ),
              ),
            ),
          ),
        ),
        )
      );
      
      
      
    
  }
 }