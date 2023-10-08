import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '/models/cubit.dart';
import 'auto.dart';
import 'endgame.dart';
import 'summary.dart';
import 'teleop.dart';

class GameReport {
  final match = Cubit<String?>(null);
  final scouter = Cubit('');
  final scouterTeamNumber = Cubit('');
  final teamNumber = Cubit<String?>(null);

  final auto = GameReportAuto();
  final endgame = GameReportEndgame();
  final summary = GameReportSummary();
  final teleop = GameReportTeleop();

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
