class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      // Handle potential null values with default fallback
      userId: json['userId'] ?? "No User ID",
      id: json['id'] ?? "No ID",
      title: json['title'] ?? "",
      body: json['body'] ?? "No Body",
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }
}

// Best Approach and best Model For Posts API
