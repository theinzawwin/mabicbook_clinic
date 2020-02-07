import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/ClinicUserModel.dart';
import 'package:magicbook_app/models/DoctorModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/views/DoctorProfile.dart';

class DoctorList extends StatefulWidget {
  ClinicModel clinicModel;
  DoctorList({Key key,this.clinicModel}):super(key:key);
   final MagicManager manager= MagicManager();
   

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {

   
  /*
  _DoctorListState(){
     MagicManager().getClinicInfo().then(       
        (val)=>setState(() {
          _clinic = val;
        })
    );
  }
  */
  Future<List<DoctorModel>> doctorList;
  loadDoctorList()async{
    doctorList=widget.manager.getDoctorList(widget.clinicModel.id);
  }
  @override
  void initState() {
    // TODO: implement initState
     //doctorList= widget.manager.dotorList;
     
      
     doctorList=widget.manager.getDoctorList(widget.clinicModel.id);
    super.initState();
  
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor List'),
        actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.open_in_new),
              onPressed: () {
                 Navigator.pushNamed(context, '/newDoctor').then((val)=>val?loadDoctorList():null);
              },)
        ]
      ),
      body:Center(
        child: Container(
         margin: const EdgeInsets.all(16.0),
      child:FutureBuilder<List<DoctorModel>>(
        future: doctorList,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder
              (
                itemCount: snapshot.data.length,
                itemBuilder: ( ctxt, index) {
                  return Dismissible(
                    background: stackBehindDismiss(),
                    key:UniqueKey(),
                    child: _buildDoctor(snapshot.data[index]),
                    onDismissed: (direction){
                      var doctor=snapshot.data[index];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorProfile(doctorModel: doctor,)));
                     /* Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Item deleted"),
              action: SnackBarAction(
                  label: "UNDO",
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorProfile(doctorModel: doctor,)));
                    //To undo deletion
                    //undoDeletion(index, item);
                  }))); */
                    },
                  );// _buildDoctor(snapshot.data[Index]);
                }
            );
          }
         
        return CircularProgressIndicator();
        }
       
        ),
         
      ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
           Navigator.pushNamed(context, '/newDoctor').then((val)=>val!=null?loadDoctorList():null);
        },
      ),
       
     
    );
    
  }
  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
   Widget _buildDoctor(DoctorModel doc) {
    return Card(
      margin: const EdgeInsets.all(4.0),
      
      child:Padding(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                 width: 75.0,
                  height: 75.0,
                child: CircleAvatar(
                
                backgroundImage:AssetImage('images/doctor.png'), /*Image(
                  image:AssetImage('images/doctor.png'),
                  height: 100,
                ),*/
                
              ),
              )
              
              ,
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(doc.name, style: TextStyle(color: Colors.deepPurple,fontSize: 18.0)),
                        SizedBox(height: 5,),
                        Text(doc.degree,style:Theme.of(context).textTheme.body1),
                        SizedBox(height: 10.0,),
                        Text(doc.sama,style:Theme.of(context).textTheme.body1)
                    ],
                  ),
                )
            ],
          )
         ,
          
        ],
      ), padding: const EdgeInsets.all(10.0),
      ) 
    );
  }
}