import 'package:boat_monitor/styles/colors.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:flutter/material.dart';

class DiskSpace extends StatefulWidget {
  DiskSpace(this.usedStorage, {Key key}) : super(key: key);
  double usedStorage;
  @override
  _DiskSpaceState createState() => _DiskSpaceState(this.usedStorage);
}

class _DiskSpaceState extends State<DiskSpace>
    with SingleTickerProviderStateMixin {
  double used;
  _DiskSpaceState(this.used);
  AnimationController _colorController;
  @override
  void initState() {
    // TODO: implement initState
    _colorController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {});
          });
    _colorController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _colorController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width -
          (marginExt1 * 2) -
          (marginInt * 2) -
          4,
      height: 19.0,
      child: diskSpace(context, used, 100.0),
    );
  }

  Widget diskSpace(BuildContext context, double used, double total) {
    //_colorController.value = 10.0;
    //print(_colorController.value);
    final _value = used / total;
    Color _color = blue;
    if (_value > 0.5) {
      _color = Colors.orange[400];
    }
    if (_value > 0.7) {
      _color = Color.fromRGBO(219, 99, 73, 1);
    }
    if (_value > 0.9) {
      _color = redAlert;
    }

    return Container(
      width: MediaQuery.of(context).size.width -
          (marginExt1 * 2) -
          (marginInt * 2) -
          4,
      height: 27.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            valueColor:
                _colorController.drive(ColorTween(begin: _color, end: _color)),

            backgroundColor: gray2,
            value: _value,
            minHeight: 10.0,
            //value: 10.0,
            //semanticsValue: used.toString(),
          ),
        ],
      ),
    );
  }
}
