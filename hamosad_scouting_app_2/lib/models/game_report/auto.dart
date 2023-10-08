import '/models/cubit.dart';

class GameReportAuto {
  Cubit<String> notes = Cubit('');

  Json get data {
    return {
      'notes': notes.data,
    };
  }

  void clear() {
    notes.data = '';
  }
}
