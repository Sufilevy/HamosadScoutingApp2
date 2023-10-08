import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '/models/cubit.dart';
import 'auto.dart';
import 'endgame.dart';
import 'summary.dart';
import 'teleop.dart';

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

final gameReportProvider = Provider((ref) => GameReport());
