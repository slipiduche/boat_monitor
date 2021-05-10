import 'package:boat_monitor/Icons/icons.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';

import 'alerts.dart';

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
                      SizedBox(width: 10.0),
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

PreferredSizeWidget gradientAppBar3(
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
                      SizedBox(width: 10.0),
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
    currentIndex: _itemselected,
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
        .pushReplacementNamed('homePage', arguments: null);
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

Widget statusIcon(double size, int status) {
  LinearGradient _gradiente;
  if (status == 1) {
    _gradiente = blueGradient3;
    print('status1');
  } else if (status == 0) {
    _gradiente = grayGradient;
    print('estatus0:$status');
  } else {
    _gradiente = redGradient;
    print('estatus3:$status');
  }
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0), gradient: _gradiente),
  );
}

Widget dialogConfirmation(
    BuildContext context, String contain, String title, bool function) {
  return Container(
    //width: MediaQuery.of(context).size.width - 28,
    child: Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
      child: Container(
        //height: 200.0,
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0),
              width: double.infinity,
              //height: 30.0,
              //color: colorMedico,
              child: Center(
                  child: Text(
                title,
                style: TextStyle(fontSize: statusSize, color: blue1),
              )),
            ),
            Container(
              //height: 40.0,

              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(contain,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0)),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0,
                          child: submitButtonS('Yes', () async {
                            print('deleting');

                            updating(context, 'Deleting');
                            //print(upSong.toJson());
                            bool resp = function;
                            await Future.delayed(Duration(seconds: 1));
                            if (resp) {
                              print('deleted');

                              updated(context, 'Succes', () {});
                            } else {
                              print('error');

                              errorPopUp(context, 'Error', () {});
                            }
                          }),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50.0,
                          child: submitButtonNo('No', () async {
                            print('deleting');
                            Navigator.of(context).pop();
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
