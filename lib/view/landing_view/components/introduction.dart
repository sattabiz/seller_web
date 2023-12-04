import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_point/view/landing_view/components/page_indicator.dart';

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
    return Container(  
      width: double.infinity,
      height: 600,
      padding: const EdgeInsets.only(top: 60.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        image: DecorationImage(
          image: NetworkImage(bgImage ?? ""),
          // errorBuilder: (context, error, stackTrace) => const SizedBox(), 
          fit: BoxFit.cover,
        ),
      ),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  <Widget>[
          // SizedBox(height: screenSize.height / 50),
          Title(title),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: PageIndicator(paragraphs: introduction!),
            )),
          const Spacer(flex: 1),
          const LogInButton(),
          const SizedBox(height: 12),
          const SignIn(),
          const Spacer(flex: 1),        
        ],
      ),
    );
  }
}
class Title extends StatelessWidget {
  final String title;
  const Title(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: AutoSizeText(
        title, 
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class LogInButton extends StatelessWidget {
  const LogInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { context.go('/login');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
        fixedSize: MaterialStateProperty.all<Size>(const Size(150, 50)),
      ), 
      child:  Text(
        FlutterI18n.translate(context, "tr.login.log_in"), 
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w500),
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
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          decorationColor: Theme.of(context).colorScheme.onPrimary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

