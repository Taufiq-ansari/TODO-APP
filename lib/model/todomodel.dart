import 'dart:ui';

class TodoModel {
  final int? id;
 final String title;
 final  String description;
  late final  int?  colorValue;



  TodoModel({ this.id,
    required this.title,
    required this.description,
    required  this.colorValue,

  });


  // from json
  factory TodoModel.fromJson(Map<String, String> json) {
    return TodoModel(
      id : json["id"] as  int,
      title: json["title"] as String,
      description: json["description"] as String,
      colorValue:json['colorValue'] as  int ,
    );
  }

  // tomap
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "colorValue":colorValue,
    };
  }
  /// get color
Color get color => Color(colorValue!);

  // set color
set setColor(Color newColor){
  colorValue =Color(newColor as int) as int;
}

}
