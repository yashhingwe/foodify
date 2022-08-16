import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:foodify/result.dart';

import 'uploadImage.dart';

class Progress extends StatefulWidget {
  File? imageFile;
  Progress({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
var res ;
  @override
  void initState(){
    super.initState();
    fun();
  }
  fun()async{
    getPred(widget.imageFile).then((value){
      setState(() {
        
      });
    });
  }
  getPred(imageFile) async{
     Service service=Service();

      service.submitSubscription(file:imageFile!).then((value) {
        setState(() {
          res = value;
          flag = true;
        });
        return res;
      });
   }
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
            child: Text("Foodify", style: TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.bold)),
          ),
            elevation: 10,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
            color: Colors.black, //change your color here
      )
      ),
      body: !flag?Center(
        child: Container(
          child:Container(
            height: 400,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/food_load.gif"),
                    ),
          ),
        ),
      ):
      Result(res: res, imageFile: widget.imageFile)
    );
  }
}