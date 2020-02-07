import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/ClinicUserModel.dart';
import 'package:magicbook_app/models/township_model.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:http/http.dart' as http;
import 'package:magicbook_app/util/MagicStatus.dart';
class ClinicProfile extends StatefulWidget {
  MagicManager manager= MagicManager();
 
  @override
  _ClinicProfileState createState() => _ClinicProfileState();
}

class _ClinicProfileState extends State<ClinicProfile> {
 Future<ClinicUserModel> user;
 ClinicUserModel cUser;
 List<TownshipModel> tspList=new List<TownshipModel>();
  final nameEngController = TextEditingController();
  final nameMyanController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final townshipController = TextEditingController();
  final doctorCountController = TextEditingController();
  final userCountController = TextEditingController();
  int tonwnshpId,clinicId;
  List<DropdownMenuItem<int>> getTownshipDropdown() {
    List<DropdownMenuItem<int>> items = new List();
    for (TownshipModel township in tspList) {
      items.add(
         DropdownMenuItem(
           
          value:township.id,
          child: new Text(township.nameEng),
        
      ));
    }
    return items;
  }
  String validateName(String value) {
    if (value.length < 1)
      return 'Please type clinic name(eng)';
    else
      return null;
  }
  void changeTownship(int value){
    setState(() {
     tonwnshpId=value;
    });
  }
    
  _fetchData(){
    setState(() {
        widget.manager.getClinicUser().then((val)=>
    
    this.cUser=val
    );
    widget.manager.getTownshipList().then((val)=>this.tspList=val);
    });
   
  }
  @override
  void initState() {
    // TODO: implement initState

  
     _fetchData(); 
  
    super.initState();
    
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clinic Profile'),
      ),  
      body: Container(
        margin: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0,bottom: 0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
              
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                TextFormField(
                  controller: nameMyanController,
                  decoration: InputDecoration(
                    labelText: 'Clinic Name(Myanmar)',
                    hintText: 'Please Fill Clinic Name'
                  ),
                  validator:validateName,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: nameEngController,
                  decoration: InputDecoration(
                    labelText: 'Clinic Name(Eng)',
                    hintText: 'Please fill clinic name(Eng)'
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                
                DropdownButton<int>(
                  
                  value: tonwnshpId,
                  hint: Text('Select Township'),
                 style: Theme.of(context).textTheme.title,
                 items:getTownshipDropdown() ,
                  onChanged: changeTownship
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: doctorCountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Doctor Count',
                    hintText: 'Please fill doctor count'
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: userCountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'User Count',
                    hintText: 'Please fill user count'
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Other Info',textAlign:TextAlign.center,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText: 'Phone Number',labelText: 'Phone Number'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: addressController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            hintText: 'Address'
                          ),
                          validator: (val){
                            if(val.length==0){
                              return "Please type Address";
                            }else{
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          onPressed: () async{
                              if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              saveClinic();
                              //this.widget.presenter.onCalculateClicked(_weight, _height);
                            }
                          },
                          child: clinicId !=0? Text('Save'):Text('Update'),
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                          // color: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                                )
                        )
                
                
            
            ],

          ),
              ) 
            )
             
          )
         
      
      ),  
    );
  }
  saveClinic() async{
    try{
       ClinicModel clinic= ClinicModel(createdUser: cUser.phoneNo,modifiedUser: cUser.phoneNo,nameMyan: nameMyanController.text,nameEng: nameEngController.text,doctorCount: int.parse(doctorCountController.text),userCount: int.parse(userCountController.text),address: addressController.text,phone: phoneController.text,township_id: tonwnshpId,f1: "",f2:"",f3:"",f4:"",f5:"",n1:0,n2:0,n3:0,n4:0,n5:0);
    http.Response res=await widget.manager.saveClinic(body:clinic.toJson(),townshipId: tonwnshpId);
    if(res.statusCode==200){
        Map result=json.decode(res.body);
        if(result["code"]==MagicStatus.SUCCESS){
          ClinicModel clinic=ClinicModel.fromJson(result["data"]);
          print("Clinic Saved Id ${clinic.id}");
          Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
        }
        
      }
    }catch(e){
      Fluttertoast.showToast(msg: "Error ",toastLength: Toast.LENGTH_LONG);
      print(e);
    }
   
  }
}
