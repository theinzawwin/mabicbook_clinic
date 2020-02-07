import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:magicbook_app/models/OtpModel.dart';
import 'package:magicbook_app/models/PasswordModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:quiver/strings.dart';


class ResetPassword extends StatefulWidget {
  OtpModel otpData;
  ResetPassword({Key key,this.otpData}):super(key:key);
  MagicManager manager= MagicManager();
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
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
                  Text("Please enter a new password",
                      style:TextStyle(color:Colors.grey[700],fontSize: 16.0,fontWeight: FontWeight.bold)
                  ),

                  SizedBox(height: 50.0,),

                  TextFormField(
                      controller: passwordController,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        hintText: '',
                        prefixIcon: Icon(Icons.lock) ,
                        suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                              //color: Theme.of(context).primaryColorDark,
                              ),
                            onPressed: () {
                              setState(() {
                                  passwordVisible = !passwordVisible;
                              });
                            },
                        ),
                      ),
                      validator: (value){
                        if(value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        else if(value.length<8){
                          return 'Password should not be less than 8 characters';
                        }
                        else return null;
                      },
                      onSaved: (value){
                        setState(() {
                          //_phone = value;
                        });
                      },
                  ),

                  SizedBox(height: 10.0,),

                  TextFormField(
                      key: _passKey,
                      controller: confirmPasswordController,
                      obscureText: confirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Re-enter Password',
                        hintText: '',
                        prefixIcon: Icon(Icons.lock) ,
                        suffixIcon: IconButton(
                            icon: Icon(
                              confirmPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                              //color: Theme.of(context).primaryColorDark,
                              ),
                            onPressed: () {
                              setState(() {
                                  confirmPasswordVisible = !confirmPasswordVisible;
                              });
                            },
                        ),
                      ),
                      validator: (value){
                        if(value.isEmpty) {
                          return 'Please Enter Confirm Password';
                        }
                        else if(value.length<8){
                          return 'Password should not be less than 8 characters';
                        }
                        else if(!equalsIgnoreCase(value, _passKey.currentState.value)) {
                          return 'Password Does Not Match';
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
                  child: Text('Reset Password'),
                  onPressed: () async{
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      resetPassword();
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

  void resetPassword() async {
    PasswordModel passwordData = new PasswordModel(phoneNo: widget.otpData.phoneNo,newPassword: passwordController.text.trim());
    print("OTP Code ${widget.otpData.otpCode}");
    http.Response response=await widget.manager.resetPassword(body:passwordData.toJson());
    if(response.statusCode==200){
        Map result=json.decode(response.body);
        if(result["code"]==MagicStatus.SUCCESS){
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
          Navigator.pushNamed(context, '/signin');
        }else if(result["code"]==MagicStatus.SAVE_ERROR){
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
        }else{
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
        }
        
    }
  }
}