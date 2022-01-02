import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../models/profiles/profile.dart';

List<Map<String, dynamic>> profiles = [
  {
    'id': 1,
    'nickname': 'marcelko',
    'profileImg': {
      'id': 1,
      'urlPath': 'http://img.danawa.com/prod_img/500000/030/472/img/4472030_1.jpg?shrink=330:330&_v=20160923121953',
    },
  },
  {
    'id': 2,
    'nickname': 'jwjeong',
    'profileImg': {
      'id': 2,
      'urlPath': 'https://cdn.speconomy.com/news/photo/201705/20170514_1_bodyimg_82397.png',
    },
  },
  {
    'id': 3,
    'nickname': 'bluesky',
    'profileImg': {
      'id': 3,
      'urlPath': "https://w.namu.la/s/40de86374ddd74756b31d4694a7434ee9398baa51fa5ae72d28f2eeeafdadf0c475c55c58e29a684920e0d6a42602b339f8aaf6d19764b04405a0f8bee7f598d2922db9475579419aac4635d0a71fdb8a4b2343cb550e6ed93e13c1a05cede75",
    },
    'intro': '🦋 N년차 프로덕트 디자이너\n🐶 강아지 몽무와 동거 중\n✉️ abcd@abcd.com\n📷 @abcddesign',
    'githubId': 'gajagajago',
    'blogUrl': 'https://blog.naver.com/witchyoli',
    'skillSet': ['figma','photoshop','illustrator','adobe xd','primere pro','aftereffect','cinema4D', 'zeplin', 'sketch'],
    'interests': ['개발', '디자인'],
  },
  {
    'id': 4,
    'nickname': '맨날비와',
    'profileImg': {
      'id': 4,
      'urlPath': 'https://t1.daumcdn.net/cfile/tistory/99A97E4C5D25E9C226',
    },
  },
  {
    'id': 5,
    'nickname': '해피언니',
    'profileImg': {
      'id': 5,
      'urlPath': 'https://t1.daumcdn.net/cfile/tistory/241F824757B095710E',
    },
  },
];

class MyProfile with ChangeNotifier {
  Profile _profile;
  bool loading = false;

  MyProfile({@required String authToken}) {
    fetchMyProfile(authToken);
  }

  Profile get profile => _profile;

  Future fetchMyProfile(String authToken) async {
    try {
      Map<String, dynamic> myProfile = profiles[2];
      _profile = Profile.fromJson(myProfile);

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}