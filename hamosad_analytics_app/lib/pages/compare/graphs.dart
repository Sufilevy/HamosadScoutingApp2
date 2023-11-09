import '/models/report/report_model.dart';

class Graph {
  const Graph({required this.title, required this.dataFromReport});

  final String title;
  final double Function(Report) dataFromReport;

  static final allGraphs = <Graph>[
    Graph(title: 'Total Score', dataFromReport: (report) => Report.randomData(70)),
    Graph(title: 'Auto Dropoffs', dataFromReport: (report) => Report.randomData(6)),
    Graph(title: 'Teleop Dropoffs', dataFromReport: (report) => Report.randomData(15)),
  ];
}
