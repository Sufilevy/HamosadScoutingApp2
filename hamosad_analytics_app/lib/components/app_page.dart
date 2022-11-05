import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/components.dart';

class AppPage extends StatefulWidget {
  const AppPage({required this.appBar, required this.body, super.key});

  final AppBar appBar;
  final Widget body;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      drawer: NavDrawer(
        onChange: (Widget page) {
          setState(
            () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => page));
            },
          );
        },
      ),
      appBar: widget.appBar,
      body: widget.body,
    );
  }
}
