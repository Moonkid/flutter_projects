import 'package:flutter/material.dart';
import 'package:lecture_3_cats/widgets/local_remote_image.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    @required String imageUrl,
    @required int index,
  })
      : _imageUrl = imageUrl,
        _index = index;

  final String _imageUrl;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cat',
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: Center(
        child: LocalOrRemoteHeroImage(index: _index, url: _imageUrl),
      ),
    );
  }
}
