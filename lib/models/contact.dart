/*
  This is a contact of which user will have a maximum of three.
*/
class Contact{

  //no need to be private since we need to reference to its values outside the class
  String firstName, lastName, phoneNumber, email, occupation, relationship;

  /*
    This is the constructor
    dev note: when creating/editing a contact you are basically creating/recreating a Contact
  */
  Contact([String firstName, String lastName, String phoneNumber, String email, String occupation, String relationship]){
    this.firstName = firstName;
    this.lastName = lastName;
    this.phoneNumber = phoneNumber;
    this.email = email;
    this.occupation = occupation;
    this.relationship = relationship;
  }
}