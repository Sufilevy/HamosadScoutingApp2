import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_analytics_app/src/app.dart';

void main() async {
  runApp(ProviderScope(child: AnalyticsApp()));
}
