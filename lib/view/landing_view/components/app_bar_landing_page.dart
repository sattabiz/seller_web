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
      title: Padding(
        padding: const EdgeInsets.only(left: 65.0),
        child: SvgPicture.asset(
          'assets/white-logo.svg',
          height: 48,
          fit: BoxFit.contain,
          // alignment: Alignment.centerRight,
        ),
      ),
      actions: <Widget>[
        HoverActionButton(
          label: 'Ana Sayfa',
          onPressed: () => _scrollToSection(context, 0),
        ),
        SizedBox(width: screenSize.width / 25),
        HoverActionButton(
          label: 'Ürünler',
          onPressed: () => _scrollToSection(context, 1),
        ),
        SizedBox(width: screenSize.width / 25),
        HoverActionButton(
          label: 'İletişim',
          onPressed: () => _scrollToSection(context, 2),
        ),
       const SizedBox(width: 70,)
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
          child: Text(                                                                                                                
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