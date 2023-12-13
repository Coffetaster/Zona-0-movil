import 'package:flutter/material.dart';

class Vickypage extends StatelessWidget {
  const Vickypage({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hola Vicky"),
      ),

      body: SingleChildScrollView(
      physics: PageScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.red,
            height: size.height * 0.8,
            width: double.infinity,
          ),
          Container(
            color: Colors.blue,
            height: size.height * 0.8,
            width: double.infinity,
          ),
          Container(
            color: Colors.green,
            height: size.height * 0.8,
            width: double.infinity,
          ),
        ],
      ),
      ),

      floatingActionButton:
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add)
          ),
    );
  }
}
