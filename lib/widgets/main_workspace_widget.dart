// lib/widgets/main_workspace_widget.dart
import 'package:flutter/material.dart';

class MainWorkspaceWidget extends StatelessWidget {
  const MainWorkspaceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Rating Project Banner
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.deepPurple, Colors.purpleAccent]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: Text("Top Rating Project Details...", style: TextStyle(color: Colors.white))),
          ),
          const SizedBox(height: 20),
          // Projects and Creators Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildAllProjectsCard()),
              const SizedBox(width: 20),
              Expanded(child: _buildTopCreatorsCard()),
            ],
          ),
          const SizedBox(height: 20),
          // Performance Chart (fl_chart implementation goes here)
          Container(
            height: 300,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const Center(child: Text("fl_chart Performance Graph Here")),
          )
        ],
      ),
    );
  }

  Widget _buildAllProjectsCard() => Container(
    decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(15)),
    padding: const EdgeInsets.all(16),
    child: const Text("All Projects", style: TextStyle(color: Colors.white)),
  );

  Widget _buildTopCreatorsCard() => Container(
    decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(15)),
    padding: const EdgeInsets.all(16),
    child: const Text("Top Creators", style: TextStyle(color: Colors.white)),
  );
}