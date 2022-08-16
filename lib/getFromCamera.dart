import 'dart:io';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class GetFromCamera extends StatefulWidget {
  @override
  _GetFromCameraState createState() => _GetFromCameraState();
}
class _GetFromCameraState extends State<GetFromCamera> {
  /// Variables
  String res = "";
  File? imageFile = null;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: Container(
            child: imageFile == null?
                getLoad():
        SingleChildScrollView(
              child: Column(
                children: [
                  Image.file(
                imageFile!,
                fit: BoxFit.cover),
                Text(res),
                ],
              ),
            )         
        )
        );
  }

  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      var result = await callApi(imageFile!);
      setState(() {
        res = result;
      });
    }
    else{
      setState(() {
        
      });
    }
  }
  getLoad(){
   return Image.asset(  
          'assets/food_load.gif',gaplessPlayback: true, 
      );
      setState(() {
        _getFromCamera();
      });
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

