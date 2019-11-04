import 'package:flutter/material.dart';

class LocalOrRemoteHeroImage extends StatelessWidget {
  const LocalOrRemoteHeroImage({
    @required String url,
    @required int index,
  })  : _url = url,
        _index = index;

  final String _url;
  final int _index;

  @override
  Widget build(BuildContext context) {
    final bool isUrl = Uri.parse(_url).isAbsolute;
    final image = isUrl
        ? FadeInImage(
            placeholder: const AssetImage('resources/cat-placeholder.gif'),
            image: NetworkImage(_url),
            fit: BoxFit.cover)
        : Image.asset(_url, fit: BoxFit.cover);
    return Hero(tag: '$_index/$_url}', child: image);
  }
}
