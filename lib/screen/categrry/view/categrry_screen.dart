import 'package:budget_app/screen/categrry/controller/category_controller.dart';
import 'package:budget_app/screen/categrry/model/category_model.dart';
import 'package:budget_app/utils/dp_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class CategrryScreen extends StatefulWidget {
  const CategrryScreen({super.key});

  @override
  State<CategrryScreen> createState() => _CategrryScreenState();
}

class _CategrryScreenState extends State<CategrryScreen> {
  TextEditingController txtcatg = TextEditingController();
  TextEditingController txtname = TextEditingController();

  GlobalKey<FormState> key = GlobalKey<FormState>();
  categoryController controller = Get.put(categoryController());

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
          title: const Text("Categrry"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                  controller: txtcatg,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: OutlineInputBorder())),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    String name = txtcatg.text;
                    DBHelper.helper.insertcategory(name);
                    controller.getcategory();
                  }
                },
                child: Text("sumit"),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text("${controller.list[index].id}"),
                        title: Text("${controller.list[index].name}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: "are you sure?",
                                    actions: [
                                     ElevatedButton(onPressed: () {
                                       DBHelper.helper.deletcategory(
                                           controller.list[index].id!);
                                       controller.getcategory();
                                       Get.back();
                                     }, child: Text("Yes"),),
                                      ElevatedButton(onPressed: () {
                                        Get.back();
                                      }, child: Text("No"),),
                                    ]
                                  );
                                },
                                child: Icon(Icons.delete)),
                            TextButton(
                              onPressed: () {
                                txtname.text = controller.list[index].name!;
                                Get.defaultDialog(
                                  title: "are you sure",
                                  content: TextField(
                                    controller: txtname,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        String name=txtname.text;
                                       DBHelper.helper.updatecategory(name, controller.list[index].id!);
                                       controller.getcategory();
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
      ),
    );
  }
}
