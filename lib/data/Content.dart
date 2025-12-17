class Content{
  final int? id;
  final String? title;
  final String? body;
  bool showComment;

  Content({
    required this.id,
    required this.title,
    required this.body,
    this.showComment = false,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'],
      title: json['title'],
      body: json['content'],
    );
  }
}