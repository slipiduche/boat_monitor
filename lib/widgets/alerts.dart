import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/bloc/argument_bloc.dart';
import 'package:boat_monitor/bloc/authentication_bloc.dart';
import 'package:boat_monitor/bloc/boats_bloc.dart';
import 'package:boat_monitor/bloc/currenBoatBloc.dart';
import 'package:boat_monitor/bloc/journeys_bloc.dart';
import 'package:boat_monitor/bloc/parameters_bloc.dart';
import 'package:boat_monitor/generated/l10n.dart';
import 'package:boat_monitor/styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:flutter/material.dart';

onAfterBuild(BuildContext context) {
  if (AlertsBloc().alertValue != null) {
    dynamic argument = ArgumentBloc().argumentValue;
    switch (AlertsBloc().alertValue.type) {
      case "Updating":
        if (!AlertsBloc().alertClosedValue) {
          Navigator.of(context).pop();
        }

        AlertsBloc().setAlertClosed = false;
        //Navigator.of(context).pop();
        updating(context, AlertsBloc().alertValue.message);
        AlertsBloc().deleteAlert();
        break;
      case "Error":
        if (!AlertsBloc().alertClosedValue) {
          Navigator.of(context).pop();
        }
        AlertsBloc().setAlertClosed = false;
        errorPopUp(context, AlertsBloc().alertValue.message, () {
          print(argument);
          AlertsBloc().setAlertClosed = true;
          Navigator.of(context).pop();
          if (AuthBloc().routeValue == 'signUpPage') {
            Navigator.pushReplacementNamed(context, AuthBloc().routeValue);
          } else if (AuthBloc().routeValue == 'currentBoatPage') {
            Navigator.of(context).pushReplacementNamed('homePage');
          } else if (AuthBloc().routeValue == 'changePasswordPage') {
            Navigator.of(context).pushReplacementNamed('loginPage');
          } else if (AuthBloc().routeValue == 'manageBoatResponsiblePage') {
            Navigator.of(context)
                .pushReplacementNamed('manageBoatPage', arguments: argument);
          } else {
            Navigator.of(context).pushReplacementNamed(AuthBloc().routeValue,
                arguments: argument);
          }
        });
        AlertsBloc().deleteAlert();

        break;
      case "Updated":
        if (!AlertsBloc().alertClosedValue) {
          Navigator.of(context).pop();
        }
        AlertsBloc().setAlertClosed = false;
        updated(context, AlertsBloc().alertValue.message, () {
          AlertsBloc().setAlertClosed = true;
          Navigator.of(context).pop();
          print(AuthBloc().routeValue);
          print(argument);
          if (AuthBloc().routeValue == 'signUpPage') {
            Navigator.pushReplacementNamed(context, 'loginPage');
          } else if (AuthBloc().routeValue == 'currentBoatPage') {
            JourneysBloc().setJourneys = null;
            Navigator.of(context).pushReplacementNamed('homePage');
          } else if (AuthBloc().routeValue == 'changePasswordPage') {
            Navigator.of(context).pushReplacementNamed('loginPage');
          } else if (AuthBloc().routeValue == 'manageBoatResponsiblePage') {
            Navigator.of(context)
                .pushReplacementNamed('manageBoatPage', arguments: argument);
          } else {
            Navigator.of(context).pushReplacementNamed(AuthBloc().routeValue,
                arguments: argument);
          }
        });
        AlertsBloc().deleteAlert();

        break;
      default:
    }
  }
}

void updating(BuildContext _context, String message) {
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_context) {
        //_updatingContext = _context;
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          insetPadding: EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            //height: 200.0,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(blue1),
                ),
                Text(
                  '$message...',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: blue1,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        );
      });
}

void updated(BuildContext _context, String message, Function function) {
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          //scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),

          insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Icon(
                      Icons.check,
                      size: 50.0,
                      color: blue,
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50.0,
                //margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: submitButton(
                          TextLanguage.of(context).ok.toUpperCase(), () {
                        function();
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

Widget submitButtonS(text, void Function() function) {
  return GestureDetector(
      onTap: function,
      child: Column(
        children: [
          Divider(
            color: gray1,
            thickness: 1.0,
            height: 1.0,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: statusSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(20.0)),
                //border: Border(top: BorderSide(color: gray1)),
                //borderRadius: BorderRadius.circular(10.0),
                color: blue,
                boxShadow: [boxShadow1],
              ),
            ),
          ),
        ],
      ));
}

Widget submitButtonNo(text, void Function() function) {
  return GestureDetector(
      onTap: function,
      child: Column(
        children: [
          Divider(
            color: gray1,
            thickness: 1.0,
            height: 1.0,
          ),
          Expanded(
            child: Container(
              //padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: statusSize,
                      color: colorVN,
                      fontWeight: FontWeight.w400),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20.0)),
                //border: Border(top: BorderSide(color: gray1)),
                //borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [boxShadow1],
              ),
            ),
          ),
        ],
      ));
}

Widget submitButton(text, void Function() function) {
  Color activado;
  activado = blue;
  if (function == null) {
    activado = gray2;
  }
  return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: statusSize,
                color: Colors.white,
                fontWeight: FontWeight.w400),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0)),
          color: activado,
          boxShadow: [boxShadow1],
        ),
      ));
}

void errorPopUp(BuildContext _context, String message, Function function) {
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          //scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),

          insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Icon(
                      Icons.error_outline,
                      size: 50.0,
                      color: Colors.red,
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50.0,
                //margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: submitButton(
                          TextLanguage.of(context).ok.toUpperCase(), () {
                        function();
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

void confirmationDialog(BuildContext _context, String contain, String title,
    Function functionYes(), void functionNo()) {
  showDialog(
      //useRootNavigator: false,
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            print('popopop');
          },
          child: Container(
            //width: MediaQuery.of(context).size.width - 28,
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
              child: Container(
                //height: 200.0,
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20.0),
                          width: 200,
                          child: Text(
                            title,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: statusSize, color: blue1),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      //height: 40.0,

                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: marginInt),
                            child: Text(contain,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20.0)),
                          ),
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
                                  child: submitButtonS(
                                      TextLanguage.of(context).yes, () async {
                                    await functionYes();
                                  }),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50.0,
                                  child: submitButtonNo(
                                      TextLanguage.of(context).no, () async {
                                    await functionNo();
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
          ),
        );
      });
}

void parametersDialog(
    BuildContext _context, String message, void functionDone()) {
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          //scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),

          insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20.0, color: blue1),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        onChanged: (value) {
                          ParametersBloc().setParametersField = value;
                        },
                        keyboardType: TextInputType.number,
                        //obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          hintText: TextLanguage.of(context).typeNumber,

                          //counterText: snapshot.data,

                          // icon: Icon(Icons.lock)
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50.0,
                //margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: submitButton(TextLanguage.of(context).done, () {
                        functionDone();
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

void boatNameDialog(
    BuildContext _context, String message, void functionDone()) {
  BoatsBloc().setBoatName = null;
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          //scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),

          insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      message,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20.0, color: blue1),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        onChanged: (value) {
                          BoatsBloc().setBoatName = value;
                        },
                        keyboardType: TextInputType.name,
                        //obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          hintText: TextLanguage.of(context).typeBoatName,

                          //counterText: snapshot.data,

                          // icon: Icon(Icons.lock)
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50.0,
                //margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: submitButton(TextLanguage.of(context).done, () {
                        functionDone();
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
