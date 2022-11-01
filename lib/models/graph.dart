
import 'package:flutter/material.dart';

class Graph {
  const Graph({
    required this.points,
    required this.color
  });

  final List<List<double>> points;
  final Color color;
}