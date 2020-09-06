import 'package:flutter/material.dart';
import 'package:textscan/textscanner.dart';
import 'package:image_picker/image_picker.dart';

const String TEXT_SCANNER = 'TEXT_SCANNER';

class MLHome extends StatefulWidget {
  MLHome({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MLHomeState();
}

class _MLHomeState extends State<MLHome> {
  static const String CAMERA_SOURCE = 'CAMERA_SOURCE';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _selectedScanner = TEXT_SCANNER;

  @override
  Widget build(BuildContext context) {
    final columns = List<Widget>();
    columns.add(buildSelectImageRowWidget(context));

    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: columns,
          ),
        ));
  }

  Widget buildSelectImageRowWidget(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 300,),
          Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: RaisedButton(
                    color: Colors.cyan,
                    textColor: Colors.black,
                    splashColor: Colors.blueGrey,
                    onPressed: () {
                      onPickImageSelected(CAMERA_SOURCE);
                    },
                    child: const Text('Scan Product')),
              ),
        ],
      ),
    );
  }

  void onPickImageSelected(String source) async {
    var imageSource;
    if (source == CAMERA_SOURCE) {
      imageSource = ImageSource.camera;
    }

    final scaffold = _scaffoldKey.currentState;

    try {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file == null) {
        throw Exception('File is not available');
      }

      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => MLDetail(file, _selectedScanner)),
      );
    } catch (e) {
      scaffold.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}