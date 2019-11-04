import 'package:flutter/material.dart';
import 'package:lecture_3_cats/pages/details_page.dart';
import 'package:lecture_3_cats/widgets/local_remote_image.dart';
import 'package:meta/meta.dart';

class CatItem extends StatelessWidget {
  const CatItem({
    @required String imageUrl,
    @required int index,
  })  : _imageUrl = imageUrl,
        _index = index;

  final String _imageUrl;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Card(
            child: LocalOrRemoteHeroImage(index: _index, url: _imageUrl),
          ),
        ),
        Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _onTap(context: context),
            ))
      ],
    );
  }

  void _onTap({BuildContext context}) {
    Navigator.push<void>(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DetailsPage(index: _index, imageUrl: _imageUrl)));
  }
}
