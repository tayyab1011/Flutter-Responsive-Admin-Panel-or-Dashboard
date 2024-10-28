import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title;
  final String? numOfFiles;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.numOfFiles,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Orders",
    numOfFiles: "\$5328",
    svgSrc: "assets/icons/drop_box.svg",
    color: primaryColor,
  ),
  CloudStorageInfo(
    title: "Products",
    numOfFiles: "1328",
    svgSrc: "assets/icons/cart.svg",
    color: Color(0xFFFFA113),
  ),
  CloudStorageInfo(
    title: "Users",
    numOfFiles: "1328",
    svgSrc: "assets/icons/profile.svg",
    color: Color(0xFFA4CDFF),
  ),
  CloudStorageInfo(
    title: "Revenue",
    numOfFiles: "\$5328",
    svgSrc: "assets/icons/money.svg",
    color: Color(0xFF007EE5),
  ),
];
