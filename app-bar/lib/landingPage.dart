import 'package:flutter/material.dart';

class landingPage extends StatefulWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),

      //for rounded appbar uncomment it like
      //AppBar(
      // title: Text("Hello"),
      // elevation: 0.0,
      // backgroundColor: Colors.green,
      // ),
      // body: ClipPath(
      //   clipper: CustomShape(),
      //   child: Container(
      //     height: 150,
      //     color: Colors.green,
      //     //your remaining code here
      //   ),
      // ),
    );
  }


  //create a custom widget for appbar
  AppBar customAppBar() {
    String _text = "Hello new custom";
    Color _color = Colors.green;
    double _ele = 10.0;
    return AppBar(
      title: Text(_text),
      backgroundColor: _color,
      centerTitle: true,
      elevation: _ele,
      shadowColor: Colors.brown,


      //for changing color of appbar in gradient
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [Colors.blue, Colors.orange]
          ),
        ),
      ),

      //for left side icons
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.message),
      ),

      //for right side icons
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.admin_panel_settings_outlined),
        ),
      ],

      //shape of appbar
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
      ),
    );
  }
}
// class CustomShape extends CustomClipper<Path> {
//   @override
//   getClip(Size size) {
//     double height = size.height;
//     double width = size.width;
//     var path = Path();
//     path.lineTo(0, height - 50);
//     path.quadraticBezierTo(width / 2, height, width, height - 50);
//     path.lineTo(width, 0);
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper oldClipper) {
//     return true;
//   }
// }
//
