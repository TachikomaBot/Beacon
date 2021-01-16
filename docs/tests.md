# Tests

## Auth Tests **under test/auth_test**
1. The tests cover various states that Auth objects and its decendants can be in
2. Tests include initializing with setUrl, trying to get tokens when the reference file has been deleted, receiving negative/incomplete responses from http requests, and throwing the correct errors in these erroneous situations. The classes are also of course tested with what should be error-free inputs

## Contact Tests **under test/contact_test**
1. This test creating a Contact object
2. Adding Contact object to ContactManager class
3. Removing Contact from ContactManager
4. Updating a specific Contact in ContactManager
5. Testing for ContactManager's singleton implementation

## Sms Tests **under test/sms_test**
1. Test that no exceptions will occur upon using SmsSender and TwilioSender

## Transmit Tests **under test/sms_test**
1. Test for creating a Transmitable object
2. Test for adding a Transmitable to TransmitManager (where videos are queued to be saved)
3. Test for listening and receiveing data from TransmitManager stream
