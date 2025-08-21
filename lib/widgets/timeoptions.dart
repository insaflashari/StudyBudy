import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studybuddy/timerservice.dart';
import 'package:studybuddy/utils.dart';
import 'dart:ui';

class TimeOptions extends StatefulWidget {
  @override
  _TimeOptionsState createState() => _TimeOptionsState();
}

class _TimeOptionsState extends State<TimeOptions> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Approx width + margin per item = 80, adjust if needed
    _scrollController = ScrollController(initialScrollOffset: 25 * 80.0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);

    return SizedBox(
      height: 50,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse, // enable mouse dragging on web
          },
        ),
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            ...selectableTimes.map((time) {
              final isSelected = int.parse(time) == provider.selectedTime;
              return InkWell(
                onTap: () => provider.selectTime(double.parse(time)),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 70,
                  height: 50,
                  decoration: isSelected
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        )
                      : BoxDecoration(
                          border: Border.all(width: 3, color: Colors.white30),
                          borderRadius: BorderRadius.circular(5),
                        ),
                  child: Center(
                    child: Text(
                      (int.parse(time) ~/ 60).toString(),
                      style: textStyle(
                        25,
                        isSelected
                            ? renderColor(provider.currentState)
                            : Colors.white,
                        FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
