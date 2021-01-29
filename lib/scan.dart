import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code/services/api_service.dart';
import 'package:qr_code/widgets/accounts_data.dart';
import 'package:qr_code/widgets/custom_divider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool loading = false;
  String fname;
  String sname;
  String email;
  String phone;
  String tier;
  //scan qr code
  Future _scan() async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      setState(() {
        loading = true; //setloading to true
      });
      ApiService apiService = ApiService();
      var data = await apiService.getUser(id: num.tryParse(barcode));
      setState(() {
        fname = data['firstname'];
        sname = data['lastname'];
        email = data['email'];
        phone = data['phone'];
        tier = data['tier'];

        //set loading to false
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F5F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w700,
                      fontSize: 28.0,
                    ),
                  ),
                  SizedBox(height: 13),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 33,
                        width: 31,
                        decoration: BoxDecoration(
                          color: Color(0XFFBE44AD),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BarCode Enterprise',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF7B7B7B),
                              ),
                            ),
                          ),
                          Text(
                            'Joined since 12 Jan, 2021',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF7B7B7B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  loading
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          height: 450,
                          width: MediaQuery.of(context).size.width * 1,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: <Widget>[
                              AccountsData(
                                label: 'First Name',
                                value: fname ?? "",
                              ),
                              CustomDivider(),
                              AccountsData(
                                label: 'Last Name',
                                value: sname ?? "",
                              ),
                              CustomDivider(),
                              AccountsData(
                                label: 'Email',
                                value: email ?? "",
                              ),
                              CustomDivider(),
                              AccountsData(
                                label: 'Phone',
                                value: phone ?? "",
                              ),
                              AccountsData(
                                label: 'Tier',
                                value: tier ?? "",
                              ),
                            ],
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _scan, tooltip: 'Scan', child: const Icon(Icons.scanner)),
    );
  }
}