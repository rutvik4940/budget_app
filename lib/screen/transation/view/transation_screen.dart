import 'package:budget_app/screen/transation/controller/transation_controller.dart';
import 'package:budget_app/screen/transation/model/transation_model.dart';
import 'package:budget_app/utils/dp_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';

import '../../categrry/controller/category_controller.dart';
import '../../home/controller/home_controller.dart';

class TransactionScreen extends StatefulWidget {
  @override
  State<TransactionScreen> createState() => _TransationScreenState();
}

class _TransationScreenState extends State<TransactionScreen> {
  TextEditingController txtTitel = TextEditingController();
  TextEditingController txtAmount = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Transactioncontroller transactioncontroller =
  Get.put(Transactioncontroller());
  categoryController controller = Get.put(categoryController());
  HomeController Hcontroller =Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getcategory();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Income/Expense"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: txtTitel,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "title"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: txtAmount,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "amount"),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      DateTime? d1 = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2050));
                      transactioncontroller.date.value = d1!;
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                  Obx(() =>
                      Text(
                          "${transactioncontroller.date.value
                              .day}/${transactioncontroller.date.value
                              .month}/${transactioncontroller.date.value
                              .year}")),
                  SizedBox(
                    width: 170,
                  ),
                  IconButton(
                    onPressed: () async {
                      TimeOfDay? t1 = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                              hour: transactioncontroller.time.value.hour,
                              minute: transactioncontroller.time.value.minute));
                      transactioncontroller.time.value = t1!;
                    },
                    icon: Icon(Icons.watch_later),
                  ),
                  Obx(() =>
                      Text(
                          "${transactioncontroller.time.value
                              .hour}:${transactioncontroller.time.value
                              .minute}"),),
                ],
              ),
               Obx(() => DropdownButton(
                 hint: Text("Select"),
                   value:transactioncontroller.selectedvalue.value,
                   isExpanded: true,
                   items: controller.list.map((e) =>
                       DropdownMenuItem(
                          child: Text("${e.name}"), value: "${e.name}"),).toList(),
                   onChanged: (value) {
                     transactioncontroller.selectedvalue.value=value! as String;
                   },
                 ),
               ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {
                    TrasacationModel model = TrasacationModel(
                        title: txtTitel.text,
                        status: 0,
                        date: "${transactioncontroller.date.value
                            .day}/${transactioncontroller.date.value
                            .month}/${transactioncontroller.date.value.year}",
                        time: "${transactioncontroller.date.value
                            .day}/${transactioncontroller.date.value
                            .month}/${transactioncontroller.date.value.year}",
                        amount: txtAmount.text,
                      category: "${transactioncontroller.selectedvalue}"
                        );
                    DBHelper.helper.trasactioninsert(model);
                    DBHelper.helper.readTrasaction();
                    Hcontroller.gettransationction();
                  }, child: Text("Income")),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: () {
                    TrasacationModel model = TrasacationModel(
                      title: txtTitel.text,
                      status: 1,
                      date: "${transactioncontroller.date.value
                          .day}/${transactioncontroller.date.value
                          .month}/${transactioncontroller.date.value.year}",
                      time: "${transactioncontroller.date.value
                          .day}/${transactioncontroller.date.value
                          .month}/${transactioncontroller.date.value.year}",
                      amount: txtAmount.text,
                        category: "${transactioncontroller.selectedvalue}"
                    );
                    DBHelper.helper.trasactioninsert(model);
                    DBHelper.helper.readTrasaction();
                  Hcontroller.gettransationction();
                    Get.back();
                  }, child: Text("Expense")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
