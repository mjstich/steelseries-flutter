import 'package:example/routes.dart';
import 'package:flutter/material.dart';

import 'package:steelseries_flutter/steelseries_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    initBuffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Steel Series Gauges Demo'),
        ),
        body: ListView.separated(
            itemBuilder: (context, idx) {
              final demoPage = demoPages.elementAt(idx);
              return ListTile(
                title: Text(demoPage.title),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).pushNamed(demoPage.path);
                },
              );
            },
            separatorBuilder: (context, idx) {
              return const Divider();
            },
            itemCount: demoPages.length));
  }
}
