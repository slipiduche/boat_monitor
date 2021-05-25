import 'package:boat_monitor/styles/colors.dart';
import 'package:boat_monitor/styles/margins.dart';
import 'package:flutter/material.dart';

class DiskSpace extends StatefulWidget {
  DiskSpace({Key key}) : super(key: key);

  @override
  _DiskSpaceState createState() => _DiskSpaceState();
}

class _DiskSpaceState extends State<DiskSpace>
    with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width -
          (marginExt1 * 2) -
          (marginInt * 2) -
          4,
      height: 27.0,
      child: diskSpace(context, 20.0, 100.0),
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
          SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${_value * 100} %',
                style: TextStyle(
                    color: blue1, fontWeight: FontWeight.bold, fontSize: 10.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
