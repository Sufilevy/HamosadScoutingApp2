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
  final isRematch = Cubit<bool>(false);

  final auto = GameReportAuto();
  final endgame = GameReportEndgame();
  final summary = GameReportSummary();
  final teleop = GameReportTeleop();

  Json get data {
    return {
      '0-info': {
        'scouter': scouter.data,
        'scouterTeamNumber': scouterTeamNumber.data,
        'teamNumber': teamNumber.data,
        'time': DateFormat('HH:mm:ss dd_MM_yy').format(DateTime.now()),
        'match': match.data,
      },
      '1-auto': auto.data,
      '2-teleop': teleop.data,
      '3-endgame': endgame.data,
      '4-summary': summary.data,
    };
  }

  void clear() {
    auto.clear();
    teleop.clear();
    endgame.clear();
    summary.clear();

    teamNumber.data = null;
    match.data = null;
    isRematch.data = false;
  }
}

final gameReportProvider = Provider((ref) => GameReport());
