import '/models/cubit.dart';

class GameReportEndgame {
  final notes = Cubit('');

  Json get data {
    return {
      'notes': notes.data,
    };
  }

  void clear() {
    notes.data = '';
  }
}
