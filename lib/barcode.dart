import 'dart:async';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class BarcodeScan extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<BarcodeScan> {
  String result = "Nothing Scanned";
  String barcode1 = "";
  String country = "";

  @override
  initState() {
    super.initState();
  }

  File galleryFile;


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          body: new Center(
            child: new Column(
              children: <Widget>[
                SizedBox(height: 50,),
                Container(
                  child: new RaisedButton(
                      color: Colors.cyan,
                      onPressed: _barcodeScanning,
                      child: new Text("Scan Barcode")),
                  padding: const EdgeInsets.all(8.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Text("Barcode Number after Scan : " + result),
                SizedBox(height: 30,),
                Text("Product origin: "+prefixbarcode(result)),
                SizedBox(height: 20,),
                Container(
                  child: countryflag(country),
                )
                // displayImage(),
              ],
            ),
          )),
    );
  }

  Widget displayImage() {
    return new SizedBox(
      height: 300.0,
      width: 400.0,
      child: galleryFile == null
          ? new Text('Sorry nothing to display')
          : new Image.file(galleryFile),
    );
  }

// Method for scanning barcode....
  Future _barcodeScanning() async {
//imageSelectorGallery();
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        result = barcode;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = 'No camera permission!';
        });
      } else {
        setState(() => result = 'Unknown error: $ex');
      }
    } on FormatException {
      setState(() =>
      result =
      'Nothing captured.');
    } catch (e) {
      setState(() => result = 'Unknown error: $e');
    }
  }

  String prefixbarcode(String barcode1)
  {
    String prefix = barcode1.substring(0,3);
    try {
      var code1 = int.parse(prefix, radix: 10);
      if (code1 == 890) {
        country = "India";

      }
      else if (code1 == 380) {
        country = 'Bulgaria';
      }
      else if(code1 >= 100 && code1 <=139)
      {
        country = 'United States of America (USA)';
      }
      else if(code1 >= 300 && code1 <=379)
      {
        country = 'France & Monacco';
      }
      else if(code1 == 383)
      {
        country = 'Slovenia';
      }
      else if(code1 == 385 )
      {
        country = 'Croatia';
      }
      else if(code1 == 387)
      {
        country = 'Bosnia and Herzegovina';
      }
      else if(code1 >= 300 && code1 <=379)
      {
        country = 'France & Monacco';
      }
      else if(code1 == 389)
      {
        country = 'Montenegro';
      }
      else if(code1 == 390)
      {
        country = 'Kosovo';
      }
      else if(code1 >= 400 && code1 <=440)
      {
        country = 'Germany';
      }
      else if(code1 >= 450 && code1 <=459)
      {
        country = 'Japan';
      }
      else if(code1 >= 460 && code1 <=469)
      {
        country = 'Russia';
      }
      else if(code1 >= 500 && code1 <=509)
      {
        country = 'United Kingdom';
      }


    }on FormatException {
      print('Format error!');
    }
    return country;
  }

  Widget countryflag(String flag)
  {
    if (flag == 'India')
    {
      return Flag('IN',height: 200,width: 200,);
    }
    else if (flag == 'United States of America (USA)')
    {
      return Flag('US',height: 200, width: 200,);
    }
    else if (flag == 'Bulgaria')
    {
      return Flag('BG', height: 200, width: 200,);
    }
    else if (flag == 'Germany')
    {
      return Flag('DE', height: 200, width: 200,);
    }
    else if (flag == 'United Kingdom')
    {
      return Flag('GB', height: 200, width: 200,);
    }
  }
}
