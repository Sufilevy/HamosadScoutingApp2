import 'package:flutter/material.dart';

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

  Widget get _image => path.isNotEmpty ? Image.asset(path) : Image.network(url);

  @override
  Widget build(BuildContext context) {
    if (title.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          _image,
        ],
      );
    } else {
      return _image;
    }
  }
}
