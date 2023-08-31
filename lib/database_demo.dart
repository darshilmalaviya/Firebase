import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'database_controller.dart';

class DemoDatabase extends StatefulWidget {
  const DemoDatabase({super.key});

  @override
  State<DemoDatabase> createState() => _DemoDatabaseState();
}

class _DemoDatabaseState extends State<DemoDatabase> {
  SqlController sqlController = Get.put(SqlController());

  @override
  void initState() {
    // to create data base
    sqlController.createDB();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SqlController>(
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // to insert data to database
                  ElevatedButton(
                    onPressed: () {
                      controller.insertData();
                      controller.getData();
                    },
                    child: const Text('Add'),
                  ),
                  // get data from database
                  ElevatedButton(
                    onPressed: () {
                      controller.getData();
                      print("DATA--------------${controller.data}");
                    },
                    child: const Text('Get'),
                  ),
                  // update data to database
                  ElevatedButton(
                    onPressed: () {
                      controller.update();
                      controller.getData();
                    },
                    child: const Text('Update'),
                  ),
                  // delete data from database
                  ElevatedButton(
                    onPressed: () {
                      controller.deleteData();
                      controller.getData();
                    },
                    child: const Text('Delete'),
                  ),
                  // show data of database
                  ListView.builder(
                    itemCount: controller.data.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        width: 200,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${controller.data[index]['id']}"),
                              Text("${controller.data[index]['name']}"),
                              Text("${controller.data[index]['value']}"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
