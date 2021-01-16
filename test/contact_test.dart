import 'package:Beacon/controllers/managers/contact_manager.dart';
import 'package:Beacon/models/contact.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  test("Test creating a contact ", (){
    
    String firstName = "John";
    String lastName = "Doe";
    String phoneNumber = "0123456789";
    String email = "john@email.com";
    String relationship = "Godfather";
    String occupation = "Doctor";
    
    Contact contact = Contact(firstName, lastName, phoneNumber, email, occupation, relationship);

    expect(contact.firstName, firstName);
    expect(contact.lastName, lastName);
    expect(contact.phoneNumber, phoneNumber);
    expect(contact.email, email);
    expect(contact.relationship, relationship);
    expect(contact.occupation, occupation);
  });

  test("Test adding a contact to ContactManager", (){
    String firstName = "Jennie";
    Contact contact = Contact();
    contact.firstName = firstName;

    ContactManager manager = ContactManager();
    manager.setTest(true); //disable file saving no applicable for this test
    
    manager.addContact(contact);

    expect(manager.fetchContacts().length, 1);
    expect(manager.fetchContacts()[0].firstName, firstName);
  });

  test("Test removing a contact from ContactManager", (){

    //create contact
    String firstName = "Lisa";
    Contact contact = Contact();
    contact.firstName = firstName;

    //config ContactManager
    ContactManager manager = ContactManager();
    manager.setTest(true); //disable file saving no applicable for this test
    
    //add contact
    manager.addContact(contact);
    
    //check if added
    expect(manager.fetchContacts().length, 2);
    expect(manager.fetchContacts()[1].firstName, firstName);

    //delete
    manager.deleteContact(contact);
    expect(manager.fetchContacts().length, 1);
  });

  test("Test updating a contact in ContactManager", (){

    //create contact
    String firstName1 = "Rose";
    Contact oldContact = Contact();
    oldContact.firstName = firstName1;

    //config ContactManager
    ContactManager manager = ContactManager();
    manager.setTest(true); //disable file saving no applicable for this test
  
    //add contact
    manager.addContact(oldContact);

    //expect added
    expect(manager.fetchContacts()[1].firstName, firstName1);

    //create new contact
    String firstName2 = "Jisoo";
    Contact newContact = Contact();
    newContact.firstName = firstName2;

    //update old contact with new contact
    manager.updateContact(oldContact, newContact);
    expect(manager.fetchContacts()[1].firstName, firstName2);
  });

  test("Test global access of ContactManager via singleton", (){
    ContactManager manager = new ContactManager();
    Contact contact = Contact();
    contact.firstName = "Jennie";
    
    //added data from previous test is still there
    expect(manager.getContactInList(contact).firstName, contact.firstName);
  });
}