import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/post.dart';
import 'post_repository.dart';

class HttpPostsRepository implements PostRepository {
  // Method to create a Post from JSON
  Post _postFromJson(Map<String, dynamic> json) {

    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['body'] as String,
    );
  }

  @override
  Future<List<Post>> getPost(int postId) async {
    List<Post> postList = [];

    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    try {
      // Fetch the data from the URL
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        for (var item in data) {
          // Convert JSON directly to Post
          postList.add(_postFromJson(item));
        }
      } else {
        throw Exception("Failed to load post");
      }
    } catch (e) {
      throw Exception(e);
    }
    return postList;
  }
}