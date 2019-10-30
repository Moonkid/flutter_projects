import 'package:flutter/material.dart';
import 'package:lecture_3_cats/widgets/local_remote_image.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    @required String imageUrl,
  }) : _imageUrl = imageUrl;

  final String _imageUrl;

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
        child: LocalOrRemoteHeroImage(url: _imageUrl),
      ),
    );
  }
}
