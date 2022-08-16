import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/details.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  String res;
  File? imageFile;
  Result({
    Key? key,
    required this.res,
    required this.imageFile,
  }) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var details;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.file(
                              widget.imageFile!,
                              fit: BoxFit.cover),
                ),
              SizedBox(height: 20,),
              Text(widget.res, style: TextStyle(fontSize: 30),),
              SizedBox(height:20),
              ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    primary: Colors.purple[300],
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), 
                    ),
                    ),
                    onPressed: () {
                       getDetails(widget.res).then((value){
                         setState(() {
                           details = value;

                         });
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(det: details, res:widget.res, imageFile: widget.imageFile,)));
                       });
                    },
                    child: Wrap(children: <Widget>[
                        Icon(
                          CupertinoIcons.pencil_ellipsis_rectangle,
                          size: 30.0,
                      ),
                      SizedBox(
                          width:10,
                      ),
                      Text("Get Details",style: TextStyle(fontSize: 20),),
                      
                    ]),
                  ),
              ],
            ),
          ),
        ),
    );
  }
}

Future<Map> getDetails (String res) async {
  var url ='https://flask-179.herokuapp.com/recipe';


  //encode Map to JSON
  var body = json.encode({"food":res});

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.statusCode}");
  print("${response.body}");
  return jsonDecode(response.body);
}