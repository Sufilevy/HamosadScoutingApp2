import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '/models/cubit.dart';
import 'auto.dart';
import 'summary.dart';
import 'teleop.dart';

class GameReport {
  final match = Cubit<String?>(null);
  final teamNumber = Cubit<String?>(null);
  final scouter = Cubit('');
  final scouterTeamNumber = Cubit('');
  final isRematch = Cubit<bool>(false);

  final auto = GameReportAuto();
  final teleop = GameReportTeleop();
  final summary = GameReportSummary();

  Json toJson() {
    return {
      '0-info': {
        'match': match.data,
        'teamNumber': teamNumber.data,
        'scouter': scouter.data,
        'scouterTeamNumber': scouterTeamNumber.data,
        'time': DateFormat('HH:mm:ss dd_MM_yy').format(DateTime.now()),
      },
      '1-auto': auto.data,
      '2-teleop': teleop.data,
      '3-summary': summary.data,
    };
  }

  void clear() {
    match.data = null;
    teamNumber.data = null;
    isRematch.data = false;

    auto.clear();
    teleop.clear();
    summary.clear();
  }
}

final gameReportProvider = Provider((ref) => GameReport());
