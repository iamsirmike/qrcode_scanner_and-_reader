import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:qr_code/scan.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  GlobalKey globalKey = new GlobalKey();
  int data;
  @override
  void initState() {
    super.initState();
    data = Random().nextInt(99) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: _contentWidget(),
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('QR CODE is randomly generated using the user ID'),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: data.toString(),
                  size: 0.5 * bodyHeight,
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanScreen()),
              );
            },
            color: Colors.blue,
            child: Text('Go to scan page'),
          ),
        ],
      ),
    );
  }
}
