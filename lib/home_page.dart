import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_tracker/util/habit_tile.dart';
import 'util/habit_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List habitList = [
    ['Excercise', false, 0, 10],
    ['Read', false, 0, 20],
    ['Medidate', false, 0, 30],
    ['Code', false, 0, 40],
  ];

  void habitStarted(int index) {
    //start time
    var startTime = DateTime.now();

    // elapsed time
    int elapsedTime = habitList[index][2];

    //changing pause/play
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });
    if (habitList[index][1]) {
      //timer
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (habitList[index][1] == false) {
            timer.cancel();
          }

          var currentTime = DateTime.now();
          habitList[index][2] = elapsedTime + currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingsOpened(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // ignore: prefer_interpolation_to_compose_strings
            title: Text('Settings for' + habitList[index][0]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Consistency is key.'),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: ((context, index) {
          return HabitTile(
            habitName: habitList[index][0],
            onTap: () {
              habitStarted(index);
            },
            settingsTapped: () {
              settingsOpened(index);
            },
            habitStarted: habitList[index][1],
            timeSpent: habitList[index][2],
            timeGoal: habitList[index][3],
          );
        }),
      ),
    );
    // ignore: avoid_unnecessary_containers
  }
}
