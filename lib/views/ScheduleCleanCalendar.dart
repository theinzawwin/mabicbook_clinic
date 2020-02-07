import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
class ScheduleCleanCalendar extends StatefulWidget {
  @override
  _ScheduleCleanCalendarState createState() => _ScheduleCleanCalendarState();
}

class _ScheduleCleanCalendarState extends State<ScheduleCleanCalendar> {

  final Map _events = {
    DateTime(2019, 11, 1): [
      {'name': 'Event A', 'isDone': true},
    ],
    DateTime(2019, 11, 4): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2019, 11, 5): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2019, 11, 13): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
    DateTime(2019, 11, 15): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
    DateTime(2019, 11, 26): [
      {'name': 'Event A', 'isDone': false},
    ],
  };

   List _selectedEvents;
  DateTime _selectedDay;
  void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
    print(_selectedEvents);
  }

  @override
  void initState() {
    // TODO: implement initState
     _selectedEvents = _events[_selectedDay] ?? [];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Test'),
      ),
      body:  Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
           Calendar(
        eventColor: Colors.orange,
        
        events: _events,
        showTodayIcon: true,
        showArrows:true,
        isExpanded: true,
        isExpandable:true,
        
         /*dayBuilder: (BuildContext context, DateTime day) {
           return Text("$day");
         },
         */
         onDateSelected: (date) => _handleNewDate(date),
      ),
      _buildEventList()
        ],
      )
     
    ),
    )
    ;
  }
  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.5, color: Colors.black12),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
              child: ListTile(
                title: Text(_selectedEvents[index]['name'].toString()),
                onTap: () {},
              ),
            ),
        itemCount: _selectedEvents.length,
      ),
    );
  }
}