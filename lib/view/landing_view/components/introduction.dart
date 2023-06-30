import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Introduction extends StatelessWidget {
  final int sectionIndex;
  final String title;
  final String ?introduction;
  final String ?bgImage;

  const Introduction({
    Key? key, 
    required this.sectionIndex,
    required this.title,
    this.introduction,
    this.bgImage,
    }) : super(key: key);
        
  @override
  Widget build(BuildContext context) {
    const Color surfaceContainer = Color(0xFFECEEEB);
    return Stack(
      children : [
        Container(  
        width: double.infinity,
        height: 400,
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: surfaceContainer,
          image: DecorationImage(
            image: NetworkImage(bgImage ?? ""),
            // errorBuilder: (context, error, stackTrace) => const SizedBox(), 
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  <Widget>[
            Title(title),
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            SizedBox(
              width: 500,
              height: 108,
              child: About(introduction ?? ""),
            ),
            const Spacer(flex: 1),
            const LogInButton(),
            const SizedBox(height: 10),
            const SignIn(),
      
          ],
        ),
      ),
      ]
    );
  }
}
class Title extends StatelessWidget {
  final String title;
  const Title(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title, 
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      maxLines: 2
    );
  }
}

class About extends StatelessWidget {
  final String introduction;
  const About(this.introduction, {super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      introduction,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      maxLines: 3,
      textAlign: TextAlign.center,
    );
  }
}

class LogInButton extends StatelessWidget {
  const LogInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
      ), 
      child:  Text(
        FlutterI18n.translate(context, "tr.login.log_in"), 
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn ({super.key});

  @override
  Widget build(BuildContext context) {
    const Color surfaceContainer = Color(0xFFECEEEB);
    return TextButton(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        foregroundColor: surfaceContainer,
      ),
      onPressed: () {},
      child:  Text(
        FlutterI18n.translate(context, "tr.login.sign_in"), 
        style: TextStyle(
          color: Theme.of(context).colorScheme.scrim,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

