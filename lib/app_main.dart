import 'package:flutter/material.dart';

import 'routes/category2/category2.dart';
import 'routes/category3/category3.dart';
import 'routes/dowith/dowith_home.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  late List<Widget> _pageList;
  late PageController _pageController;
  var _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _pageList = const [
      DowithHome(),
      CategoryTwo(),
      CategoryThree(),
    ];
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (selectedIndex) {
          setState(() {
            _selectedIndex = selectedIndex;
            _pageController.jumpToPage(selectedIndex);
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        ],
      ),
    );
  }
}
