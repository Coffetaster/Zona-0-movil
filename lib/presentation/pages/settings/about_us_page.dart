import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                Expanded(child: Container(color: Colors.blue, width: double.infinity,)),
                Container(color: Colors.red, width: double.infinity, height: 100,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
