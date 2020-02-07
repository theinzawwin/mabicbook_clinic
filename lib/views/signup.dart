import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magicbook_app/models/ClinicUserModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:quiver/strings.dart';
import 'package:http/http.dart' as http;
class SignUpPage extends StatefulWidget {
  MagicManager manager=new MagicManager();
  SignUpPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();

  var _passKey = GlobalKey<FormFieldState>();

  String _phone = "";
  String _name = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
       appBar: new AppBar(
          title: Text("Sign Up"),
        ),
      body:  Center (

              child: Form(
                        key: _formKey,
                        child: ListView(
                                  children: getFormWiget(),
                                  padding: EdgeInsets.all(30),
                        )
                      )
            )
    );
    
   
  }
        
  List<Widget> getFormWiget() {
    List<Widget> formWidget = new List();

    formWidget.add (
        new TextFormField(
          
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Phone No',hintText: '09 xxxxxxxxx'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please Enter Phone No.';
            }
            else return null;
          },
          onSaved: (value){
            setState(() {
              _phone = value;
            });
          },
        )
    );

    formWidget.add (
        new TextFormField(
          
          decoration: InputDecoration(labelText: 'Name',hintText: 'Name'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please Enter Your Name';
            }
            else return null;
          },
          onSaved: (value){
            setState(() {
              _name = value;
            });
          },
        )
    );

    formWidget.add (
        new TextFormField(
          key: _passKey,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password',hintText: 'Password'),
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
              _password = value;
            });
          },
        )
    );

    formWidget.add (
        new TextFormField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'Confirm Password',hintText: 'Confirm Password'),
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
          
        )
    );

   
    formWidget.add (
        new RaisedButton(
         color: Colors.blue,
         textColor: Colors.white,
         child: new Text("Sign Up"),
         onPressed: goSignUp,
        )
    );
         
      return formWidget;
    }
  
    
    goSignUp() async{
      if(_formKey.currentState.validate()){
         _formKey.currentState.save();
         try{

         
        print("Phone No ------" + _phone);
        print("Name-----------" + _name);
        print("Password ------" + _password);
        ClinicUserModel user= ClinicUserModel(name:_name,createdUser: _phone,phoneNo: _phone,status: 1,password: _password,photo: "",alertTo: _phone,f1: "",f2: "",f3: "",f4: "",f5: "",n1: 0,n2:0,n3:0,n4:0,n5:0);
        http.Response resp=await widget.manager.signUpUser(body:user.toJson());
        if(resp.statusCode==200){
          Map<String,dynamic> result=json.decode(resp.body);
          if(result['code']==MagicStatus.SUCCESS){
              ClinicUserModel cUser=ClinicUserModel.fromJson(result['data']);
              Fluttertoast.showToast(msg: "User Name ${cUser.name}",toastLength: Toast.LENGTH_LONG);
              Navigator.pushReplacementNamed(context, "/signin");
          }
          //  Fluttertoast.showToast(msg: resp.body,toastLength: Toast.LENGTH_LONG);
        }else{
          Fluttertoast.showToast(msg: "Error",toastLength: Toast.LENGTH_LONG);
        }
        }catch(ex){
            Fluttertoast.showToast(msg: "Internal Error "+ex,toastLength: Toast.LENGTH_LONG);
         }
      }
    }
  
}