import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/models.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportDataProvider {
  final Cubit<String> scouter = Cubit('');
  final Cubit<String> scouterTeamNumber = Cubit('');
  final Cubit<String?> teamNumber = Cubit(null);
  final Cubit<String?> match = Cubit(null);

  final GameReport gameReport = GameReport();

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
  final GameReportTeleop teleop = GameReportTeleop();
  final GameReportEndgame endgame = GameReportEndgame();
  final GameReportSummary summary = GameReportSummary();

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
  Cubit<bool> leftCommunity = Cubit(false);
  Cubit<Pickups> pickups = Cubit(Pickups());
  Cubit<Dropoffs> dropoffs = Cubit(Dropoffs());
  Cubit<int> chargeStationPasses = Cubit(0);
  Cubit<Climb> climb = Cubit(Climb());
  Cubit<String> notes = Cubit('');

  Json get data {
    return {
      'leftCommunity': leftCommunity.data,
      'pickups': pickups.data.toJson(),
      'dropoffs': dropoffs.data.toJson(),
      'chargeStationPasses': chargeStationPasses.data,
      'climb': climb.data.toJson(includeDuration: false),
      'notes': notes.data,
    };
  }

  void clear() {
    leftCommunity.data = false;
    pickups.data = Pickups();
    dropoffs.data = Dropoffs();
    chargeStationPasses.data = 0;
    climb.data = Climb();
    notes.data = '';
  }
}

class GameReportTeleop {
  Cubit<Pickups> pickups = Cubit(Pickups());
  Cubit<Dropoffs> dropoffs = Cubit(Dropoffs());
  Cubit<int> chargeStationPasses = Cubit(0);
  Cubit<String> notes = Cubit('');

  Json get data {
    return {
      'pickups': pickups.data.toJson(),
      'dropoffs': dropoffs.data.toJson(),
      'chargeStationPasses': chargeStationPasses.data,
      'notes': notes.data,
    };
  }

  void clear() {
    pickups.data = Pickups();
    dropoffs.data = Dropoffs();
    chargeStationPasses.data = 0;
    notes.data = '';
  }
}

class GameReportEndgame {
  Cubit<Pickups> pickups = Cubit(Pickups());
  Cubit<Dropoffs> dropoffs = Cubit(Dropoffs());
  Cubit<int> chargeStationPasses = Cubit(0);
  Cubit<Climb> climb = Cubit(Climb());
  Cubit<String> notes = Cubit('');

  Json get data {
    return {
      'pickups': pickups.data.toJson(),
      'dropoffs': dropoffs.data.toJson(),
      'chargeStationPasses': chargeStationPasses.data,
      'climb': climb.data.toJson(),
      'notes': notes.data,
    };
  }

  void clear() {
    pickups.data = Pickups();
    dropoffs.data = Dropoffs();
    chargeStationPasses.data = 0;
    climb.data = Climb();
    notes.data = '';
  }
}

class GameReportSummary {
  Cubit<bool> won = Cubit(false);
  Cubit<DefenceFocus?> defenceFocus = Cubit(null);
  Cubit<String> fouls = Cubit('');
  Cubit<String> notes = Cubit('');
  Cubit<String> defenceNotes = Cubit('');

  Json get data {
    return {
      'won': won.data,
      'defenceRobotIndex': defenceFocus.data.toString(),
      'fouls': fouls.data,
      'notes': notes.data,
      'defenceNotes': defenceNotes.data,
    };
  }

  void clear() {
    won.data = false;
    defenceFocus.data = null;
    fouls.data = '';
    notes.data = '';
    defenceNotes.data = '';
  }
}

ReportDataProvider reportDataProvider(BuildContext context) =>
    context.read<ReportDataProvider>();
