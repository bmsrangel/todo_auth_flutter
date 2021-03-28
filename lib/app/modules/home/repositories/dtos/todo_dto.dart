import 'dart:convert';

class TodoDto {
  String description;
  bool isCompleted;

  TodoDto({
    this.description,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory TodoDto.fromMap(Map<String, dynamic> map) {
    return TodoDto(
      description: map['description'],
      isCompleted: map['isCompleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoDto.fromJson(String source) =>
      TodoDto.fromMap(json.decode(source));
}
