import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'get_value.dart';

class GetStorageDemo extends StatefulWidget {
  const GetStorageDemo({super.key});

  @override
  State<GetStorageDemo> createState() => _GetStorageDemoState();
}

class _GetStorageDemoState extends State<GetStorageDemo> {
  final get = GetStorage();
  TextEditingController emailcntrl = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
          child: TextFormField(
            controller: emailcntrl,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
          child: TextFormField(
            controller: number,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              get.write('emailValue', emailcntrl.text);
              get.write('numberValue', number.text);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetValue(),
                  ));
            },
            child: Text("Tap"))
      ]),
    );
  }
}
