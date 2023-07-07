// ignore_for_file: public_member_api_docs, sort_constructors_first

class TagsModel {
  final String emoji;
  final String name;
  final String uid;

  TagsModel({
    required this.emoji,
    required this.name,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'emoji': emoji,
      'name': name,
      'uid': uid,
    };
  }

  factory TagsModel.fromMap(Map<String, dynamic> map) {
    return TagsModel(
      emoji: map['emoji'] as String,
      name: map['name'] as String,
      uid: map['uid'] as String,
    );
  }
}
