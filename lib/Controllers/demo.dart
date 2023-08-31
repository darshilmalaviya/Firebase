import 'package:firebase/Controllers/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetData extends StatefulWidget {
  const GetData({super.key});

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  CounterController counterController = Get.put(CounterController());

  Future<int> getData() async {
    await Future.delayed(const Duration(seconds: 3));
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    print('hello');
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text('${snapshot.data}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              GetBuilder<CounterController>(
                builder: (controller) {
                  return Text('${controller.counter}');
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    counterController.increment();
                  },
                  child: const Text('Add')),
            ],
          ),
        ),
      ),
    );
  }
}
