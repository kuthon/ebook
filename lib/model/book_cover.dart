import 'dart:convert';

import 'package:flutter/material.dart';

class BookCover {
  late String title;
  late String description;
  late String path;
  late String author;
  late Image coverImage;
  late String coverImageBytes;
  late DateTime lastOpenTime;
  late int lastReadPosition;
  late int lastReadChapter;
  late bool isFavorites;

  BookCover({
    required this.description,
    required this.path,
    required this.title,
    required this.coverImage,
    required this.coverImageBytes,
    required this.lastOpenTime,
    required this.author,
    this.isFavorites = false,
    this.lastReadChapter = 0,
    this.lastReadPosition = 0,
  }) {
    description = description.replaceAll(RegExp(r'(<([^>]+)>)'), "");
  }

  String toJSON() {
    return '''
    {
      "title": ${jsonEncode(title)},
      "description": ${jsonEncode(description)},
      "path": "$path",
      "author": "$author",
      "cover_image_bytes": "$coverImageBytes",
      "last_open_time": "${lastOpenTime.toString()}",
      "last_read_position": $lastReadPosition,
      "last_read_chapter": $lastReadChapter,
      "is_favorites": $isFavorites
    }
    ''';
  }

  BookCover.fromJSON(var data) {
    title = data['title'] as String;
    description = (data['description'] as String).replaceAll(RegExp(r'(<([^>]+)>)'), "");
    path = data['path'] as String;
    author = data['author'] as String;
    coverImage = Image.memory(base64Decode('${data['cover_image_bytes']}'));
    coverImageBytes = data['cover_image_bytes'] as String;
    lastOpenTime = DateTime.parse(data['last_open_time']);
    lastReadPosition = data['last_read_position'] as int;
    lastReadChapter = data['last_read_chapter'] as int;
    isFavorites = data['is_favorites'] as bool;
  }
}
