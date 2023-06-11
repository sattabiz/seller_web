import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class AppbarLandingPage extends StatelessWidget implements PreferredSizeWidget {
  final AutoScrollController scrollController;
   const AppbarLandingPage({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      automaticallyImplyLeading: false,
      title: Image.asset(
        'assets/images/header_white_logo.png',
        height: 55,
        fit: BoxFit.contain,
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  void _scrollToSection(BuildContext context, int index) {  //for scrolling related section in landing page
    scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin, duration: Duration(milliseconds: 500),);
  }

}

class HoverActionButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const HoverActionButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  _HoverActionButtonState createState() => _HoverActionButtonState();
}

class _HoverActionButtonState extends State<HoverActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: MaterialStateMouseCursor.clickable,
      child: InkWell(        
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isHovered
                    ? Theme.of(context).colorScheme.onPrimary
                    : Colors.transparent,
                    width: 2
              ),
            ),
          ),
          child: Text(
            widget.label,
            style: _isHovered 
            ? Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
            )
            :  Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ), 
          ),
        ),
      ),
    );
  }
}