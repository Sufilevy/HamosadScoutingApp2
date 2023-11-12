import '/models/report/report_model.dart';

typedef DataFromReport = double Function(Report report);

class Chart {
  const Chart({required this.title, required this.dataFromReport});

  final String title;
  final DataFromReport dataFromReport;
}

abstract class Charts {
  static final _charts = <Chart>[
    Chart(title: 'Total Score', dataFromReport: (report) => report.data()),
    Chart(title: 'Auto Dropoffs', dataFromReport: (report) => report.data()),
    Chart(title: 'Teleop Dropoffs', dataFromReport: (report) => report.data()),
  ];

  static int length = _charts.length;

  static Chart index(int index) => _charts[index];
}
