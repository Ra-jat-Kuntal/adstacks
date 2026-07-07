// lib/widgets/sidebar_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class SidebarWidget extends GetView<DashboardController> {
  const SidebarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          // const UserProfileCard(), // Custom widget for Pooja Mistra's profile
          const Divider(),
          Obx(() => _buildMenuItem(0, Icons.home, "Home")),
          Obx(() => _buildMenuItem(1, Icons.people, "Employees")),
          Obx(() => _buildMenuItem(2, Icons.calendar_today, "Attendance")),
          // Add remaining menu items here...
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index, IconData icon, String title) {
    bool isActive = controller.activeIndex.value == index;
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.deepPurple : Colors.grey),
      title: Text(title, style: TextStyle(color: isActive ? Colors.deepPurple : Colors.black)),
      tileColor: isActive ? Colors.deepPurple.withOpacity(0.1) : Colors.transparent,
      onTap: () => controller.changeMenu(index),
    );
  }
}