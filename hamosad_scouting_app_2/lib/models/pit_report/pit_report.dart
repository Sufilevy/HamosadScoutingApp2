import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '/models/cubit.dart';

class PitReport {
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
      },
    };
  }

  void clear() {
    teamNumber.data = null;
  }
}

final pitReportProvider = Provider((ref) => PitReport());
