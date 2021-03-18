import 'package:dscistanbulapi/models/comments.dart';
import 'package:dscistanbulapi/models/posts.dart';
import 'package:http/http.dart' as http;

import 'models/album.dart';
import 'models/post.dart';

String baseUrl = 'https://jsonplaceholder.typicode.com';

Future<List<Posts>> getPosts() async {
  var response = await http.get('$baseUrl/posts');
  return postsFromJson(response.body);
}

Future<Post> getpost(String postId) async {
  var response = await http.get('$baseUrl/posts/$postId');
  return postFromJson(response.body);
}

Future<List<Comments>> getComments(String postId) async {
  var response = await http.get('$baseUrl/comments?postId=$postId');
  return commentsFromJson(response.body);
}

Future<List<Album>> getAlbum() async {
  var response = await http.get('$baseUrl/photos');
  return albumFromJson(response.body);
}

Future<List<Album>> postAlbum() async {
  var response = await http.post('$baseUrl/photos', body: {'postId': 2});
  return albumFromJson(response.body);
}
