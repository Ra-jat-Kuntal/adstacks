// lib/controllers/dashboard_controller.dart
import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Reactive variable for the active sidebar menu
  var activeIndex = 0.obs;

  // Mock data for Top Creators
  var topCreators = [
    {"name": "@maddison_c21", "artworks": "9821", "rating": 5.0},
    {"name": "@karlwill02", "artworks": "7032", "rating": 4.5},
  ].obs;

  // Method to update sidebar selection
  void changeMenu(int index) {
    activeIndex.value = index;
  }
}