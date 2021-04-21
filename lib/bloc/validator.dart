
import 'dart:async';




class Validators {

  final validarId = StreamTransformer<List, List>.fromHandlers(
    handleData: ( dispositivos, sink ) {

      final idDispositivo = dispositivos.where( (s) => s.chipId.length == 12 ).toList();
      sink.add(idDispositivo);
    }
  );

  



}
