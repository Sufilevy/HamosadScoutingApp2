import '/models/report/report_model.dart';

class Chart {
  const Chart({required this.title, required this.dataFromReport});

  final String title;
  final double Function(Report) dataFromReport;

  static final allCharts = <Chart>[
    Chart(title: 'Total Score', dataFromReport: (report) => Report.randomData(70)),
    Chart(title: 'Auto Dropoffs', dataFromReport: (report) => Report.randomData(6)),
    Chart(title: 'Teleop Dropoffs', dataFromReport: (report) => Report.randomData(15)),
  ];
}
