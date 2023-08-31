import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class GetValue extends StatelessWidget {
  GetValue({super.key});

  final get = GetStorage();

  @override
  Widget build(BuildContext context) {
    get.remove('emailValue');

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(get.read('emailValue'))),
          Center(child: Text(get.read('numberValue'))),
        ],
      ),
    );
  }
}
