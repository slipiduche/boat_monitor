import 'package:boat_monitor/bloc/alerts_bloc.dart';
import 'package:boat_monitor/styles/colors.dart';
import 'package:boat_monitor/styles/fontSizes.dart';
import 'package:flutter/material.dart';

onAfterBuild(BuildContext context) {
  if (AlertsBloc().alertValue != null) {
    switch (AlertsBloc().alertValue.type) {
      case "Updating":
        AlertsBloc().setAlertClosed = false;
        updating(context, AlertsBloc().alertValue.message);
        AlertsBloc().deleteAlert();
        break;
      case "Error":
        Navigator.of(context).pop();
        errorPopUp(context, AlertsBloc().alertValue.message, () {
          AlertsBloc().setAlertClosed = true;
          Navigator.of(context).pop();
        });
        AlertsBloc().deleteAlert();

        break;
      case "Updated":
        Navigator.of(context).pop();
        updated(context, AlertsBloc().alertValue.message, () {
          AlertsBloc().setAlertClosed = true;
          Navigator.of(context).pop();
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

void updated(BuildContext _context, String message, Function onTap) {
  BuildContext dialogContext;
  showDialog(
      context: _context,
      barrierDismissible: true,
      builder: (context) {
        dialogContext = _context;
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          //scrollable: true,
          insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Container(
            // height: 100.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Icon(
                  Icons.check,
                  size: 50.0,
                  color: blue1,
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0,
                          child: submitButton('OK', onTap),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
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
                      child: submitButton('OK', () {
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
