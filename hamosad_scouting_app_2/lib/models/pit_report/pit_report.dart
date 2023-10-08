import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '/models/cubit.dart';

class PitReport {
  final scouter = Cubit('');
  final scouterTeamNumber = Cubit('');
  final teamNumber = Cubit<String?>(null);

  Json get data {
    return {
      'info': {
        'scouter': scouter.data,
        'scouterTeamNumber': scouterTeamNumber.data,
        'teamNumber': teamNumber.data,
        'time': DateFormat('dd/MM HH:mm:ss').format(DateTime.now()),
      },
    };
  }

  void clear() {
    teamNumber.data = null;
  }
}

final pitReportProvider = Provider((ref) => PitReport());
