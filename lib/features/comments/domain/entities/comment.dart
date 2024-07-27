class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  @override
  String toString() {
    return 'Comment(postId: $postId, id: $id, name: $name, email: $email, body: $body)';
  }
}
