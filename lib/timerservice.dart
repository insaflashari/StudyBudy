import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TimerService extends ChangeNotifier {
  late int currentDuration;
  int selectedTime = 1500; // Default 25 min
  String currentState = "FOCUS";
  int rounds = 0;
  int goal = 0;
  Timer? timer;
  final player = AudioPlayer();

  TimerService() {
    currentDuration = selectedTime;
  }

  void start() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (currentDuration > 0) {
        currentDuration--;
      } else {
        handleNextRound();
      }
      notifyListeners();
    });
  }

  void pause() {
    timer?.cancel();
    notifyListeners();
  }

  void reset() {
    pause();
    currentDuration = selectedTime;
    currentState = "FOCUS";
    rounds = 0;
    goal = 0;
    notifyListeners();
  }

  void setSelectedTime(int seconds) {
    selectedTime = seconds;
    currentDuration = seconds;
    notifyListeners();
  }

  void handleNextRound() {
    // Play sound only if a FOCUS session just finished
    if (currentState == "FOCUS") {
      player.play(AssetSource('sounds/notify.mp3'));
    }

    if (currentState == "FOCUS" && rounds != 3) {
      currentState = "BREAK";
      currentDuration = 300; // 5 min short break
      rounds++;
      goal++;
    } else if (currentState == "BREAK") {
      currentState = "FOCUS";
      currentDuration = selectedTime; // go back to user's chosen focus time
    } else if (currentState == "FOCUS" && rounds == 3) {
      currentState = "LONGBREAK";
      currentDuration = 1500; // 15 min long break
      rounds++;
      goal++;
    } else if (currentState == "LONGBREAK") {
      currentState = "FOCUS";
      currentDuration = selectedTime; // back to user's chosen focus time
      rounds = 0;
    }

    pause();
    notifyListeners();
  }

  String get currentDurationFormatted {
    int minutes = currentDuration ~/ 60;
    int seconds = currentDuration % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
