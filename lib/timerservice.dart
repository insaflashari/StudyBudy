import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class TimerService extends ChangeNotifier {
  final player = AudioPlayer();

  Timer? timer;

  // Current countdown in seconds
  double currentDuration = 1500;

  // The user-selected focus duration
  double selectedTime = 1500;

  // Is the timer running
  bool timerPlaying = false;

  // Pomodoro rounds
  int rounds = 0;

  int goal = 0;

  // Current state: FOCUS, BREAK, LONGBREAK
  String currentState = "FOCUS";

  /// Start the timer
  void start() {
    if (timerPlaying) return;

    timerPlaying = true;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentDuration <= 0) {
        handleNextRound();
      } else {
        currentDuration--;
        notifyListeners();
      }
    });

    notifyListeners();
  }

  /// Pause the timer
  void pause() {
    timer?.cancel();
    timerPlaying = false;
    notifyListeners();
  }

  /// User selects a new focus time
  void selectTime(double seconds) {
    selectedTime = seconds;

    // Only reset currentDuration if currently in FOCUS
    if (currentState == "FOCUS") {
      currentDuration = seconds;
    }

    notifyListeners();
  }

  /// Reset everything
  void reset() {
    timer?.cancel();
    currentState = "FOCUS";
    currentDuration = selectedTime; // Keep user-selected time
    rounds = 0;
    goal = 0;
    timerPlaying = false;
    notifyListeners();
  }

  /// Handle what happens when a timer ends
  void handleNextRound() {
    // Play sound only if a FOCUS session just finished
    if (currentState == "FOCUS") {
      player.play(AssetSource('sounds/notify.mp3'));
    }

    if (currentState == "FOCUS" && rounds != 3) {
      currentState = "BREAK";
      currentDuration = 300; // 5-minute break
    } else if (currentState == "BREAK") {
      currentState = "FOCUS";
      currentDuration = selectedTime; // Keep the user-selected focus time
      rounds++;
      goal++;
    } else if (currentState == "FOCUS" && rounds == 3) {
      currentState = "LONGBREAK";
      currentDuration = 1500; // 25 minutes long break
      rounds++;
      goal++;
    } else if (currentState == "LONGBREAK") {
      currentState = "FOCUS";
      currentDuration = selectedTime; // Keep the user-selected focus time
      rounds = 0;
    }

    pause();
    notifyListeners();
  }
}
