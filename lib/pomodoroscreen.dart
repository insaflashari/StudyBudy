import 'package:flutter/material.dart';
import 'package:studybuddy/widgets/progresswidget.dart';
import 'package:studybuddy/widgets/timeoptions.dart';
import 'utils.dart';
import 'package:studybuddy/widgets/timercard.dart';
import 'package:studybuddy/widgets/timecontroller.dart';
import 'package:provider/provider.dart';
import 'package:studybuddy/timerservice.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);
    return Scaffold(
      backgroundColor: renderColor(provider.currentState),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: renderColor(provider.currentState),
        title: Text("POMODORO TIMER", style: textStyle(25,Colors.white, FontWeight.w700),
        ),
        actions: [
          IconButton(onPressed: ()=> Provider.of<TimerService>(context, listen: false).reset(),
          iconSize: 40,
           icon: Icon(Icons.refresh,color: Colors.white,),)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 15),
              TimerCard(),
              SizedBox(height: 40,),
              TimeOptions(),
              SizedBox(height: 40,),
              TimeController(),
              SizedBox(height: 40,),
              ProgressWidget()
            ],
          ),
        ),
      )
    );
  }
}

