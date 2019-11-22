//
// Created by Pavel Pozdniakov on 11/22/19.
// Copyright (c) 2019 SSA Group. All rights reserved.
//

import 'package:flutter/material.dart';

import '../../models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard(
    User user,
  ) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'avatar',
            child: Image.network(
              _user.image,
              fit: BoxFit.fill,
              height: 300,
              width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              _user.name,
              style: Theme.of(context).textTheme.display1,
            ),
          )
        ],
      ),
    );
  }
}
