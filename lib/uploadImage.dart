import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:foodify/result.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Service{
  
  
Future<String> submitSubscription({File? file})async{
    ///MultiPart request
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://flask-179.herokuapp.com/"),

    );
    Map<String,String> headers={
      "Content-type": "multipart/form-data"
    };
    var pic = await http.MultipartFile.fromPath(
           'file',
            file!.path
        );
    request.files.add(pic);
    print(file);
    request.headers.addAll(headers);
    request.fields.addAll({
      "id":"12345"
    });
    print("request: "+request.toString());
    var res = await request.send();
    var res2 = await res.stream.bytesToString();
    print("This is response:"+res2.toString());
    return res2;
  }
}