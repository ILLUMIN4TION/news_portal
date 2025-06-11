// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewsData {
  final String title;
  final String? imgUri;
  final String description;
  final String pubDate;
  NewsData({
    required this.title,
    this.imgUri,
    required this.description,
    required this.pubDate,
  });

  NewsData copyWith({
    String? title,
    String? imgUri,
    String? description,
    String? pubDate,
  }) {
    return NewsData(
      title: title ?? this.title,
      imgUri: imgUri ?? this.imgUri,
      description: description ?? this.description,
      pubDate: pubDate ?? this.pubDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'img_url': imgUri,
      'description': description,
      'pub_date': pubDate,
    };
  }

  factory NewsData.fromMap(Map<String, dynamic> map) {
    return NewsData(
      title: map['title'],
      imgUri: map['image_url'],
      description: map['description'],
      pubDate: map['pub_date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsData.fromJson(String source) =>
      NewsData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsData(title: $title, imgUri: $imgUri, description: $description, pubDate: $pubDate)';
  }

  @override
  bool operator ==(covariant NewsData other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.imgUri == imgUri &&
        other.description == description &&
        other.pubDate == pubDate;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        imgUri.hashCode ^
        description.hashCode ^
        pubDate.hashCode;
  }
}
