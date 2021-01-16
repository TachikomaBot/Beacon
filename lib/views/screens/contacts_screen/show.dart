import 'package:Beacon/controllers/helpers/hexcolor.dart';
import 'package:Beacon/controllers/managers/contact_manager.dart';
import 'package:Beacon/models/contact.dart';
import 'package:Beacon/router.dart';
import 'package:Beacon/views/screens/contacts_screen/index.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ContactShow extends StatefulWidget{
  final Contact contact;

  ContactShow([this.contact]);

  @override
  ContactShowState createState() => ContactShowState();
  
}

class ContactShowState extends State<ContactShow>{
  final _formKey = GlobalKey<FormState>();

  //focus nodes used for directing user to the next field
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _occupationFocusNode = FocusNode();
  FocusNode _relationshipFocusNode = FocusNode();

  //where to save input data
  String _firstName, _lastName, _email, _phoneNumber, _occupation, _relationship = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: fleshColor,
          title: Text('Contact Info'),
        ),
        backgroundColor: fleshColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                //color: Colors.white70,
                padding: EdgeInsets.all(50),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.blueGrey,
                        size: 100.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),
                    ),
                    firstNameInput(context),
                    SizedBox(height: 18,),
                    lastNameInput(context),
                    SizedBox(height: 18,),
                    phoneNumberInput(context),
                    SizedBox(height: 18,),
                    emailInput(context),
                    SizedBox(height: 18,),
                    relationshipInput(context),
                    SizedBox(height: 18,),
                    occupationInput(context),
                    SizedBox(height: 18,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Visibility(
                          visible: widget.contact != null,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: deleteButton(),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: submitButton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  //input field widgets...
  Widget firstNameInput(BuildContext context) {
    return TextFormField(
      focusNode: _firstNameFocusNode,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      initialValue: (widget.contact != null) ? widget.contact.firstName : '',
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.contacts),
        border: OutlineInputBorder(),
        labelText: "First Name",
        hintText: (widget.contact != null) ? widget.contact.firstName : '',
        fillColor: Colors.white70,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      validator: (name) {
        Pattern pattern =
            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(name))
          return 'Invalid username';
        else
          return null;
      },
      onSaved: (name) => _firstName = name,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _firstNameFocusNode, _lastNameFocusNode);
      },
    );
  }

  Widget lastNameInput(BuildContext context) {
    return TextFormField(
      focusNode: _lastNameFocusNode,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      initialValue: (widget.contact != null) ? widget.contact.lastName : '',
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.contacts),
        border: OutlineInputBorder(),
        labelText: "Last Name",
        hintText: (widget.contact != null) ? widget.contact.lastName : '',
        fillColor: Colors.white70,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      validator: (name) {
        Pattern pattern =
            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(name))
          return 'Invalid username';
        else
          return null;
      },
      onSaved: (name) => _lastName = name,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _lastNameFocusNode, _phoneNumberFocusNode);
      },
    );
  }

  Widget phoneNumberInput(BuildContext context) {
    return TextFormField(
      focusNode: _phoneNumberFocusNode,
      keyboardType: TextInputType.phone,
      initialValue: (widget.contact != null) ? widget.contact.phoneNumber : '',
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.contact_phone),
        border: OutlineInputBorder(),
        labelText: "Phone Number",
        hintText: (widget.contact != null) ? widget.contact.phoneNumber : '',
        fillColor: Colors.white70,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      validator: (phoneNumber) =>
      validateMobile(phoneNumber)
          ? null
          : "Invalid phone number",
      onSaved: (phoneNumber) => _phoneNumber = phoneNumber,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _phoneNumberFocusNode, _emailFocusNode);
      },
    );
  }

  Widget emailInput(BuildContext context) {
    return TextFormField(
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      initialValue: (widget.contact != null) ? widget.contact.email : '',
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail_outline),
        border: OutlineInputBorder(),
        labelText: "Email Address",
        hintText: (widget.contact != null) ? widget.contact.email : '',
        fillColor: Colors.white70,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      validator: (email) =>
      EmailValidator.validate(email)
          ? null
          : "Invalid email address",
      onSaved: (email) => _email = email,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _emailFocusNode, _relationshipFocusNode);
      },
    );
  }

  Widget relationshipInput(BuildContext context) {
    return TextFormField(

      focusNode: _relationshipFocusNode,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      initialValue: (widget.contact != null) ? widget.contact.relationship : '',
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.contacts),
        border: OutlineInputBorder(),
        labelText: "Relationship",
        hintText: (widget.contact != null) ? widget.contact.relationship : '',
        fillColor: Colors.white70,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      validator: (name) {
        Pattern pattern =
            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(name))
          return 'Invalid username';
        else
          return null;
      },
      onSaved: (name) => _relationship = name,
      onFieldSubmitted: (_) {
        fieldFocusChange(context, _relationshipFocusNode, _occupationFocusNode);
      },
    );
  }

  Widget occupationInput(BuildContext context) {
    return TextFormField(
      focusNode: _occupationFocusNode,
      autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      initialValue: (widget.contact != null) ? widget.contact.occupation : '',
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.contacts),
        border: OutlineInputBorder(),
        labelText: "Occupation",
        hintText: (widget.contact != null) ? widget.contact.occupation : '',
        fillColor: Colors.white70,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      validator: (name) {
        Pattern pattern =
            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(name))
          return 'Invalid username';
        else
          return null;
      },
      onSaved: (name) => _occupation = name
    );
  }

  RaisedButton submitButton() {
    return RaisedButton(
      color: Colors.blueGrey,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          if(widget.contact != null){
            Contact updatedContact = Contact(_firstName, _lastName, _phoneNumber, _email, _relationship, _occupation);
            ContactManager().updateContact(widget.contact, updatedContact);
          } else{
            Contact newContact = Contact(_firstName, _lastName, _phoneNumber, _email, _relationship, _occupation);
            ContactManager().addContact(newContact);
          }
          //Navigator.push(context, MaterialPageRoute(builder: (context) => ContactsIndex())); //redirect
          //Navigator.pushReplacementNamed(context, contactsRoute);
          Navigator.pop(context);
        }
      },
      child: Text(
        "Submit",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  RaisedButton deleteButton() {
    return RaisedButton(
      color: Colors.blueGrey,
      onPressed: () {
        ContactManager().deleteContact(widget.contact);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ContactsIndex())); //redirect
        //Navigator.pushReplacementNamed(context, contactsRoute);
        Navigator.pop(context);
      },
      child: Text(
        "Delete Contact",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      print('Please enter mobile number');
      return false;
    }
    else if (!regExp.hasMatch(value)) {
      print('Please enter valid mobile number');
      return false;
    }
    return true;
  }

  fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}