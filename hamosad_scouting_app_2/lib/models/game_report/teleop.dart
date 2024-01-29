import '/models/cubit.dart';

class GameReportTeleop {
  final speakerScores = Cubit(0), speakerMisses = Cubit(0);
  final ampScores = Cubit(0), ampMisses = Cubit(0);
  final trapScores = Cubit(0), trapFromFloor = Cubit(false);
  final climb = Cubit(false), harmony = Cubit(false);

  /// This field is `null` if the human player is not from the scouted team.
  final micScores = Cubit<int?>(null);
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
      'trap': {
        'scores': trapScores.data,
        'fromFloor': trapFromFloor.data,
      },
      'climb': climb.data,
      'harmony': harmony.data,
      'micScores': micScores.data,
      'notes': notes.data,
    };
  }

  void clear() {
    speakerScores.data = 0;
    speakerMisses.data = 0;
    ampScores.data = 0;
    ampMisses.data = 0;
    trapScores.data = 0;
    trapFromFloor.data = false;
    climb.data = false;
    harmony.data = false;
    micScores.data = null;
    notes.data = '';
  }
}
