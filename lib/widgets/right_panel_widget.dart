// lib/widgets/right_panel_widget.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RightPanelWidget extends StatelessWidget {
  const RightPanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E2C), // Dark blue/grey from the design
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          // Table Calendar Implementation
          TableCalendar(
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            headerStyle: const HeaderStyle(formatButtonVisible: false, titleTextStyle: TextStyle(color: Colors.white)),
            calendarStyle: const CalendarStyle(defaultTextStyle: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          _buildEventCard("Today Birthday", "2", "Birthday Wishing"),
          const SizedBox(height: 20),
          _buildEventCard("Anniversary", "3", "Anniversary Wishing"),
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String total, String buttonText) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text("Total | $total", style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
            child: Center(child: Text(buttonText)),
          )
        ],
      ),
    );
  }
}