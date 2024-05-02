import 'package:budget_app/screen/categrry/view/categrry_screen.dart';
import 'package:budget_app/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';

import '../screen/transation/view/transation_screen.dart';

Map<String,WidgetBuilder>app_routs={
"/":(context) => HomeScreen(),
  "cate":(context) => CategrryScreen(),
  "tran":(context) => TransactionScreen(),

};