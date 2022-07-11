// ignore_for_file: unnecessary_parenthesis

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page_state_notifier_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer(builder: (context, ref, child) {
              return Consumer(
                builder: (context, ref, child) {
                  final count = ref.watch(homePageStateNotifierProvider.select((state) {
                    return state.count;
                  }));
                  return Text(
                    count.toString(),
                    key: const ValueKey('CounterText'),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FutureBuilder(
          future: ref.read(homePageStateNotifierProvider.notifier).initialize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return FloatingActionButton(
              onPressed: ref.read(homePageStateNotifierProvider.notifier).incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
          },
        );
      }),
    );
  }
}
