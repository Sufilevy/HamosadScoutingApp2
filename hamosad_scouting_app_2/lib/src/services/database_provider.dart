import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DatabaseProvider {
  DatabaseProvider();

  void sendReport(Map<String, dynamic> data) {
    print(data);
  }
}

DatabaseProvider databaseProvider(BuildContext context) =>
    Provider.of<DatabaseProvider>(context);
