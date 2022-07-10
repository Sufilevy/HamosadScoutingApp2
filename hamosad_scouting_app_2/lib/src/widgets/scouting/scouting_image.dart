import 'package:flutter/material.dart';
import 'package:xcontext/material.dart';

class ScoutingImage extends StatelessWidget {
  final String path, url, title;
  final double scale;

  /// Only one of [path] or [url] must not be empty.
  ScoutingImage({
    Key? key,
    this.title = '',
    this.path = '',
    this.url = '',
    this.scale = 1.0,
  })  : assert(path.isNotEmpty || url.isNotEmpty),
        assert(path.isEmpty || url.isEmpty),
        super(key: key);

  Widget _image() => path.isNotEmpty
      ? Image.asset(path, scale: scale)
      : Image.network(url, scale: scale);

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
