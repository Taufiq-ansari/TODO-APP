class TodoModel {
  String? title;
  String? description;

  TodoModel({
    required this.title,
    required this.description,
  });

  // from json

  factory TodoModel.fromJson(Map<String, String> json) {
    return TodoModel(
      title: json["title"],
      description: json["description"],
    );
  }

  // tomap

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
    };
  }
}
