import 'package:flutter/material.dart';
import 'package:xcontext/material.dart';

class ScoutingImage extends StatelessWidget {
  final String path, url, title;

  ScoutingImage({
    Key? key,
    this.title = '',
    this.path = '',
    this.url = '',
  })  : assert(path.isNotEmpty || url.isNotEmpty),
        assert(path.isEmpty || url.isEmpty),
        super(key: key);

  Widget _image() => path.isNotEmpty ? Image.asset(path) : Image.network(url);

  @override
  Widget build(BuildContext context) {
    if (title.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: context.theme.textTheme.labelMedium,
          ),
          _image(),
        ],
      );
    } else {
      return _image();
    }
  }
}
