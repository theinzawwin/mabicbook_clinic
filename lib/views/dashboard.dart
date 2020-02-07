import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:magicbook_app/models/BookingSummaryModel.dart';
import 'package:magicbook_app/models/ClinicModel.dart';
import 'package:magicbook_app/models/ClinicUserModel.dart';
import 'package:magicbook_app/util/MagicManager.dart';
import 'package:magicbook_app/views/BookingList.dart';
import 'package:magicbook_app/views/DoctorList.dart';
import 'package:magicbook_app/views/TodayScheduleList.dart';

class Dashboard extends StatefulWidget {
  final MagicManager manager= MagicManager();
  Dashboard({Key key}):super(key:key);
   

  @override
  _DashboardState createState()=>_DashboardState();
}
class _DashboardState extends State<Dashboard>{
  ClinicUserModel _user;
  ClinicModel _clinicModel;
  BookingSummaryModel _bookingSummary;
/*  MagicManager().getClinicInfo().then(       
        (val)=>setState(() {
          _clinic = val;
        })
    );
    */
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.manager.getClinicInfo().then(       
        (val)=>setState(() {
          _clinicModel = val;
           widget.manager.getTodaySummary(clinicId: _clinicModel.id).then((val){
             setState(() {
              _bookingSummary=val; 
             });
           });
        })
    );
   widget.manager.getClinicUser().then(       
        (value)=>setState(() {
          _user = value;
        })
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magic Clinic'),
      ),
      drawer: Drawer(
        child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.7),
                      ]
                    )
                  ),
                  accountName : _user!=null? new Text("${ _user.name.isNotEmpty?_user.name:_user.phoneNo}"):"",
                  accountEmail : new Text("${_user.phoneNo}"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    child: new Text("P",style:TextStyle(color: Colors.white,fontSize: 25.0)),

                  ),
                ),
                CustomListTile("Profile",Icons.person,()=>{}),
               CustomListTile("User",Icons.person,()=>{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorList(clinicModel: _clinicModel,)))
               }),
                CustomListTile("Notification",Icons.notifications,()=>{}),
                 CustomListTile("About",Icons.info,(){Navigator.pushNamed(context, "/newDoctor");}),
                CustomListTile("Contact",Icons.contacts,(){Navigator.pushNamed(context, "/newDoctor");}),
                CustomListTile("Logout",Icons.lock_open,(){Navigator.pushNamed(context, "/signin");}),
              ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => BookingList(clinicModel: _clinicModel)));
              },
              child: BookingCard(bookSummary: _bookingSummary,),
            )
             ,
            Container(
             // padding: const EdgeInsets.all(30.0),
              child:  GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        //  padding: EdgeInsets.all(8.0),
          children: <Widget>[
             CustomCardTile("Clinic", Icons.local_hospital, Theme.of(context).primaryColor, (){Navigator.pushNamed(context, "/profile");}),
            
             
              CustomCardTile("Doctor", Icons.person, Theme.of(context).primaryColor, (){ Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorList(clinicModel: _clinicModel,)));}),
            
         /* GestureDetector(
            
            onTap: (){
               // Navigator.pushNamed(context, "/doctorList");
               Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorList(clinicModel: _clinicModel,)));
            },
            child:  Card(
              elevation: 5.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
               SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  Icons.location_searching,
                  size: 40.0,
                  color: Theme.of(context).accentColor,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text('Doctor List',
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
          ),
          */
          CustomCardTile("Schedule", Icons.schedule, Theme.of(context).primaryColor, (){Navigator.pushNamed(context, "/scheduleList");}),
           CustomCardTile("Today Schedule", Icons.schedule, Theme.of(context).primaryColor,(){ Navigator.push(context, MaterialPageRoute(builder: (context) => TodayScheduleList(clinicModel: _clinicModel,)));}),
          /*GestureDetector(
            onTap: (){
                Navigator.pushNamed(context, "/scheduleCalendar");
            },
            child:  Card(
              elevation: 5.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
               SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  Icons.location_searching,
                  size: 40.0,
                  color: Theme.of(context).accentColor,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text('Calendar',
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
          ),
          GestureDetector(
            onTap: (){
                Navigator.pushNamed(context, "/carolCalendar");
            },
            child:  Card(
              elevation: 5.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
               SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  Icons.location_searching,
                  size: 40.0,
                 color: Theme.of(context).accentColor,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text('Carol Calendar',
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
          )*/
         
          ],
        ),
            )
            
      
          ],
        ),
        )
        
        
    )
        
    );
  }
}
class BookingCard extends StatelessWidget {
  BookingSummaryModel bookSummary;
  BookingCard({Key key,this.bookSummary}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 2.0,
              borderOnForeground: true,
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: <Widget>[
                  Text('Today Booking',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
              
               children: <Widget>[
                 Expanded(
                   child:  Column(
                     children: <Widget>[
                       Text('Pending',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5.0,),
                      Text(bookSummary!=null?'${bookSummary.pendingCount}':'0',style: TextStyle(color: Colors.blue,fontSize: 18.0),)
                     ],
                  ),
                 ),
                 
                  Expanded(
                   child:   Column(
                     children: <Widget>[
                       Text('Accept',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5.0,),
                      Text(bookSummary!=null?'${bookSummary.acceptCount}':'0',style: TextStyle(color: Colors.green,fontSize: 18.0),)
                     ],
                  ),
                 ),
                 Expanded(
                   child:   Column(
                     children: <Widget>[
                       Text('Reject',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5.0,),
                      Text(bookSummary!=null?'${bookSummary.rejectCount}':'0',style: TextStyle(color: Colors.red,fontSize: 18.0),)
                     ],
                  ),
                 )
                    ],),
                    SizedBox(height: 20.0,)
                ],
              ), 
              )
            );
  }
}
class CustomListTile extends StatelessWidget{

   final String text;
   final IconData icon;
   final Function onTap;

   CustomListTile (this.text,this.icon,this.onTap);

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.orangeAccent,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon
                    ),
                    Text(text, style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }

 }
 class CustomCardTile extends StatelessWidget {
   final String title;
   final IconData icon;
   final MaterialColor color;
   final Function onTap;

   CustomCardTile (this.title, this.icon, this.color,this.onTap);

   @override
   Widget build(BuildContext context) {
     var card = Card(
       elevation: 5.0,
       //margin: EdgeInsets.all(10),
       //shape: RoundedRectangleBorder(
       //  borderRadius: BorderRadius.circular(20.0),
       //),
       
       child: InkWell(
          onTap: onTap,
          splashColor: Colors.deepOrange,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size:50.0, color: color),
                SizedBox(height: 20.0),
                Text(title, style: TextStyle(fontSize: 14.0)),
              ],
            ),
          ),
       ),
     );
     return card;
   }
 }
