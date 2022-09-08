import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_arch/data/cubit/time_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<TimeCubit>(
        create: (context) => TimeCubit(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  Timer? _debounceTimer;

  void debouncing({required Function() fn, int waitForMs = 500}) {
    // if this function is called before 500ms [waitForMs] expired
    //cancel the previous call
    _debounceTimer?.cancel();
    // set a 500ms [waitForMs] timer for the [fn] to be called
    _debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<TimeCubit, TimeState>(
        builder: (context, state) {
          log("btn pressed count ${state.counter}");
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'The time in ${state.location} is ${state.time}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    onPressed: () {
                      // BlocProvider.of<TimeCubit>(context).updateTimeLocation();
                      BlocProvider.of<TimeCubit>(context).increment();
                      debouncing(
                          fn: (() => BlocProvider.of<TimeCubit>(context)
                              .updateTimeLocation()));
                    },
                    child: const Text("Get Time"))
              ],
            ),
          );
        },
      ),
    );
  }
}
