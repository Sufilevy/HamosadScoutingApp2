import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/models.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportDataProvider {
  final GameReport gameReport = GameReport();
  final Cubit<String?> match = Cubit(null);
  final Cubit<String> scouter = Cubit('');
  final Cubit<String> scouterTeamNumber = Cubit('');
  final Cubit<String?> teamNumber = Cubit(null);

  Json get data {
    return {
      'info': {
        'scouter': scouter.data,
        'scouterTeamNumber': scouterTeamNumber.data,
        'teamNumber': teamNumber.data,
        'time': DateFormat('dd/MM HH:mm:ss').format(DateTime.now()),
        'match': match.data,
      },
      ...gameReport.data,
    };
  }

  void clear() {
    teamNumber.data = null;
    match.data = null;
    gameReport.clear();
  }
}

class GameReport {
  final GameReportAuto auto = GameReportAuto();
  final GameReportEndgame endgame = GameReportEndgame();
  final GameReportSummary summary = GameReportSummary();
  final GameReportTeleop teleop = GameReportTeleop();

  Json get data {
    return {
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

ReportDataProvider reportDataProvider(BuildContext context) =>
    context.read<ReportDataProvider>();
