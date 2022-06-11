import 'dart:async';

import 'package:flutter/material.dart';
import 'package:w_health/Elements/button_widget.dart';

class TimerView extends StatefulWidget {
  @override
  _Timer createState() => _Timer();
}

class _Timer extends State<TimerView> {
  static const maxSeconds = 900;
  int seconds = maxSeconds;
  Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [buildTime(), SizedBox(height: 50), buildButtons()],
        ),
      ),
    );
  }

  Widget buildTime() {
    return Text(
      '$seconds',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 80),
    );
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    setState(() => timer?.cancel());
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;
    return isRunning || !isCompleted
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ButtonWidget(text: "Cancel", onClicked: stopTimer)],
          )
        : ButtonWidget(
            text: "Start Timer",
            onClicked: () {
              startTimer();
            });
  }
}
