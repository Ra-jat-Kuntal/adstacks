// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'views/dashboard_view.dart';
//
// void main() {
//   runApp(const AdstacksDashboardApp());
// }
//
// class AdstacksDashboardApp extends StatelessWidget {
//   const AdstacksDashboardApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Adstacks Dashboard',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         // Use GoogleFonts here if desired
//       ),
//       home: DashboardView(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

void main() {
  runApp(const AdstacksDashboardApp());
}

class AdstacksDashboardApp extends StatelessWidget {
  const AdstacksDashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Adstacks Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF7239EA),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF7239EA),
          secondary: const Color(0xFFD5449A),
        ),
      ),
      home: const DashboardView(),
    );
  }
}

class DashboardController extends GetxController {
  // Reactive state variables
  var activeMenu = 'Home'.obs;
  var isSidebarOpen = false.obs;

  // Mock data for projects
  final List<Map<String, dynamic>> projects = [
    {
      "title": "Technology behind the Blockchain",
      "subtitle": "Project #1 • See project details",
      "isActive": true,
      "color": const Color(0xFFD5449A),
      "icon": Icons.grid_view_rounded
    },
    {
      "title": "Technology behind the Blockchain",
      "subtitle": "Project #2 • See project details",
      "isActive": false,
      "color": Colors.grey,
      "icon": Icons.code
    },
    {
      "title": "Technology behind the Blockchain",
      "subtitle": "Project #3 • See project details",
      "isActive": false,
      "color": Colors.grey,
      "icon": Icons.security
    },
  ];

  // Mock data for top creators
  final List<Map<String, dynamic>> creators = [
    {"name": "@maddison_c21", "artworks": "9821", "rating": 1.0, "img": "11"},
    {"name": "@karlwill02", "artworks": "7032", "rating": 0.8, "img": "12"},
    {"name": "@anderson_c21", "artworks": "9821", "rating": 1.0, "img": "13"},
    {"name": "@carlos_c21", "artworks": "9821", "rating": 1.0, "img": "14"},
  ];

  void changeMenu(String menu) {
    activeMenu.value = menu;
  }

  void toggleSidebar() {
    isSidebarOpen.value = !isSidebarOpen.value;
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Injecting the controller
    final DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1200;
          final isTablet = constraints.maxWidth >= 800 && constraints.maxWidth < 1200;
          final isMobile = constraints.maxWidth < 800;

          return Row(
            children: [
              // Sidebar (Desktop/Tablet)
              if (isDesktop || isTablet)
                const SizedBox(
                  width: 250,
                  child: SidebarWidget(),
                ),

              // Main Workspace
              Expanded(
                child: Column(
                  children: [
                    HeaderWidget(isMobile: isMobile),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HeroBannerWidget(),
                            const SizedBox(height: 24),

                            // Projects and Creators Row
                            if (isDesktop)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Expanded(child: AllProjectsWidget()),
                                  SizedBox(width: 24),
                                  Expanded(child: TopCreatorsWidget()),
                                ],
                              )
                            else
                              Column(
                                children: const [
                                  AllProjectsWidget(),
                                  SizedBox(height: 24),
                                  TopCreatorsWidget(),
                                ],
                              ),
                            const SizedBox(height: 24),

                            const PerformanceChartWidget(),

                            // If Mobile/Tablet, show right panel contents at the bottom
                            if (!isDesktop) ...[
                              const SizedBox(height: 24),
                              const RightPanelWidget(isMobile: true),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Right Panel (Desktop only)
              if (isDesktop)
                const SizedBox(
                  width: 300,
                  child: RightPanelWidget(),
                ),
            ],
          );
        },
      ),
      // Mobile Drawer setup
      drawer: MediaQuery.of(context).size.width < 800
          ? const Drawer(child: SidebarWidget())
          : null,
    );
  }
}

class SidebarWidget extends GetView<DashboardController> {
  const SidebarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // Logo Area
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Column(
                        children: const [
                          Text("AS", style: TextStyle(color: Colors.redAccent, fontSize: 32, fontWeight: FontWeight.bold)),
                          Text("Adstacks", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Colors.black12),

                    // Profile Area
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.orangeAccent.withOpacity(0.5), width: 2),
                            ),
                            child: const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=47'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text("Pooja Mishra", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text("Admin", style: TextStyle(fontSize: 10, color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Colors.black12),

                    // Navigation Links
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          _buildNavItem('Home', Icons.home_filled),
                          _buildNavItem('Employees', Icons.people_alt_outlined),
                          _buildNavItem('Attendance', Icons.list_alt_rounded),
                          _buildNavItem('Summary', Icons.calendar_today_rounded),
                          _buildNavItem('Information', Icons.info_outline_rounded),

                          const Padding(
                            padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("WORKSPACES", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
                                Icon(Icons.add, size: 16, color: Colors.black87),
                              ],
                            ),
                          ),

                          _buildWorkspaceItem('Adstacks'),
                          _buildWorkspaceItem('Finance'),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    // Bottom Actions
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildBottomAction(Icons.settings_outlined, 'Setting'),
                          _buildBottomAction(Icons.logout_rounded, 'Logout'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(String title, IconData icon) {
    return Obx(() {
      bool isActive = controller.activeMenu.value == title;
      return InkWell(
        onTap: () => controller.changeMenu(title),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFF3F0FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(icon, color: isActive ? const Color(0xFF7239EA) : Colors.grey.shade600, size: 22),
            title: Text(
              title,
              style: TextStyle(
                color: isActive ? const Color(0xFF7239EA) : Colors.grey.shade600,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                fontSize: 14,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            dense: true,
            visualDensity: VisualDensity.compact,
            shape: isActive
                ? const Border(left: BorderSide(color: Color(0xFF7239EA), width: 4))
                : null,
          ),
        ),
      );
    });
  }

  Widget _buildWorkspaceItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey.shade700, fontSize: 13, fontWeight: FontWeight.w500)),
          Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Colors.grey.shade500),
        ],
      ),
    );
  }

  Widget _buildBottomAction(IconData icon, String title) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade700, size: 20),
            const SizedBox(width: 16),
            Text(title, style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final bool isMobile;
  const HeaderWidget({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      color: const Color(0xFFF5F6FA),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )
          else
            const Text(
              "Home",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),

          Row(
            children: [
              if (MediaQuery.of(context).size.width > 600)
                Container(
                  width: 250,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2B36),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      suffixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 18),
                    ),
                  ),
                ),
              const SizedBox(width: 24),
              Icon(Icons.grid_view_rounded, color: Colors.grey.shade600),
              const SizedBox(width: 16),
              Icon(Icons.notifications_none_rounded, color: Colors.grey.shade600),
              const SizedBox(width: 16),
              Icon(Icons.power_settings_new_rounded, color: Colors.grey.shade600),
              const SizedBox(width: 16),
              const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=47'),
              )
            ],
          )
        ],
      ),
    );
  }
}

class HeroBannerWidget extends StatelessWidget {
  const HeroBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF5932EA), Color(0xFFD5449A)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD5449A).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ]
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            right: 100,
            bottom: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ETHEREUM 2.0",
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Top Rating\nProject",
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.2),
                ),
                const SizedBox(height: 12),
                Text(
                  "Trending project and high rating\nProject Created by team.",
                  style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12, height: 1.5),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1C1E2D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    elevation: 0,
                  ),
                  child: const Text("Learn More.", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AllProjectsWidget extends GetView<DashboardController> {
  const AllProjectsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF191B28),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("All Projects", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...controller.projects.map((p) => _buildProjectCard(p)).toList(),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    bool isActive = project['isActive'];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4D243D) : const Color(0xFF212332),
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: const Color(0xFF8C3A5A)) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: project['color'],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(project['icon'], color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project['title'], style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(project['subtitle'], style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit, color: Colors.white70, size: 14),
          )
        ],
      ),
    );
  }
}

class TopCreatorsWidget extends GetView<DashboardController> {
  const TopCreatorsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF191B28),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Top Creators", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(flex: 2, child: Text("Name", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11))),
              Expanded(flex: 1, child: Text("Artworks", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11))),
              Expanded(flex: 1, child: Text("Rating", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11))),
            ],
          ),
          const SizedBox(height: 16),

          ...controller.creators.map((c) => _buildCreatorRow(c)).toList(),
        ],
      ),
    );
  }

  Widget _buildCreatorRow(Map<String, dynamic> creator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${creator['img']}'),
                ),
                const SizedBox(width: 12),
                Text(creator['name'], style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(creator['artworks'], style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: creator['rating'],
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF7239EA),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PerformanceChartWidget extends StatelessWidget {
  const PerformanceChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Over All Performance", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  SizedBox(height: 4),
                  Text("The Years", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              Row(
                children: [
                  _buildLegendDot(Colors.redAccent, "Pending Done"),
                  const SizedBox(width: 16),
                  _buildLegendDot(const Color(0xFF7239EA), "Project Done"),
                ],
              )
            ],
          ),
          const SizedBox(height: 32),

          SizedBox(
            height: 200,
            width: double.infinity,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("50", style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Text("40", style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Text("30", style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Text("20", style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Text("10", style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Text("0", style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) => const Divider(color: Colors.black12, height: 1)),
                      ),

                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: CustomPaint(
                          painter: ChartCurvesPainter(),
                        ),
                      ),

                      Positioned(
                        top: 20,
                        left: 200,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7239EA),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: const [
                              Text("2022", style: TextStyle(color: Colors.white, fontSize: 10)),
                              Text("◆ 55", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("2015", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("2016", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("2017", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("2018", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("2019", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("2020", style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class ChartCurvesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final redPaint = Paint()
      ..color = Colors.redAccent.withOpacity(0.8)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final purplePaint = Paint()
      ..color = const Color(0xFF7239EA)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final redPath = Path();
    final purplePath = Path();

    final w = size.width;
    final h = size.height;

    redPath.moveTo(0, h * 0.8);
    redPath.cubicTo(w * 0.2, h * 0.8, w * 0.3, h * 0.4, w * 0.4, h * 0.6);
    redPath.cubicTo(w * 0.5, h * 0.8, w * 0.6, h * 0.9, w * 0.7, h * 0.6);
    redPath.cubicTo(w * 0.8, h * 0.3, w * 0.9, h * 0.9, w, h * 0.9);

    purplePath.moveTo(0, h * 0.9);
    purplePath.cubicTo(w * 0.2, h * 0.9, w * 0.3, h * 0.9, w * 0.4, h * 0.7);
    purplePath.cubicTo(w * 0.5, h * 0.5, w * 0.55, h * 0.2, w * 0.6, h * 0.2);
    purplePath.cubicTo(w * 0.65, h * 0.2, w * 0.7, h * 0.8, w * 0.8, h * 0.7);
    purplePath.cubicTo(w * 0.9, h * 0.6, w * 0.95, h * 0.5, w, h * 0.5);

    canvas.drawPath(purplePath.shift(const Offset(0, 5)), Paint()
      ..color = const Color(0xFF7239EA).withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5)
    );

    canvas.drawPath(redPath, redPaint);
    canvas.drawPath(purplePath, purplePaint);

    final pointPaint = Paint()..color = const Color(0xFF7239EA)..style = PaintingStyle.fill;
    final borderPaint = Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 2;

    final peakOffset = Offset(w * 0.6, h * 0.2);
    canvas.drawCircle(peakOffset, 5, pointPaint);
    canvas.drawCircle(peakOffset, 5, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RightPanelWidget extends StatelessWidget {
  final bool isMobile;
  const RightPanelWidget({Key? key, this.isMobile = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isMobile ? Colors.transparent : const Color(0xFF12131A),
      child: SingleChildScrollView(
        physics: isMobile ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
        padding: EdgeInsets.all(isMobile ? 0 : 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "GENERAL 10:00 AM TO 7:00 PM",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            const SizedBox(height: 24),

            _buildCalendarCard(),
            const SizedBox(height: 24),

            _buildEventCard(
              title: "Today Birthday",
              total: "2",
              buttonText: "Birthday Wishing",
              buttonColor: const Color(0xFFB684FF),
              avatars: ['33', '44'],
            ),
            const SizedBox(height: 24),

            _buildEventCard(
              title: "Anniversary",
              total: "3",
              buttonText: "Anniversary Wishing",
              buttonColor: const Color(0xFFB684FF),
              avatars: ['55', '66', '77'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarCard() {
    final weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    List<int> previousMonthDays = [25, 26, 27, 28, 29, 30];
    List<int> highlightedDays = [24, 27, 28, 29, 30];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.chevron_left, color: Colors.grey, size: 20),
              Text("OCT 2023", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekDays.map((d) => Text(d, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold))).toList(),
          ),
          const SizedBox(height: 8),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 35,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              bool isPreviousMonth = index < previousMonthDays.length;
              int dayNumber;

              if (isPreviousMonth) {
                dayNumber = previousMonthDays[index];
              } else {
                dayNumber = index - previousMonthDays.length + 1;
              }

              bool isCurrentMonth = !isPreviousMonth && dayNumber <= 31;
              if (!isCurrentMonth && !isPreviousMonth) dayNumber = dayNumber - 31;

              bool isHighlighted = isCurrentMonth && highlightedDays.contains(dayNumber);

              return Container(
                decoration: BoxDecoration(
                  color: isHighlighted ? const Color(0xFF7239EA) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  dayNumber.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: isHighlighted
                        ? Colors.white
                        : (isCurrentMonth ? Colors.black87 : Colors.grey.shade400),
                    fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required String title,
    required String total,
    required String buttonText,
    required Color buttonColor,
    required List<String> avatars,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1F2A),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(top: -10, left: -10, child: Icon(Icons.auto_awesome, color: Colors.amber.shade300, size: 16)),
          Positioned(top: -10, right: -10, child: Icon(Icons.auto_awesome, color: Colors.amber.shade300, size: 16)),

          Column(
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 16),

              SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(avatars.length, (index) {
                    return Align(
                      widthFactor: 0.6,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF1D1F2A), width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${avatars[index]}'),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Total", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text("|", style: TextStyle(color: Colors.white30, fontSize: 14)),
                  ),
                  Text(total, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send_rounded, size: 16, color: Colors.white),
                  label: Text(buttonText, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}