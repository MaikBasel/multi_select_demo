import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Item {
  final int id;
  final String title;
  final String subTitle;
  final Color backgroundColor;

  Item({
    @required this.id,
    @required this.title,
    @required this.subTitle,
    @required this.backgroundColor,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return new Item(
      id: map['id'] as int,
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      backgroundColor: map['backgroundColor'] as Color,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'title': this.title,
      'subTitle': this.subTitle,
      'backgroundColor': this.backgroundColor,
    } as Map<String, dynamic>;
  }

  @override
  String toString() {
    return 'Item{id: $id, title: $title, subTitle: $subTitle, backgroundColor: $backgroundColor}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          subTitle == other.subTitle &&
          backgroundColor == other.backgroundColor;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      subTitle.hashCode ^
      backgroundColor.hashCode;
}
