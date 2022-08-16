import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';


void main() async {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
@override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
 
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme,
      ),
      ),
      home: SplashScreenPage(),
     
    );
  }

}
class SplashScreenPage extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    
    return Center(
      child: SplashScreen(  
        seconds: 4,  
        navigateAfterSeconds: new MyPage(),  
        backgroundColor: Colors.white,   
        image: new Image.asset(  
            'assets/logo_gif.gif',gaplessPlayback: true, 
        ),  
        loadingText: Text("Loading"),  
        photoSize: 200.0,  
        loaderColor: Colors.black,  
      ),
    );  
  }  
}  
