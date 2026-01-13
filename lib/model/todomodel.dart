class TodoModel {
  final int? id;
  String? title;
  String? description;

  TodoModel({ this.id,
    required this.title,
    required this.description,
  });

  // from json

  factory TodoModel.fromJson(Map<String, String> json) {
    return TodoModel(
      id : json["id"] as  int,
      title: json["title"],
      description: json["description"],
    );
  }

  // tomap

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }
}
