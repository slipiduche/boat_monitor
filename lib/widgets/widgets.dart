import 'package:boat_monitor/Icons/icons.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';

PreferredSizeWidget gradientAppBar(String title, Function onBackPressed) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: Container(
      height: 50.0,
      width: double.infinity,
      decoration:
          BoxDecoration(gradient: blueGradient1, boxShadow: [boxShadow1]),
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: titleBarSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: blue,
            ),
            onPressed: onBackPressed),
      ]),
    ),
  );
}

PreferredSizeWidget gradientAppBar2(
    String title, Widget icon, Function onBackPressed) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: Container(
      height: 50.0,
      width: double.infinity,
      decoration:
          BoxDecoration(gradient: blueGradient1, boxShadow: [boxShadow1]),
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      SizedBox(width:10.0),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: correoSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: blue,
            ),
            onPressed: onBackPressed),
      ]),
    ),
  );
}

BottomNavigationBar botomBar(_itemselected, context) {
  return BottomNavigationBar(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: blue1,
    items: [
      BottomNavigationBarItem(
          label: '',
          icon: homeIcon(25.0, gray),
          activeIcon: homeIcon(25.0, blue)),
      BottomNavigationBarItem(
          label: '',
          icon: historicsIcon(25.0, gray),
          activeIcon: historicsIcon(25.0, blue)),
      BottomNavigationBarItem(
          label: '',
          icon: storageIcon(25.0, gray),
          activeIcon: storageIcon(25.0, blue)),
      BottomNavigationBarItem(
          label: '',
          icon: profileIcon(25.0, gray),
          activeIcon: profileIcon(25.0, blue)),
    ],
    type: BottomNavigationBarType.fixed,
    //currentIndex: _itemselected,
    onTap: (valor) {
      _onItemTapped(context, valor);
    },
  );
}

void _onItemTapped(context, index) async {
  //_itemselected = index;
  print('presionaste:');
  print(index);

  if (index == 0) {
    await Navigator.of(context)
        .pushReplacementNamed('managerPage', arguments: null);
  }

  if (index == 1) {
    await Navigator.of(context)
        .pushReplacementNamed('managerPage', arguments: null);
  }
  if (index == 2) {
    await Navigator.of(context)
        .pushReplacementNamed('managerPage', arguments: null);
  }
  if (index == 3) {
    await Navigator.of(context)
        .pushReplacementNamed('managerPage', arguments: null);
  }
}
