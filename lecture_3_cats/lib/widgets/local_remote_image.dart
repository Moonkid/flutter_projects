import 'package:flutter/material.dart';

class LocalOrRemoteHeroImage extends StatelessWidget {
  const LocalOrRemoteHeroImage({
    @required String url,
  }) : _path = url;

  final String _path;

  @override
  Widget build(BuildContext context) {
    final bool isUrl = Uri.parse(_path).isAbsolute;
    final image = isUrl
        ? FadeInImage(
            placeholder: const AssetImage('resources/cat-placeholder.gif'),
            image: NetworkImage(_path),
            fit: BoxFit.cover)
        : Image.asset(_path, fit: BoxFit.cover);
    return Hero(tag: _path, child: image);
  }
}
