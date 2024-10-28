import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Move `selectedScreen` outside of the `build` method to persist it
  Widget selectedScreen =
      DashboardScreen(); // Default screen is DashboardScreen

  // Function to change the selected screen
  void selectScreen(Widget screen) {
    setState(() {
      selectedScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(
        onMenuItemSelected: selectScreen,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screens
            if (Responsive.isDesktop(context))
              Expanded(
                // Default flex = 1 (1/6 part of the screen)
                child: SideMenu(onMenuItemSelected: selectScreen),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: selectedScreen, // Display the selected screen
            ),
          ],
        ),
      ),
    );
  }
}
