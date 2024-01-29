import '/models/cubit.dart';

class GameReportAuto {
  final speakerScores = Cubit(0), speakerMisses = Cubit(0);
  final ampScores = Cubit(0), ampMisses = Cubit(0);
  final middlePickups = Cubit(<int>[]);
  final notes = Cubit('');

  Json get data {
    return {
      'speaker': {
        'scores': speakerScores.data,
        'misses': speakerMisses.data,
      },
      'amp': {
        'scores': ampScores.data,
        'misses': ampMisses.data,
      },
      'middlePickups': middlePickups.data,
      'notes': notes.data,
    };
  }

  void clear() {
    speakerScores.data = 0;
    speakerMisses.data = 0;
    ampScores.data = 0;
    ampMisses.data = 0;
    middlePickups.data.clear();
    notes.data = '';
  }
}
