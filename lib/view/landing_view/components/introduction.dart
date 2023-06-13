import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Introduction extends ConsumerWidget {
  final int sectionIndex;

  const Introduction({Key? key, required this.sectionIndex})
      : super(key: key);
        
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color surfaceContainer = Color(0xFFECEEEB);
    return Container(  
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.all(32.0),
      color: surfaceContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Title(),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          SizedBox(
            width: 500,
            height: 108,
            child: About(),
          ),
          Spacer(flex: 1,),
          LogInButton(),
          SizedBox(height: 10),
          SignIn(),
    
        ],
      ),
    );
  }
}
class Title extends ConsumerWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoSizeText(
      "Palet Point", 
      style: Theme.of(context).textTheme.displayLarge, 
      maxLines: 2
    );
  }
}

class About extends ConsumerWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoSizeText(
      "sed viverra eget tincidunt ultrices luctus ultrices lacus id ac hendrerit tincidunt viverra lacus nisi commodo lacus, in Donec Praesent odio amet, Lorem vitae",
      style: Theme.of(context).textTheme.headlineMedium,
      maxLines: 3,
    );
  }
}

class LogInButton extends ConsumerWidget {
  const LogInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      }, 
      child: const Text('Uye Girisi', style: TextStyle(color: Colors.white)),
    );
  }
}

class SignIn extends ConsumerWidget {
  const SignIn ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18),
        elevation: 4,
      ),
      onPressed: () {},
      child: const Text(
        'Uye Ol  ',
        textAlign: TextAlign.center ,
        style: TextStyle(
          decoration: TextDecoration.underline, 
          color: Colors.black,),
      ),
    );
  }
}

