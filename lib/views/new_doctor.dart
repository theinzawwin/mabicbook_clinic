import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/ClinicUserModel.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/models/SpecialityModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/util/MagicStatus.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:progress_dialog/progress_dialog.dart';
//import 'package:toast/toast.dart';
class NewDoctor extends StatefulWidget {

    MagicManager manager= MagicManager();
  @override
  _NewDoctorState createState() => _NewDoctorState();
}

class _NewDoctorState extends State<NewDoctor> {
   ClinicUserModel cUser;
   ProgressDialog pr;
   List<SpecialityModel> specialityList;
  final String baseUrl="http://192.168.100.209:8070/FUNGO_Consumer/consumer/uploadSpecialRequestImage";
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


  // To track the file uploading state
  bool _isUploading = false;
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
  Future<Map<String, dynamic>> _uploadImage(File image) async {
    setState(() {
      _isUploading = true;
    });
    // Find the mime type of the selected file by looking at the header bytes of the file
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(baseUrl));
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension
    //imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.fields['name'] = 'tzw@google.com';
    imageUploadRequest.fields["id"]='101';
    //imageUploadRequest.fields["file"]=file;
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200) print('Uploaded!');
      final Map<String, dynamic> responseData = json.decode(response.body);
      _resetState();
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }
    void _resetState() {
    setState(() {
      _isUploading = false;
      _imageFile = null;
    });
  }

  void _startUploading() async {
    final Map<String, dynamic> response = await _uploadImage(_imageFile);
    print(response);
    // Check if any error occured
    if (response == null || response.containsKey("error")) {
      /*Toast.show("Image Upload Failed!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM); */
    } else {
     /* Toast.show("Image Uploaded Successfully!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM); */
    }
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
    widget.manager.getClinicUser().then((val)=>this.cUser=val);
    widget.manager.getClinicInfo().then(       
        (val){
          setState(() {
          _clinicModel = val;
        });
        }
    );
    super.initState();
    widget.manager.getAllSpeciality().then((val){
      setState(() {
       specialityList=val; 
      });
    }
    
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text('New Doctor'),
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
                                child:Image.file(
                                  _imageFile,
                                  fit: BoxFit.fill,
                                  height: 100.0,
                                  alignment: Alignment.center,
                                  
                                  width: 100.0//MediaQuery.of(context).size.width,
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
     DoctorModel doc=DoctorModel(createdUser:cUser.phoneNo,modifiedUser:cUser.phoneNo,name: nameController.text,sama: samaController.text,degree: degereeController.text,phoneNo: phoneController.text,photo: "",profilePhoto: "",speciality_id: specialId,status: 0,f1: "",f2:"",f3:"",f4:"",f5:"",n1:0,n2:0,n3:0,n4:0,n5:0);
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