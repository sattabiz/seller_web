import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class AppbarLandingPage extends StatelessWidget implements PreferredSizeWidget {
  final AutoScrollController scrollController;
   const AppbarLandingPage({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      automaticallyImplyLeading: false,
      title: Align(
        alignment: AlignmentGeometry.lerp(
          Alignment.centerLeft,
          Alignment.center,
          0.2,
        )!,
        child: screenSize.width > 490
        ? SvgPicture.asset(
          'assets/white-logo.svg',
          height: 48,
          // width: 200,
          fit: BoxFit.fill,
          // alignment: Alignment.centerRight,
        )
        : Image.asset(
          'assets/favicon.png',
          height: 48,
          fit: BoxFit.fill,
        )
      ),
      actions: <Widget>[
        HoverActionButton(
          label: 'Ana Sayfa',
          onPressed: () => _scrollToSection(context, 0),
        ),
        SizedBox(width: screenSize.width / 30),
        HoverActionButton(
          label: 'Ürünler',
          onPressed: () => _scrollToSection(context, 1),
        ),
        SizedBox(width: screenSize.width / 30),
        HoverActionButton(
          label: 'İletişim',
          onPressed: () => _scrollToSection(context, 2),
        ),
        SizedBox(width: screenSize.width / 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _scrollToSection(BuildContext context, int index) {  //for scrolling related section in landing page
    scrollController.scrollToIndex(
      index, 
      preferPosition: AutoScrollPosition.begin, 
      duration: const Duration(milliseconds: 500),
    );
  }

}

class HoverActionButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const HoverActionButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  HoverActionButtonState createState() => HoverActionButtonState();
}

class HoverActionButtonState extends State<HoverActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: MaterialStateMouseCursor.clickable,
      child: InkWell(        
        onTap: widget.onPressed,
        mouseCursor: _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border(
              bottom: BorderSide(
                color: _isHovered
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.secondary,
                    width: 2,
              ),
            ),
          ),
          child: AutoSizeText(                                                                                                                
            widget.label,
            textAlign: TextAlign.right,
            softWrap: true,
            style:  _isHovered
            ? Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onPrimary,
              height: 1.8,
            )
            : Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ), 
          ),
        ),
      ),
    );
  }
}