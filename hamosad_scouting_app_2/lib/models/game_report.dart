import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '/models/summary.dart';
import 'cubit.dart';

typedef Json = Map<String, dynamic>;

class GameReport {
  final Cubit<String?> match = Cubit(null);
  final Cubit<String> scouter = Cubit('');
  final Cubit<String> scouterTeamNumber = Cubit('');
  final Cubit<String?> teamNumber = Cubit(null);

  final GameReportAuto auto = GameReportAuto();
  final GameReportEndgame endgame = GameReportEndgame();
  final GameReportSummary summary = GameReportSummary();
  final GameReportTeleop teleop = GameReportTeleop();

  Json get data {
    return {
      'info': {
        'scouter': scouter.data,
        'scouterTeamNumber': scouterTeamNumber.data,
        'teamNumber': teamNumber.data,
        'time': DateFormat('dd/MM HH:mm:ss').format(DateTime.now()),
        'match': match.data,
      },
      'auto': auto.data,
      'teleop': teleop.data,
      'endgame': endgame.data,
      'summary': summary.data,
    };
  }

  void clear() {
    auto.clear();
    teleop.clear();
    endgame.clear();
    summary.clear();
    teamNumber.data = null;
    match.data = null;
  }
}

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

class GameReportTeleop {
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

class GameReportEndgame {
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
    won.data = false;
    defenseFocus.data = null;
    fouls.data = '';
    notes.data = '';
    defenseNotes.data = '';
  }
}

final gameReportProvider = Provider((ref) => GameReport());
