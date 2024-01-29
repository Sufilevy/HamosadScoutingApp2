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
  none,
  half,
  almostAll;

  @override
  String toString() {
    switch (this) {
      case DefenseFocus.none:
        return 'none';
      case DefenseFocus.half:
        return 'half';
      case DefenseFocus.almostAll:
        return 'almostAll';
    }
  }
}
