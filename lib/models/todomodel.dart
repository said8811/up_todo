class TodoFields {
  static String id = "id";
  static String title = "title";
  static String description = "description";
  static String date = "date";
  static String categoryid = "categoryid";
  static String priority = "priority";
  static String isCompleted = "isCompleted";
}

class TodoModel {
  final int? id;
  final String title;
  final String description;
  final String date;
  final int categoryid;
  final String priority;
  final int isCompleted;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.categoryid,
    required this.priority,
    required this.isCompleted,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      categoryid: json['categoryid'] ?? 0,
      priority: json['priority'] ?? '',
      isCompleted: json['isCompleted'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'categoryid': categoryid,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
    int? categoryid,
    String? priority,
    int? isCompleted,
  }) =>
      TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        categoryid: categoryid ?? this.categoryid,
        priority: priority ?? this.priority,
        isCompleted: isCompleted ?? this.isCompleted,
      );
}
