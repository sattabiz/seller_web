import 'package:flutter/material.dart';


class LoadingWidget extends StatefulWidget {
  const LoadingWidget({ Key? key }) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> 
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Center(
      widthFactor: 40,
      heightFactor: 40,
      child: CircularProgressIndicator(
        valueColor:  AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
        value: controller.value,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}

// class LoadingWidget extends State {
// const LoadingWidget({ Key? key }) : super(key: key);


//   @override
//   Widget build(BuildContext context){
//     return  Center(
//       widthFactor: 40,
//       heightFactor: 40,
//       child: CircularProgressIndicator(
//         valueColor:  CurvedAnimation<Color>(Theme.of(context).colorScheme.primary),
//         value: 0.0,
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//       ),
//     );
//   }
// }