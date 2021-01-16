import 'package:Beacon/controllers/helpers/contact.dart';
import 'package:Beacon/models/contact.dart';

class ContactManager {
  
  //Declare contacts List
  List<Contact> contacts = new List<Contact>();
  bool _test = false;

  //singleton
  static final ContactManager _singleton = new ContactManager._internal();

  factory ContactManager(){
    return _singleton;
  }

  ContactManager._internal();

  //getter and setter for test variable
  bool get test{
    return this._test;
  }

  setTest(bool test){
    this._test = test;
  }

  /*
    This gives all the contacts
  */
  List<Contact> fetchContacts(){
    return contacts;
  }

  /*
    This adds to contacts list. List must only have a maximum of 3.
  */
  addContact(Contact contact) {

    //max 3
    if (contacts.length <= 3) {
      contacts.add(contact);
      print("Added ${contact.firstName}");

      //update local file
      if(!test) writeContactToFile();
    
    } else {
      print("Contacts full");
    
    }
  }

  /*
    This removes a given contact from contacts list
  */
  deleteContact(Contact _contact) {
    Contact result = getContactInList(_contact);
    contacts.remove(result);

    //update local file
    if(!test) writeContactToFile();
  }

  /*
    This updates a given contact in the contacts list
  */
  updateContact(Contact oldContact, Contact newContact) {
    int index = contacts.indexOf(oldContact);
    contacts[index] = newContact;

    //update local file
    if(!test) writeContactToFile();
  }

  /*
    This returns a specific Contact and its details
  */
  Contact showContact(Contact _contact){
    return(getContactInList(_contact));
  }

  /*
    This retrieves a specific contact from contacts list via a query
  */
  Contact getContactInList(Contact _contact) {
    return contacts.firstWhere((contact) =>
      (contact.firstName == _contact.firstName)
      && (contact.lastName == _contact.lastName)
      && (contact.phoneNumber == _contact.phoneNumber)
      && (contact.email == _contact.email),
      orElse: () => null);
  }
}