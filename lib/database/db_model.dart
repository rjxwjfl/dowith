class DBModel {
  final int? id;
  final String? title;
  final String? content;
  final String? comment;
  final String? creator;
  final TodoState state;
  final int createAt;
  final DateTime startsIn;
  final DateTime expireIn;
  final DateTime completedDate;

  DBModel({
    this.id,
    this.title,
    this.creator,
    this.content,
    this.comment,
    required this.state,
    createAt,
    required this.startsIn,
    required this.expireIn,
    required this.completedDate,
  }) : createAt = DateTime.now().millisecondsSinceEpoch;

  factory DBModel.fromDBJson(Map<String, dynamic> json) => DBModel(
        id: json['id'],
        title: json['title'],
        creator: json['creator'],
        content: json['content'],
        comment: json['comment'],
        state: getTodoStateByValue(json['state'] as int),
        createAt: json['createAt'],
        startsIn: DateTime.fromMillisecondsSinceEpoch(json['startsIn']),
        expireIn: DateTime.fromMillisecondsSinceEpoch(json['expireIn']),
        completedDate:
            DateTime.fromMillisecondsSinceEpoch(json['completedDate']),
      );

  Map<String, dynamic> toDBJson() {
    return {
      'id': id,
      'title': title,
      'creator': creator,
      'content': content,
      'comment': comment,
      'state': getTodoStateValue(state),
      'createAt': createAt,
      'startIn': startsIn.millisecondsSinceEpoch,
      'expireIn': expireIn.millisecondsSinceEpoch,
      'completedDate': completedDate.millisecondsSinceEpoch,
    };
  }
}

enum TodoState { todo, inProgress, done, expired }

int getTodoStateValue(TodoState state) {
  switch (state) {
    case TodoState.todo:
      return 0;
    case TodoState.inProgress:
      return 1;
    case TodoState.done:
      return 2;
    case TodoState.expired:
      return 3;
    default:
      return 0;
  }
}

TodoState getTodoStateByValue(int stateValue) {
  switch (stateValue) {
    case 0:
      return TodoState.todo;
    case 1:
      return TodoState.inProgress;
    case 2:
      return TodoState.done;
    case 3:
      return TodoState.expired;
    default:
      return TodoState.todo;
  }
}
