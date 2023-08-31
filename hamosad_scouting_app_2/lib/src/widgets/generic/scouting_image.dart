import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

class ScoutingImage extends StatelessWidget {
  /// Only one of [path] or [url] must not be empty.
  ScoutingImage({
    Key? key,
    this.title = '',
    this.path = '',
    this.url = '',
    this.scale = 1.0,
    this.size = 1.0,
  })  : assert(path.isNotEmpty || url.isNotEmpty),
        assert(path.isEmpty || url.isEmpty),
        super(key: key);

  final double scale, size;
  final String path, url, title;

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0 * scale),
      child: path.isNotEmpty
          ? Image.asset(path, scale: scale)
          : Image.network(
              url,
              scale: scale,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0 * size),
      child: title.isNotEmpty
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
}
