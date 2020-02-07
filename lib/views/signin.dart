import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/ClinicUserModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:progress_dialog/progress_dialog.dart';
class SignInPage extends StatefulWidget {
  MagicManager manager= MagicManager();
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  ProgressDialog pr;

  final _formKey = GlobalKey<FormState>();

  var phoneNo = GlobalKey<FormFieldState>();
  var password = GlobalKey<FormFieldState>();
  bool passwordVisible = true;
  String _errorMessage = "";
  String _phone = "";
  String _password = "";

  void showError(String value){
    setState(() {
     _errorMessage = value; 
    });
  }

  
@override
  void initState() {
    // TODO: implement initState
   /* List<DateTime> dateList= calculateDaysInterval(DateTime.now(), DateTime(2019,12,30));
dateList.map((val)=>print(val)).toList();
*/
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
   
     pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
     pr.style(message: 'Showing some progress...');
    
    //Optional
    pr.style(
          message: 'Please wait...',
          borderRadius: 10.0,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progressTextStyle: TextStyle(
              color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
          messageTextStyle: TextStyle(
              color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
        ); 
    return new Scaffold(
        
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

                    SizedBox(height: 70.0,),
                    
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

                    SizedBox(height: 10.0,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: <Widget>[
                                  Text('magic', style:TextStyle(fontStyle: FontStyle.italic,color:Colors.grey[700],fontSize: 25.0, fontWeight: FontWeight.bold)),
                                  Text('Book', style:TextStyle(color:Colors.green[700],fontSize: 25.0, fontWeight: FontWeight.bold))   
                              ],
                            ),
                        )
                      ],
                    ),

                    SizedBox(height: 20.0),

                    Text('$_errorMessage', 
                          style:TextStyle(color:Colors.red[700],fontSize: 16.0, fontWeight: FontWeight.bold)
                    ),
                    
                    SizedBox(height: 20.0),

                    /* Text('Sign In', 
                          style:TextStyle(color:Colors.grey[700],fontSize: 25.0,fontWeight: FontWeight.bold)
                    ),
                    
                    SizedBox(height: 30.0), */
                    
                    new TextFormField(
                        key: phoneNo,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Phone No',
                          hintText: '',
                          prefixIcon: Icon(Icons.phone,) ,
                          
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Type Phone Number';
                          }
                          else return null;
                        },
                        onSaved: (value){
                          setState(() {
                            _phone = value;
                          });
                        },
                    ),
                    
                    SizedBox(height: 20.0),

                    new TextFormField(
                        key: password,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: "",
                          prefixIcon: Icon(Icons.lock,) ,
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
                          else return null;
                        },
                        onSaved: (value){
                          setState(() {
                            _password = value;
                          });
                        },
                    ),
                    
                    SizedBox(height: 30.0),

                    new RaisedButton(
                            color: Colors.green,
                            //textColor: Colors.white,
                            child: new Text("Sign In"),
                            onPressed: goSignIn,

                    ),

                    SizedBox(height: 30.0),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            //decoration: TextDecoration.underline,
                            child: Text("Forgot password?", 
                            style: TextStyle( color: Colors.blue, fontSize: 16.0, fontWeight:FontWeight.bold,)),
                            onTap: forgotPassword
                          ),
                          GestureDetector(
                              child: Text("Register?", 
                              style: TextStyle( color: Colors.blue, fontSize: 16.0, fontWeight:FontWeight.bold,)),
                              onTap: signUp
                          ),
                        ],
                      )
                    
                ],
              ),
            ),
          ),
          )
        ),
        
    );
    
   
  }
        
  
   
    goSignIn() async{
      if(_formKey.currentState.validate()){
         _formKey.currentState.save();
        pr.show();
              
        
        try{
          ClinicUserModel user=ClinicUserModel(phoneNo: _phone,password: _password);
          http.Response res=await widget.manager.signIn(body:user.toJson());
          if(res.statusCode==200){
            Map<String,dynamic> result=json.decode(res.body);
            String code=result["code"];
            if(code==MagicStatus.SUCCESS){
              ClinicUserModel user=ClinicUserModel.fromJson(result['data']);
              Map clinicMap=result['data']['clinic'];
              print('$clinicMap');
              if(clinicMap!=null){
                widget.manager.saveClinicInfo(clinicMap);
                ClinicModel clinic=await widget.manager.getClinicInfo();
            
                }
                ClinicModel clinic=await widget.manager.getClinicInfo();
                if(clinic!=null)
                  print("Clinic${clinic.toJson()} ");

            widget.manager.saveClinicUser(user.toJson());
             ClinicUserModel auser=await widget.manager.getClinicUser();
            Fluttertoast.showToast(msg: "Success "+auser.phoneNo,toastLength: Toast.LENGTH_LONG);
             if(pr.isShowing())
                  pr.hide();
                print("PR status  ${pr.isShowing()}" );
                 Navigator.pushNamed(context, '/dashboard');
            }else if(code==MagicStatus.SAVE_ERROR){
              setState(() {
               _errorMessage=result["desc"]; 
              });
             // showMessage(context);
             showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                
                content: Text("${result["desc"]}"),
                actions: [
                // okButton,
                ],
              );
                },
              );
              Fluttertoast.showToast(msg: result["desc"],toastLength: Toast.LENGTH_LONG);
              if(pr.isShowing())
                  pr.hide();
            }else if(code==MagicStatus.BAD_REQUEST){
               Fluttertoast.showToast(msg: "Please check your information!",toastLength: Toast.LENGTH_LONG);
            }
            if(pr.isShowing())
                  pr.hide();
                print("PR status  ${pr.isShowing()}" );
          }else{

              Fluttertoast.showToast(msg: "Error "+res.body,toastLength: Toast.LENGTH_LONG);
          }
        }on Exception catch(e){

          print("Error :$e");
            if(pr.isShowing())
                  pr.hide();
                print("PR status  ${pr.isShowing()}" );
          //    Fluttertoast.showToast(msg: "Exception "+e.,toastLength: Toast.LENGTH_LONG);
        }
      }
     
     
    }

  
  
 signUp(){
    Navigator.pushNamed(context, '/signup');
  }

  forgotPassword(){
    Navigator.pushNamed(context, '/otpRequest');
  }
}

