import '/models/cubit.dart';

class GameReportSummary {
  Cubit<DefenseFocus?> defenseFocus = Cubit(null);
  Cubit<String> defenseNotes = Cubit('');
  Cubit<String> fouls = Cubit('');
  Cubit<String> notes = Cubit('');
  Cubit<bool> won = Cubit(false);

  Json get data {
    return {
      'won': won.data,
      'defenseRobotIndex': defenseFocus.data.toString(),
      'fouls': fouls.data,
      'notes': notes.data,
      'defenseNotes': defenseNotes.data,
    };
  }

  void clear() {
    defenseFocus.data = null;
    defenseNotes.data = '';
    fouls.data = '';
    notes.data = '';
    won.data = false;
  }
}

enum DefenseFocus {
  almostAll,
  half,
  none;

  @override
  String toString() {
    switch (this) {
      case DefenseFocus.almostAll:
        return 'almostAll';
      case DefenseFocus.half:
        return 'half';
      case DefenseFocus.none:
        return 'none';
    }
  }
}
