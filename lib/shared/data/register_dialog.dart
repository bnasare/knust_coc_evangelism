import 'package:flutter/cupertino.dart';

import 'image_assets.dart';
import 'svg_assets.dart';

List<String> groupNames = [
  'Group 1',
  'Group 2',
  'Group 3',
  'Group 4',
  'Group 5',
  'Group 6',
  'Group 7',
  'Group 8',
  'Group 9',
  'Group 10',
  'Group 11',
  'Group 12',
  'Group 13',
  'Group 14',
  'Group 15',
  'Group 16',
  'Group 17',
  'Group 18',
  'Group 19',
  'Group 20',
  'Group 21',
  'Group 22',
  'Group 23',
  'Group 24',
  'Group 25',
  'Group 26',
  'Group 27',
  'Group 28',
  'Group 29',
  'Group 30',
  'Group 31',
  'Group 32',
  'Group 33',
  'Group 34',
  'Group 35',
  'Group 36',
  'Group 37',
  'Group 38',
  'Group 39',
  'Group 40',
  'Group 41',
  'Group 42',
  'Group 43',
  'Group 44',
  'Group 45',
];
List<Map<String, dynamic>> genderOptions = [
  {"gender": "Male", "icon": SvgAssets.male},
  {"gender": "Female", "icon": SvgAssets.female},
];

List<Map<String, dynamic>> religiousAffiliations = [
  {"name": "Islam", "image": ImageAssets.muslim},
  {"name": "Assemblies Of God", "image": ImageAssets.assemblies},
  {"name": "Catholic", "image": ImageAssets.catholic},
  {"name": "Christ Apostolic Church", "image": ImageAssets.cac},
  {"name": "Church Of Christ", "image": ImageAssets.coc},
  {"name": "Methodist", "image": ImageAssets.methodist},
  {"name": "Pentecost", "image": ImageAssets.pent},
  {"name": "Presbyterian", "image": ImageAssets.presby},
];

List<Map<String, dynamic>> baptismalStatusOptions = [
  {
    "status": "Baptized - Dipping Once",
    "icon": CupertinoIcons.check_mark_circled
  },
  {
    "status": "Baptized - Other forms",
    "icon": CupertinoIcons.check_mark_circled
  },
  {"status": "Not Baptized", "icon": CupertinoIcons.clear_circled},
  {"status": "N/A", "icon": CupertinoIcons.question_circle},
];
