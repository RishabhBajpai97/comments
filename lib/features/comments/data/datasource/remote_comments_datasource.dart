import "dart:convert";
import "package:comments/core/errors/exception.dart";
import "package:comments/features/comments/data/models/comment_model.dart";
import "package:firebase_remote_config/firebase_remote_config.dart";
import "package:http/http.dart" as http;

abstract interface class RemoteCommentsDatasource {
  Future<dynamic> getComments();
  Future<dynamic> fetchRemoteConfig();
}

class RemoteCommentsDatasourceImpl implements RemoteCommentsDatasource {
  http.Client client;
  RemoteCommentsDatasourceImpl(this.client);
  @override
  Future<List<CommentModel>> getComments() async {
    try {
      final response = await client
          .get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
      final List decodedResponse = json.decode(response.body);
      List<CommentModel> comments;
      comments =
          decodedResponse.map((item) => CommentModel.fromJson(item)).toList();
      return comments;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<bool> fetchRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    return remoteConfig.getBool("display_full_email");
  }
}
