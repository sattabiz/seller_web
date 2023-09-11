// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CountdownDate extends StatefulWidget {
  final String headerDate;

  const CountdownDate({
    Key? key,
    required this.headerDate,
  }) : super(key: key);

  @override
  State<CountdownDate> createState() => _CountdownDateState();
}

class _CountdownDateState extends State<CountdownDate> {

  String formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(widget.headerDate);
    Duration formattedDate = parsedDate.difference(DateTime.now());
    return Countdown(
      seconds: formattedDate.inSeconds,
      build: (_, double time) {
        int timeInt = time.toInt();
        final int days = timeInt ~/ (24 * 3600);
        timeInt = timeInt % (24 * 3600);
        final int hours = timeInt ~/ 3600;
        timeInt %= 3600;
        final int minutes = timeInt ~/ 60;
        final int seconds = timeInt % 60;

        String formattedHours = formatTime(hours);
        String formattedMinutes = formatTime(minutes);
        String formattedSeconds = formatTime(seconds);

        return Text(
          "$days G $formattedHours:$formattedMinutes:$formattedSeconds",
          style: Theme.of(context).textTheme.bodySmall,
        );
      },
      interval: Duration(seconds: 1),
      onFinished: () {
        print('Zaman doldu!');
      },
    );
  }
}
