// lib/views/dashboard_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../layout/responsive_layout.dart';
import '../widgets/main_workspace_widget.dart';
import '../widgets/right_panel_widget.dart';
import '../widgets/sidebar_widget.dart';
// Import your custom widgets below (Sidebar, MainContent, RightPanel)

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);

  // Initialize the GetX controller
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Light grey background
      appBar: MediaQuery.of(context).size.width < 1200
          ? AppBar(title: const Text("Adstacks Dashboard")) // Mobile/Tablet AppBar
          : null, // Hide AppBar on Desktop
      drawer: MediaQuery.of(context).size.width < 1200 ? const SidebarWidget() : null,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: const MainWorkspaceWidget(),
          tablet: Row(
            children: [
              const Expanded(flex: 3, child: MainWorkspaceWidget()),
              const Expanded(flex: 2, child: RightPanelWidget()),
            ],
          ),
          desktop: Row(
            children: [
              const Expanded(flex: 2, child: SidebarWidget()),
              const Expanded(flex: 5, child: MainWorkspaceWidget()),
              const Expanded(flex: 2, child: RightPanelWidget()),
            ],
          ),
        ),
      ),
    );
  }
}