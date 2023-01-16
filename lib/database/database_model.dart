import 'package:objectbox/objectbox.dart';

@Entity()
class DatabaseModel {
  int? id;
  String? title;
  String? content;
  String? comment;
  String? creator;
  int state;

  @Property(type: PropertyType.date)
  DateTime createAt;
  @Property(type: PropertyType.date)
  DateTime startsIn;
  @Property(type: PropertyType.date)
  DateTime expireIn;
  @Property(type: PropertyType.date)
  DateTime completedDate;

  DatabaseModel({
    this.id,
    this.title,
    this.creator,
    this.content,
    this.comment,
    required this.state,
    required this.createAt,
    required this.startsIn,
    required this.expireIn,
    required this.completedDate,
  });

  // factory DatabaseModel.fromDBJson(Map<String, dynamic> json) => DatabaseModel(
  //   id: json['id'],
  //   title: json['title'],
  //   creator: json['creator'],
  //   content: json['content'],
  //   comment: json['comment'],
  //   state: json['state'],
  //   createAt: DateTime.fromMillisecondsSinceEpoch(json['createAt']),
  //   startsIn: DateTime.fromMillisecondsSinceEpoch(json['startsIn']),
  //   expireIn: DateTime.fromMillisecondsSinceEpoch(json['expireIn']),
  //   completedDate:
  //   DateTime.fromMillisecondsSinceEpoch(json['completedDate']),
  // );
  //
  // Map<String, dynamic> toDBJson() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'creator': creator,
  //     'content': content,
  //     'comment': comment,
  //     'state': state,
  //     'createAt': createAt.millisecondsSinceEpoch,
  //     'startIn': startsIn.millisecondsSinceEpoch,
  //     'expireIn': expireIn.millisecondsSinceEpoch,
  //     'completedDate': completedDate.millisecondsSinceEpoch,
  //   };
  // }
}