import 'package:Beacon/controllers/managers/transmit_manager.dart';
import 'package:Beacon/models/transmitable.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  test("Test creating a transmitable", (){
    Transmitable transmitable = Transmitable();
    
    //some values are already defined
    // expect(transmitable.arrived, DateTime.now());
    expect(transmitable.transmitted, false);
    expect(transmitable.initialized, false);
  });

  test("Test adding a transmitable into TransmitManager", (){
    TransmitManager transmitManager = TransmitManager();
    Transmitable transmitable = Transmitable();

    //add
    transmitManager.add(transmitable);

    //listen
    transmitManager.stream.listen((data) {
      expect(data.transmitted, false);
      expect(data.initialized, false);
    });
  });
}