import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:magicbook_app/models/OtpModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:magicbook_app/views/OtpVerify.dart';

class OtpRequest extends StatefulWidget {
  MagicManager manager= MagicManager();
  @override
  _OtpRequestState createState() => _OtpRequestState();
}

class _OtpRequestState extends State<OtpRequest> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
           key: _formKey,
           child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                  SizedBox(height: 50.0,),
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Container(
                      width: 100.0,
                      height: 100.0,
                      child: CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          backgroundImage:AssetImage('images/doctor.png'), 
                        ),
                      ),
                    ], 
                  ),

                  SizedBox(height: 30.0,),

                  Text("Please enter your registered phone number",
                      style:TextStyle(color:Colors.grey[700],fontSize: 16.0,fontWeight: FontWeight.bold)
                  ),

                  SizedBox(height: 30.0,),
                  Text("We will sent One Time Password(OTP) on your mobile to reset your password.",
                      style:TextStyle(color:Colors.grey,fontSize: 16.0)
                  ),

                  SizedBox(height: 50.0,),

                  TextFormField(
                      controller: phoneNoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone No',
                        hintText: '',
                        prefixIcon: Icon(Icons.phone,) ,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Type Phone No';
                        }
                        else return null;
                      },
                      onSaved: (value){
                        setState(() {
                          //_phone = value;
                        });
                      },
                  ),

                SizedBox(height: 30.0,),

                RaisedButton(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Text('Send'),
                  onPressed: () async{
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      //this.widget.presenter.onCalculateClicked(_weight, _height);
                      sendOTP();
                    }
                  },
                ) ,

              ],
            ),
           ),
        ),
        )
        
      ),
    );
  }

  void sendOTP() async {
    OtpModel otpData = new OtpModel(phoneNo: phoneNoController.text.trim());

    http.Response response=await widget.manager.sendOTP(body:otpData.toJson());
    if(response.statusCode==200){
        Map result=json.decode(response.body);
        if(result["code"]==MagicStatus.SUCCESS){
          otpData = OtpModel.fromJson(result["data"]);
          print("OTP Code Id ${otpData.key}");
          //Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
          Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerify(otpData: otpData,)));
        }else if(result["code"]==MagicStatus.SAVE_ERROR){
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
        }else{
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
        }
        
    }
  }
}