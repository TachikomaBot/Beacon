import 'package:Beacon/controllers/helpers/hexcolor.dart';
import 'package:Beacon/models/contact.dart';
import 'package:Beacon/views/screens/contacts_screen/show.dart';
import 'package:flutter/material.dart';

/*
  This is a contact item which will be displayed in the 
  ContactIndex
*/
class ContactItem extends StatelessWidget{

  final Contact contact;
  ContactItem(this.contact);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      color: blueColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(15),
            leading: Icon(Icons.contact_mail, size: 50, color: Colors.white),
            title: Text(
              contact.firstName + '\t' + contact.lastName,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            subtitle: Text(
              contact.phoneNumber + '\n' + contact.email,
              style: TextStyle(color: Colors.white, fontSize: 15)
              ),
            isThreeLine: true,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ContactShow(contact)))
          ),
        ],
      ),
    );
  }
}