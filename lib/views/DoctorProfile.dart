import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/ClinicUserModel.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/models/SpecialityModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class DoctorProfile extends StatefulWidget {
   MagicManager manager= MagicManager();
  DoctorModel doctorModel;
  DoctorProfile({Key key,this.doctorModel}):super(key:key);
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
  
}
class _DoctorProfileState extends State<DoctorProfile>{

   ClinicUserModel cUser;
   ProgressDialog pr;
   List<SpecialityModel> specialityList;
    bool _isUploading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final samaController = TextEditingController();
    final degereeController = TextEditingController();
    final phoneController = TextEditingController();
    int specialId;
    int doctorId;
    ClinicModel _clinicModel;
    String _dropdownError;
    File _imageFile;
    List<DropdownMenuItem<int>> getSpecialDropDown() {
    List<DropdownMenuItem<int>> items = new List();
    if(specialityList!=null){
      for (SpecialityModel t in specialityList) {
      items.add(
         DropdownMenuItem(
           
          value:t.id,
          child:  Text('${t.nameMyan }( ${t.nameEng})',overflow: TextOverflow.ellipsis,))
        
      );
    }
    }
    
    return items;
  }
  String validateName(String value) {
    if (value.length < 1)
      return 'Please type clinic name(eng)';
    else
      return null;
  }
  void changeSpeciality(int value){
    setState(() {
     specialId=value;
    });
  }
void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }
      void _getImage(BuildContext context, ImageSource source) async {
        File image = await ImagePicker.pickImage(source: source);
        setState(() {
          _imageFile = image;
        });
        // Closes the bottom sheet
        Navigator.pop(context);
      }
      Widget _buildUploadBtn() {
    Widget btnWidget = Container();
    if (_isUploading) {
      // File is being uploaded then show a progress indicator
      btnWidget = Container(
          margin: EdgeInsets.only(top: 10.0),
          child: CircularProgressIndicator());
    }/* else if (!_isUploading && _imageFile != null) {
      // If image is picked by the user then show a upload btn
      btnWidget = Container(
        margin: EdgeInsets.only(top: 10.0),
        child: RaisedButton(
          child: Text('Upload'),
          onPressed: () {
            _startUploading();
          },
          color: Colors.pinkAccent,
          textColor: Colors.white,
        ),
      );
    }*/
    return btnWidget;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.manager.getClinicUser().then((val)=>this.cUser=val);
    widget.manager.getClinicInfo().then(       
        (val){
          setState(() {
          _clinicModel = val;
        });
        }
    );
    widget.manager.getAllSpeciality().then((val){
      setState(() {
       specialityList=val; 
      });
    }
    
    );
    setState(() {
       nameController.text=widget.doctorModel.name;
    degereeController.text=widget.doctorModel.degree;
    samaController.text=widget.doctorModel.sama;
    phoneController.text=widget.doctorModel.phoneNo;
    specialId=widget.doctorModel.speciality.id;
    print("Spciality $specialId");
    });
   
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Doctor'),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                      Card(
                        
                        child: Row(
                        children: <Widget>[
                          _imageFile == null
                              ? Text('Please pick an image')
                              : Container(
                                padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                border: Border.all(
                                color: Theme.of(context).accentColor,
                                width: 2,
                              )),
                                child:widget.doctorModel.id!=0?Image.file(
                                  _imageFile,
                                  fit: BoxFit.fill,
                                  height: 100.0,
                                  alignment: Alignment.center,
                                  
                                  width: 100.0//MediaQuery.of(context).size.width,
                                ):NetworkImage(
                                  widget.doctorModel.profilePhoto
                                ) ,
                              ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                            child: OutlineButton(
                              onPressed: () => _openImagePickerModal(context),
                              borderSide:
                                  BorderSide(color: Theme.of(context).accentColor, width: 1.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.camera_alt,size:48.0,),
                                 /* SizedBox(
                                    width: 5.0,
                                  ),
                                  Text('Add Image'),
                                  */
                                ],
                              ),
                            ),
                          ),
                          
                          _buildUploadBtn(),
                        ],
                         ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Doctor Name',
                          hintText: 'Doctor Name'
                        ),
                        validator: (val){
                          if(val.isNotEmpty){
                            return null;
                          }else{
                            return "Please type Doctor Name";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: samaController,
                        decoration: InputDecoration(
                          labelText: 'Sama',
                          hintText: ''
                        ),
                        validator: (val){
                          if(val.isNotEmpty){
                           return null;
                          }else{
                             return "Please type sama";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                     //FittedBox( fit: BoxFit.fill,child:
                     DropdownButtonHideUnderline(
                      
                    child:
                      DropdownButton<int>(
                  
                        value: specialId,
                        hint: Text('Select Sepciality'),
                     
                      items:getSpecialDropDown() ,
                        onChanged: changeSpeciality
                      )),
                      //),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: degereeController,
                        decoration: InputDecoration(
                          labelText: 'Degree',
                          hintText: 'Eg..M.B.;B.S'
                        ),
                        validator: (val){
                          if(val.isEmpty){
                            return "Please type degree";
                          }else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone ',
                          hintText: 'Eg: 09799234'
                        ),
                        validator: (val){
                          /*if(val.isEmpty){
                            return "Please type phone no.";
                          }else{
                            return null;
                          }
                          */
                        },
                      ),
                      
                      SizedBox(
                        height: 10.0,
                
                      ),
                      RaisedButton(
                          onPressed: () async{
                              bool _isValid=_formKey.currentState.validate();
                            if (specialId == null) {
                                setState(() => _dropdownError = "Please select dayOfWeek!");
                                _isValid = false;
                              }
                              if (_isValid) {

                              _formKey.currentState.save();
                              //this.widget.presenter.onCalculateClicked(_weight, _height);
                              saveDoctor();
                            }
                          },
                          child: doctorId !=0? Text('Save'):Text('Update'),
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),                        
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                                )
                        )

                  ],
                ) ,
                
                  
                )
                 ,
              ),
           
        ),
      ),
    );
  }
  saveDoctor()async{
    // to change speciality id
     try{
    if(_imageFile!=null){
      pr.show();   
     http.Response uploadResponse=await widget.manager.uploadFile(image: _imageFile,path: "doctor");
     if(uploadResponse.statusCode==200){
        Map uploadResult=json.decode(uploadResponse.body);
        if(uploadResult["code"]==MagicStatus.SUCCESS){
          String photoPath=uploadResult["data"];
          postDoctor(photoPath);
        }
     }else{

     }
    }else{
      Fluttertoast.showToast(msg: "Please select photo",toastLength: Toast.LENGTH_LONG);
      
      postDoctor("");
    }
      }on Exception catch(e){

          print("Error :$e");
            if(pr.isShowing())
                  pr.hide();
                print("PR status  ${pr.isShowing()}" );
          //    Fluttertoast.showToast(msg: "Exception "+e.,toastLength: Toast.LENGTH_LONG);
        }
   
  }
  postDoctor(String file) async{
     DoctorModel doc=DoctorModel(id:widget.doctorModel.id,createdUser:widget.doctorModel.phoneNo,modifiedUser:cUser.phoneNo,name: nameController.text,sama: samaController.text,degree: degereeController.text,phoneNo: phoneController.text,photo: "",profilePhoto: "",speciality_id: 1,status: 0,f1: "",f2:"",f3:"",f4:"",f5:"",n1:0,n2:0,n3:0,n4:0,n5:0);
          doc.profilePhoto=file;
        http.Response response=await widget.manager.saveDoctor(body:doc.toJson(),clinicId:_clinicModel.id,specialityId: specialId);
        if(response.statusCode==200){
            Map result=json.decode(response.body);
            if(result["code"]==MagicStatus.SUCCESS){
             
              Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
               if(pr.isShowing())
                  pr.hide();
                  Navigator.pop(context,true);
            }else if(result["code"]==MagicStatus.SAVE_ERROR){
              Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
              
                  return;
            }else{
              Fluttertoast.showToast(msg:result["desc"],toastLength: Toast.LENGTH_LONG);
              return;
            }
             if(pr.isShowing())
                  pr.hide();
          }
  }
}