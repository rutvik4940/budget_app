import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class Transactioncontroller extends GetxController
{
  Rx<DateTime>date=DateTime.now().obs;
  Rx<TimeOfDay>time=TimeOfDay.now().obs;
  Rxn<String> selectedvalue=Rxn<String>();

}