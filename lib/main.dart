import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  File _imageFile;

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(
      source: source,
    ).then((File image) {
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150.0,
          padding: EdgeInsets.all(10.0),
          child: Column(children: [
            Text(
              'Pick an Image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Text('Use Camera'),
              onPressed: () {
                _getImage(context, ImageSource.camera);
              },
            ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Text('Use Gallery'),
              onPressed: () {
                _getImage(context, ImageSource.gallery);
              },
            )
          ]),
        );
      },
    );
  }

  Widget _buildImagePreview() {
    if (_imageFile == null) {
      return Container(
        height: 200.0,
        color: Colors.grey,
      );
    }

    return Image.file(
      _imageFile,
      fit: BoxFit.cover,
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Bug'),
      ),
      body: Column(
        children: <Widget>[
          _buildImagePreview(),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Text('Select image'),
            onPressed: () {
              _openImagePicker(context);
            },
          ),
        ],
      ),
    );
  }
}
