import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile {
  final IconData icon;
  final String title;
  CustomListTile({
    required this.icon,
    required this.title,
  });
}

List<CustomListTile> customListTiles = [
  /*CustomListTile(
    icon: Icons.insights,
    title: "Activity",
  ),*/
  CustomListTile(
    icon: Icons.location_on_outlined,
    title: "Location",
  ),
  /* CustomListTile(
    title: "Notifications",
    icon: CupertinoIcons.bell,
  ),*/
  CustomListTile(
    title: "Logout",
    icon: CupertinoIcons.arrow_right_arrow_left,
  ),
];
