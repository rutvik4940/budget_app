import 'package:budget_app/screen/home/controller/home_controller.dart';
import 'package:budget_app/screen/transation/model/transation_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../../utils/dp_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController Hcontroller = Get.put(HomeController());
  TextEditingController txtcatg = TextEditingController();
  TextEditingController txtname = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hcontroller.gettransationction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Budget"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    Get.toNamed('cate');
                  },
                  child: Text("Add Categrry"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: Hcontroller.list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text("${Hcontroller.list[index].id}"),
                      title: Text("${Hcontroller.list[index].title}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    title: "are you sure?",
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          DBHelper.helper.transactiondelet(
                                              Hcontroller.list[index].id!);
                                          Hcontroller.gettransationction();
                                          Get.back();
                                        },
                                        child: Text("Yes"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("No"),
                                      ),
                                    ]);
                              },
                              child: Icon(Icons.delete)),
                          TextButton(
                            onPressed: () {
                              txtname.text = Hcontroller.list[index].title!;
                              Get.defaultDialog(
                                title: "are you sure",
                                content: TextField(
                                  controller: txtname,
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      String title = txtname.text;
                                      TrasacationModel model = TrasacationModel(
                                        category:
                                            Hcontroller.list[index].category,
                                        id: Hcontroller.list[index].id,
                                        status: Hcontroller.list[index].status,
                                        date: Hcontroller.list[index].date,
                                        amount: Hcontroller.list[index].amount,
                                        title: title,
                                        time: Hcontroller.list[index].time,
                                      );
                                      DBHelper.helper.transactionupdate(model);
                                      Hcontroller.gettransationction();
                                      Get.back();
                                    },
                                    child: Text("upadate"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("cancel"),
                                  ),
                                ],
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('tran');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
