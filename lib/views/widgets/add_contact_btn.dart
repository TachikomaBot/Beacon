import 'package:Beacon/controllers/helpers/hexcolor.dart';
import 'package:Beacon/router.dart';
import 'package:flutter/material.dart';

class AddContactBtn extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        padding: EdgeInsets.all(15.0),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5),
        ),
        onPressed: () => Navigator.pushReplacementNamed(context, contactEditRoute),
        color: blueColor,
        child: Icon(Icons.add, size: 45.0, color: Colors.white),
      ),
    );
  }
}