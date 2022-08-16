import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  var det;
  String res;
  File? imageFile;
  Details({
    Key? key,
    required this.det,
    required this.res,
    required this.imageFile
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  Widget build(BuildContext context) {
    print(widget.det);
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
        color: Colors.black, //change your color here
        )
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.file(
                                        widget.imageFile!,
                                        fit: BoxFit.cover),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(capitalize(widget.res) ,style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Text("Major Ingredients : ", style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.det["Ingredients"]),
                    ),
                    Text("Diet : ", style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.det["Diet"]),
                    ),
                    Text("Prep Time : ", style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${widget.det["prep_time"]} min",),
                    ),
                    Text("Cook Time : ", style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${widget.det["cook_time"]} min",),
                    ),
                    Text("flavor Profile : ", style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.det["flavor_profile"]),
                    ),
                    Text("Course : ", style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.det["course"]),
                    ),
                    Text("State : ", style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.det["state"]),
                    ),
                    Text("Region : ", style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.det["region"]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}