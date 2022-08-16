import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:foodify/progress.dart';
import 'package:foodify/result.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'uploadImage.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}
class _MyPageState extends State<MyPage> {
  /// Variables
  String res = "";
  File? imageFile = null;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Foodify", style: TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.bold))),
            elevation: 10,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
            color: Colors.black, //change your color here
      )
      ),
        body: Container(
          color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // <-- Radius
                    ),
                    primary: Colors.purple[300],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    ),
                    onPressed: () {
                      _getFromGallery(context);
                    },
                    child: Wrap(children: <Widget>[
                        Icon(
                          CupertinoIcons.photo,
                          size: 30.0,
                      ),
                      SizedBox(
                          width:10,
                      ),
                      Text("PICK FROM GALLERY",style: TextStyle(fontSize: 20))
                    ]),
                  ),
                  Container(
                    height: 40.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    primary: Colors.purple[300],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // <-- Radius
                    ),
                    ),
                    onPressed: () {
                      _getFromCamera(context);
                    },
                    child: Wrap(children: <Widget>[
                        Icon(
                          CupertinoIcons.camera,
                          size: 30.0,
                      ),
                      SizedBox(
                          width:10,
                      ),
                      Text("PICK FROM Camera",style: TextStyle(fontSize: 20),),
                      
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 120, 8, 2),
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/logo_2.png"),
                  ),
                ),
              )
                ],
              ),
            )
            
          );
  }

  /// Get from gallery
  _getFromGallery(BuildContext context) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Progress(imageFile: imageFile)));
    }
  }
 
  /// Get from Camera
  _getFromCamera(BuildContext context) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Progress(imageFile: imageFile)));
    }

  }
}



callApi( File file) async{
  var request = http.MultipartRequest('POST', Uri.parse('https://flask-179.herokuapp.com/'));
  var pic = http.MultipartFile('image', file.readAsBytes().asStream(), file.lengthSync(),
      filename: basename(file.path));
  request.files.add(pic);
  var response = await request.send();
  var response_data = await response.stream.toBytes();
  var result = String.fromCharCodes(response_data);
  print(response.statusCode);
  print(result);
  return result;
}

