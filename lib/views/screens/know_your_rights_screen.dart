import 'package:Beacon/controllers/helpers/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KnowYourRightsScreen extends StatefulWidget {
  @override
  KnowYourRightsScreenState createState() {
    return new KnowYourRightsScreenState();
  }
}

class KnowYourRightsScreenState extends State<KnowYourRightsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fleshColor,
        title: Text('Know Your Rights'),
      ),
      backgroundColor: fleshColor,
      body: SingleChildScrollView(
        child: Image.asset('assets/police_interactions.png'),
      )
    );
  }

}