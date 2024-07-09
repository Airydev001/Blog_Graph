class Blog {
  final String id;
  final String title;
  final String subTitle;
  final String body;
  final DateTime dateCreated;

  Blog({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.body,
    required this.dateCreated,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      subTitle: json['subTitle'],
      body: json['body'],
      dateCreated: DateTime.parse(json['dateCreated']),
    );
  }
}
