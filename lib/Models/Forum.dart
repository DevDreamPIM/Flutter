import 'package:flutter/foundation.dart';

class Forum {
  final String? description;
  final List<Comment>? comments;
  final String? firstName;
  final String? lastName;

  Forum({
    this.description,
    this.comments,
    this.firstName,
    this.lastName,
  });
}

class Comment {
  final String? text;

  Comment({this.text});
}
