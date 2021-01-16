/*==========================================================================================
  This prints a message if given code encounters error. This is used in video implementation
============================================================================================*/
void logError(String code, String message) => print('Error: $code\nError Message: $message');

/*======================================================================================
  The following will be used to display error messages for oAuth related functionalities
=======================================================================================*/
class FileDNEError extends Error{
  FileDNEError();

  toString(){
    return "File does not exist!";
  }
}

class BadResponseError extends Error{
  BadResponseError();

  toString(){
    return "Request was denied!";
  }
}

class NoResponseError extends Error{
  NoResponseError();

  toString(){
    return "No response was received!";
  }
}

class WrongAuthTypeError extends Error{
  WrongAuthTypeError();

  toString(){
    return "File has wrong authType!";
  }
}