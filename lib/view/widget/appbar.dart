import 'package:flutter/material.dart';

class AppbarTop extends StatelessWidget implements PreferredSizeWidget {
  const AppbarTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.of(context).size.width;
        double screenHeight =
        MediaQuery.of(context).size.height;
    return PreferredSize(
      preferredSize:preferredSize,
      child: AppBar(              
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading:MediaQuery.of(context).size.width < 1070,
        title: Image.asset(
          'assets/logo.png',
          width: screenWidth * 0.10,
          fit: BoxFit.contain,
        ),
        actions: <Widget>[
          Flexible(
            child: Text(
              'ABC Polimer A.S.',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: screenWidth * 0.02,
                  ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.013,
          ),
          Flexible(
            child: Text(
              'Mehmet Turan',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: screenWidth * 0.01,
                  ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.013,
          ),
          Flexible(
            child: IconButton(
              icon: Icon(Icons.format_list_bulleted, color: Theme.of(context).colorScheme.onPrimary,size: screenWidth * 0.02,),
              tooltip: 'Go to the next page',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Next page'),
                      ),
                      body: const Center(
                        child: Text(
                          'This is the next page',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ),
          const SizedBox(width: 20,)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
