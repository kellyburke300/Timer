import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer',
      theme: ThemeData(

        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: MyHomePage(),
      );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _seconds = 0;
  int _centiSeconds = 0;

  final centFormat = new NumberFormat("00");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Timer"),
        ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                centFormat.format(_seconds) + ':' + centFormat.format(_centiSeconds),
              style: TextStyle(fontSize: 96.0, color: Colors.grey  ),
              ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (timer?.isActive ?? false) FlatButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: _stopTimer,
                    child: Text(" STOP ", style: TextStyle(fontSize: 36.0, backgroundColor: Colors.red, color: Colors.white70),),
                    ) else FlatButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: _startTimer,
                    child: Text(" START ", style: TextStyle(fontSize: 36.0, backgroundColor: Colors.green, color: Colors.white70),),
                    ),

                  FlatButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: _reset,
                    child: Text(" RESET ", style: TextStyle(fontSize: 36.0, backgroundColor: Colors.orange, color: Colors.white70),),
                    ),
                ],
                ),
            )
          ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
  }

  Timer timer;

  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (_centiSeconds >= 99) {
        setState(() {
          _seconds++;
          _centiSeconds = 0;
        });
      }
      else {
        setState(() {
          _centiSeconds++;
        });
      }
    });
  }

  void _stopTimer() {
    timer.cancel();
    setState(() {});
  }

  void _reset() {
    if(timer.isActive){
      timer.cancel();
    }
    setState(() {
      _centiSeconds = 0;
      _seconds = 0;
    });
  }
}
