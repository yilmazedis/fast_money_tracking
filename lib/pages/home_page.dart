import 'package:fast_money_tracking/pages/calendar_pages/calendar_page.dart';
import 'package:flutter/material.dart';
import '../localization/methods.dart';
import '../utils/constants.dart';
import 'analysis_pages/analysis_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() { // Avoid using private types in public APIs.
    return _HomePageState();
  }
  //
  // @override
  // _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  List<Widget> myBody = [
    AnalysisPage(),
    CalendarPage(),
  ];

  BottomNavigationBarItem bottomNavigationBarItem(
      BuildContext context, IconData iconData, String label) =>
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Icon(
            iconData,
          ),
        ),
        label: getTranslated(context, label),
      );

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomItems = <BottomNavigationBarItem>[
      bottomNavigationBarItem(context, Icons.analytics_outlined, 'Analysis'),
      bottomNavigationBarItem(context, Icons.calendar_today, 'Calendar'),
    ];

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: grey,
            ),
          ],
        ),
        child: BottomNavigationBar(
          iconSize: 27,
          selectedFontSize: 16,
          unselectedFontSize: 14,
          backgroundColor: white,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.black87,
          type: BottomNavigationBarType.fixed,
          items: bottomItems,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      // if you want to keep alive each pages without making them stateful widget.
      // with this -> AutomaticKeepAliveClientMixin
      body: IndexedStack(index: _selectedIndex, children: myBody),
    );
  }
}
