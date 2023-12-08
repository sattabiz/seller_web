// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

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
  late DateTime parsedDate;
  Duration? remainingTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    parsedDate = DateTime.parse(widget.headerDate);

    calculateRemainingTime();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      calculateRemainingTime();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  void calculateRemainingTime() {
    DateTime now = DateTime.now();
    if (now.isBefore(parsedDate)) {
      remainingTime = parsedDate.difference(now);

      //for update counter
      setState(() {});
    } else {
      remainingTime = Duration.zero;
      //if time is up, cancel timer
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    String remainingTimeString =
        "${remainingTime?.inDays} G ${remainingTime?.inHours.remainder(24).toString().padLeft(2, '0')}:${remainingTime?.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingTime?.inSeconds.remainder(60).toString().padLeft(2, '0')}";

    return Text(
      remainingTimeString,
      style: const TextStyle(color: Colors.black, fontSize: 12),
    );
  }
}
