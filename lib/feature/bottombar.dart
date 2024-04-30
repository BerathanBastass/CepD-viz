import 'package:cepdovizapp/feature/%20currency/view/currency_page.dart';
import 'package:cepdovizapp/feature/conversion/view/conversion_page.dart';
import 'package:cepdovizapp/feature/settings/settings/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core /utils/custom_colors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedItemPosition = 0;


  final List<Widget> _pages = [
    const CurrencyListPage(),
    const CurrencyConverterPage(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.salt,
      body: _pages[_selectedItemPosition],
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.circle,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: const EdgeInsets.all(20),
        snakeViewColor: CustomColors.saltWhite,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.coins),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.codeCompare),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userGear),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
