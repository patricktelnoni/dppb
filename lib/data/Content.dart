class Content{
  final String? title;
  final String? body;

  const Content({
    required this.title,
    required this.body,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      title: json['title'],
      body: json['content'],
    );
  }
}