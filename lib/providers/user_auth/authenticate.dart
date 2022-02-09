import 'package:flutter/material.dart';
import 'package:guam_community_client/models/profiles/profile.dart';

class Authenticate with ChangeNotifier {
  final _kakaoClientId = "367d8cf339e2ba59376ba647c7135dd2";
  final _kakaoJavascriptClientId = "2edf60d1ebf23061d200cfe4a68a235a";

  get kakaoClientId => _kakaoClientId;
  get kakaoJavascriptClientId => _kakaoJavascriptClientId;

  Profile me;
  bool loading = false;

  bool isMe(int userId) => me.id == userId;

  Future kakaoSignIn(String kakaoAccessToken) async {
    print(kakaoAccessToken);
  }

  Future<Profile> getUserProfile(int userId) async {
    return me;
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }
}
