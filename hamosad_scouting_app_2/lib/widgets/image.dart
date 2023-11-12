import 'package:flutter/material.dart';

import '/widgets/paddings.dart';
import '/widgets/text.dart';

class ScoutingImage extends StatelessWidget {
  /// Only one of [path] or [url] must not be empty.
  ScoutingImage({
    super.key,
    this.title = '',
    this.path = '',
    this.url = '',
    this.scale = 1,
    this.size = 1,
  })  : assert(path.isNotEmpty || url.isNotEmpty),
        assert(path.isEmpty || url.isEmpty);

  final double scale, size;
  final String path, url, title;

  @override
  Widget build(BuildContext context) {
    return padAll(
      12,
      title.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScoutingText.subtitle(title),
                _buildImage(),
              ],
            )
          : _buildImage(),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5 * scale),
      child: path.isNotEmpty
          ? Image.asset(path, scale: scale)
          : Image.network(
              url,
              scale: scale,
            ),
    );
  }
}
