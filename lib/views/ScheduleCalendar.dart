import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

class ScheduleCalendar extends StatefulWidget {
  @override
  _ScheduleCalendarState createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );
  DateTime _currentDate = DateTime(2019, 11, 29);
  String title_event="";
  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
   EventList<Event> _markedDateMap = new EventList<Event>(
   /* events: {
      new DateTime(2019, 11, 10): [
        new Event(
          date: new DateTime(2019, 11, 12),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 11, 14),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019,11 , 15),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },*/
  );
  @override
  void initState() {
    // TODO: implement initState
     _markedDateMap.add(
        new DateTime(2019,11, 25),
        new Event(
         date: new DateTime(2019, 11, 25),
          title: '1:00 PM - 2:00 PM',
         // icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2019, 11, 24),
        new Event(
          date: new DateTime(2019, 11, 24),
          title: '1:00 PM - 2:00 PM',
          //icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2019, 11, 15), [
      new Event(
       date: new DateTime(2019, 11, 15),
        title: '9:00 AM - 11:30 AM',
     //  icon: _eventIcon,
      ),
     
      
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Container(
         margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CalendarCarousel(
       onDayPressed: (DateTime date, List<Event> events){
         this.setState(() => _currentDate = date);
         /*setState(() {
           events.forEach((event)=>title_event+= event.title +" \n");
         });
         */
        events.forEach((event) => print(event.title)
            );
       },
        weekendTextStyle: TextStyle(
            color: Colors.red,
          ),
          thisMonthDayBorderColor: Colors.grey,
          markedDateShowIcon: false,
          markedDatesMap: _markedDateMap,
         // height: 420.0,
          selectedDateTime: _currentDate,
          daysHaveCircularBorder: false,
          selectedDayTextStyle: TextStyle(
            color: Colors.yellow,
          ),
          todayTextStyle: TextStyle(
            color: Colors.blue,
          ),
       /*   markedDateIconBuilder: (event) {
            return event.icon;
          }, 
          */
          minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.green,
       markedDateCustomShapeBorder: CircleBorder(
      
        side: BorderSide(color: Colors.green)
      ),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      
      ),
       
      ),
          )
          
     
        ],
      )
      
      ),
      
    );
  }
}