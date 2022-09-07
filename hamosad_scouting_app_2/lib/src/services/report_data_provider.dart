import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:provider/provider.dart';

class ReportDataProvider {
  final Cubit<String> reporterName = Cubit('');
  final Cubit<String> reporterTeamNumber = Cubit('');
  final Cubit<String> teamNumber = Cubit('');
  final Cubit<ReportType> reportType = Cubit(ReportType.game);

  final GameReport gameReport = GameReport();
  final PitReport pitReport = PitReport();

  Map<String, dynamic> get data {
    return {
      'reporterName': reporterName.data,
      'reporterTeamNumber': reporterTeamNumber.data,
      'teamNumber': teamNumber.data,
    };
  }
}

class GameReport {
  final Cubit<int> teleopHubMissed = Cubit(0);
}

class PitReport {
  final Cubit<int> canShootUpper = Cubit(0);
}

ReportDataProvider reportDataProvider(BuildContext context) =>
    Provider.of<ReportDataProvider>(context, listen: false);
