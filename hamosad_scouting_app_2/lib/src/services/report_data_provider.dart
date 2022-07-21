import 'package:flutter/cupertino.dart';
import 'package:hamosad_scouting_app_2/src/services/cubit.dart';
import 'package:provider/provider.dart';

class ReportDataProvider {
  final Cubit<String> reporterName = Cubit('');
  final Cubit<String> reporterTeamNumber = Cubit('');
  final Cubit<String> teamNumber = Cubit('');

  Map<String, dynamic> get data {
    return {
        'reporterName': reporterName.data,
        'reporterTeamNumber': reporterTeamNumber.data,
        'teamNumber': teamNumber.data,
    };
  }
}

ReportDataProvider reportDataProvider(BuildContext context) =>
    Provider.of<ReportDataProvider>(context, listen: false);
