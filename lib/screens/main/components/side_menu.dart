import 'package:admin/screens/dashboard/all_products_screen.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/dashboard/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  final Function(Widget)? onMenuItemSelected;

  const SideMenu({
    Key? key,
    this.onMenuItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/lifetaste.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              onMenuItemSelected!(DashboardScreen());
            }, // Pass as a function
          ),
          DrawerListTile(
            title: "Add Products",
            svgSrc: "assets/icons/cart.svg",
            press: () {
              onMenuItemSelected!(ProductsScreen());
            }, // Pass as a function
          ),
          DrawerListTile(
            title: "All Products",
            svgSrc: "assets/icons/cart.svg",
            press: () {
               onMenuItemSelected!(AllProductsScreen());
            }, // Pass as a function
          ),
          DrawerListTile(
            title: "Orders",
            svgSrc: "assets/icons/driver_delivery.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Users",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
