import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Cotegorys {
  String name;
  IconData icons;
  Cotegorys({required this.name, required this.icons});

  static List<Cotegorys> cotegorys = [
    Cotegorys(name: "Grocery", icons: Icons.breakfast_dining_outlined),
    Cotegorys(name: "Work", icons: Icons.cases_outlined),
    Cotegorys(name: "Sport", icons: Icons.sports_kabaddi_rounded),
    Cotegorys(name: "Design", icons: Icons.design_services_rounded),
    Cotegorys(name: "University", icons: Icons.safety_check),
  ];
}
