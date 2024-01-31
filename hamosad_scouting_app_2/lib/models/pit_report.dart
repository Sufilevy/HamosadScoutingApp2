import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '/models/cubit.dart';

class PitReport {
  final teamNumber = Cubit<String?>(null);
  final scouter = Cubit('');
  final scouterTeamNumber = Cubit('');

  final data = Cubit('');

  Json toJson() {
    return {
      '0-info': {
        'teamNumber': teamNumber.data,
        'scouter': scouter.data,
        'scouterTeamNumber': scouterTeamNumber.data,
        'time': DateFormat('HH:mm:ss dd_MM_yy').format(DateTime.now()),
      },
      '1-report': data.data,
    };
  }

  void clear() {
    teamNumber.data = null;
    data.data = '';
  }
}

final pitReportProvider = Provider((ref) => PitReport());
