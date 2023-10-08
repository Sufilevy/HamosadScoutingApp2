import '/models/cubit.dart';

class GameReportSummary {
  final defenseFocus = Cubit<DefenseFocus?>(null);
  final defenseNotes = Cubit('');
  final fouls = Cubit('');
  final notes = Cubit('');
  final won = Cubit(false);

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
