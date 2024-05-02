import 'package:budget_app/utils/dp_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import '../model/category_model.dart';

class categoryController extends GetxController
{
  RxList<categoryModel>list=<categoryModel>[].obs;

  Future<void> getcategory()
  async {
   List<categoryModel>l1 =await DBHelper.helper.readcategory();
   list.value=l1;
  }

}