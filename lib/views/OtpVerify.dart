import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:magicbook_app/models/OtpModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:magicbook_app/views/ResetPassword.dart';

class OtpVerify extends StatefulWidget {
  OtpModel otpData;
  OtpVerify({Key key,this.otpData}):super(key:key);
  MagicManager manager= MagicManager();

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final otpCodeController = TextEditingController();

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

                  Text("Please enter your verification code",
                      style:TextStyle(color:Colors.grey[700],fontSize: 16.0,fontWeight: FontWeight.bold)
                  ),

                  SizedBox(height: 30.0,),

                  Text("One Time Password(OTP) has been sent to your mobile number, please enter the same "+ 
                   "here to reset your password.",
                      style:TextStyle(color:Colors.grey,fontSize: 16.0)
                  ),

                  SizedBox(height: 50.0,),

                  TextFormField(
                      controller: otpCodeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'OTP Code',
                        hintText: '',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Type OTP Code';
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
                  child: Text('Verify'),
                  onPressed: () async{
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      verifyOTP();
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

   void verifyOTP() async {
    //OtpModel otpData = new OtpModel(phoneNo: phoneNoController.text.trim());
    widget.otpData.otpCode = otpCodeController.text.trim();
    print("OTP Code ${widget.otpData.otpCode}");
    http.Response response=await widget.manager.verifyOTP(body:widget.otpData.toJson());
    if(response.statusCode==200){
        Map result=json.decode(response.body);
        if(result["code"]==MagicStatus.SUCCESS){
          widget.otpData = OtpModel.fromJson(result["data"]);
          print("OTP Code Id ${widget.otpData.key}");
          //Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
          Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(otpData: widget.otpData,)));
        }else if(result["code"]==MagicStatus.SAVE_ERROR){
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
        }else{
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
        }
        
    }
  }
}