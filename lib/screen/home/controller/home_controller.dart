import 'package:budget_app/screen/transation/model/transation_model.dart';
import 'package:get/get.dart';

import '../../../utils/dp_helper.dart';

class HomeController extends GetxController
{
  RxList<TrasacationModel>list=<TrasacationModel>[].obs;

  Future<void> gettransationction()
  async {
    List<TrasacationModel>l1 =await DBHelper.helper.readTrasaction();
    list.value=l1;
  }
}