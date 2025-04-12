class PostDto {
  int userId;
  int id;
  String title;
  String body;

  PostDto({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
}