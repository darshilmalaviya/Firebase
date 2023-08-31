import 'package:firebase/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemoProvider extends StatefulWidget {
  const DemoProvider({super.key});

  @override
  State<DemoProvider> createState() => _DemoProviderState();
}

class _DemoProviderState extends State<DemoProvider> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CounterProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(
              builder: (context, counterProvider, child) {
                return Text('${counterProvider.counter}');
              },
              //Scaffold.of(context).openDrawer();
            ),
            ElevatedButton(
              onPressed: () {
                provider.increment();
              },
              child: const Text('Increase'),
            ),
          ],
        ),
      ),
    );
  }
}
