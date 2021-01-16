import 'package:Beacon/controllers/helpers/hexcolor.dart';
import 'package:Beacon/controllers/managers/contact_manager.dart';
import 'package:Beacon/models/contact.dart';
import 'package:Beacon/views/widgets/add_contact_btn.dart';
import 'package:Beacon/views/widgets/contact_item.dart';
import 'package:flutter/material.dart';

class ContactsIndex extends StatefulWidget{
  ContactsIndexState createState(){
    return new ContactsIndexState();
  }
}

class ContactsIndexState extends State<ContactsIndex>{
  List<Widget> items = [];
  
  @override
  void initState() {
    super.initState();
    List<Contact> contacts = ContactManager().contacts;
    if(contacts != null){
      contacts.forEach((contact) => items.add(ContactItem(contact)));

      if(contacts.length < 3) items.add(AddContactBtn());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fleshColor,
        title: Text('Contacts'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        width: double.maxFinite,
        child: Column(
          children: items,
        ),
      ),
      backgroundColor: fleshColor,
    );
  }
}