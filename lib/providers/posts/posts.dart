import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profiles/profiles.dart';
import '../../models/boards/post.dart';

class Posts with ChangeNotifier {
  List<Post> _posts;
  bool loading = false;

  Posts({@required String authToken}) {
    fetchPosts(authToken);
  }

  List<Post> get posts => _posts;

  Future fetchPosts(String authToken) async {
    try {
      loading = true;

      List<Map<String, dynamic>> posts = [
        {
          'id': 1,
          'boardType': '자유게시판',
          'profile': profiles[0],
          'title': '코딩 뭐부터 시작해야 하나요?',
          'content': '다른 일 하다가 프론트엔드 개발에 관심이 생겼는데 주변에 아는 현업자도 없고 뭐부터 해야할 지 감이 안오네요. 보통 어떤 것부터 시작하시나요?',
          'category': '개발',
          'pictures': [],
          'like': 31,
          'comments': [
            {
              'id': 1,
              'profile': profiles[2],
              'isAuthor': false,
              'isLiked': true,
              'comment': '저도 궁금하네요 ㅎㅎ',
              'like': 3,
            },
            {
              'id': 2,
              'profile': profiles[1],
              'isAuthor': false,
              'isLiked': true,
              'comment': '안녕하세요. 혹시 과외하실 생각 있으시면 저한테 쪽지 보내주세요! 제 프로필에 정보 나와있습니다.',
              'like': 2,
            },
            {
              'id': 3,
              'profile': profiles[0],
              'isAuthor': true,
              'isLiked': false,
              'comment': '@jwjeong 쪽지 드렸습니다!🙏',
              'like': 0,
            },
          ],
          'commentCnt': 10,
          'scrap': 10,
          'isAuthor': false,
          'isLiked': true,
          'isScrapped': true,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 1)),
        },

        {
          'id': 2,
          'boardType': '익명게시판',
          'profile': profiles[1],
          'title': '네이버 코테 보신 분?',
          'content': '어제 네이버 코테 보신 분? 저 좀 잘 본 듯 ㅎㅎ',
          'category': '',
          'pictures': [
            {
              'id': 1,
              'urlPath': 'https://blog.kakaocdn.net/dn/K8Wt1/btq3otTvVJq/i1bXW8koOEg7Sy6azhWuLK/img.png',
            },
            {
              'id': 2,
              'urlPath': 'http://img.danawa.com/prod_img/500000/030/472/img/4472030_1.jpg?shrink=330:330&_v=20160923121953',
            },
            {
              'id': 3,
              'urlPath': 'https://w.namu.la/s/40de86374ddd74756b31d4694a7434ee9398baa51fa5ae72d28f2eeeafdadf0c475c55c58e29a684920e0d6a42602b339f8aaf6d19764b04405a0f8bee7f598d2922db9475579419aac4635d0a71fdb8a4b2343cb550e6ed93e13c1a05cede75',
            },
            {
              'id': 4,
              'urlPath': 'https://t1.daumcdn.net/cfile/tistory/99A97E4C5D25E9C226',
            },
            {
              'id': 5,
              'urlPath': 'https://t1.daumcdn.net/cfile/tistory/241F824757B095710E',
            }
          ],
          'like': 87,
          'comments': [
            {
              'id': 4,
              'profile': profiles[2],
              'isAuthor': false,
              'isLiked': true,
              'comment': '모든 문제 다 풀으셨나요?',
              'like': 3,
            },
            {
              'id': 5,
              'profile': profiles[0],
              'isAuthor': false,
              'isLiked': true,
              'comment': '안녕하세요. 혹시 과외하실 생각 있으시면 저한테 쪽지 보내주세요! 제 프로필에 정보 나와있습니다.',
              'like': 2,
            },
            {
              'id': 6,
              'profile': profiles[1],
              'isAuthor': true,
              'isLiked': false,
              'comment': '@bluesky 어우 당연하죠 엄청 쉽던데요? \n@marcelko 쪽지 드렸습니다!🙏',
              'like': 0,
            },
          ],
          'commentCnt': 30,
          'scrap': 10,
          'isAuthor': false,
          'isLiked': false,
          'isScrapped': true,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },
        {
          'id': 3,
          'boardType': '자유게시판',
          'profile': profiles[2],
          'title': '맥북 사양 추천',
          'content': '맥북 사양 좀 추천해주세요. 주로 피그마, 일러스트정도 쓸 것 같습니당 ㅎㅎㅎ',
          'category': '디자인',
          'pictures': [],
          'like': 10,
          'comments': [
            {
              'id': 4,
              'profile': profiles[1],
              'isAuthor': false,
              'isLiked': false,
              'comment': '모니터 쓰실거면 13인치 추천합니다~',
              'like': 2,
            },
            {
              'id': 8,
              'profile': profiles[4],
              'isAuthor': false,
              'isLiked': false,
              'comment': '저는 좀 기다리셔서 16인치요. 13인치 가벼워서 좋은데 모니터 너무 작아서 후회하고 있어요 ㅠㅠ',
              'like': 1,
            },
          ],
          'commentCnt': 5,
          'scrap': 3,
          'isAuthor': true,
          'isLiked': true,
          'isScrapped': false,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 5)),
        },
        {
          'id': 4,
          'boardType': '자유게시판',
          'profile': profiles[3],
          'title': '설계할 때 무슨 툴 쓰시나요?',
          'content': '웹 서비스 설계 중인데 ppt 쓰다가 툴 바꿔보려고 합니다. 쓰시는 툴 중에 괜찮은 거 추천해주세요.',
          'category': '기획/마케팅',
          'pictures': [],
          'like': 23,
          'comments': [],
          'commentCnt': 14,
          'scrap': 10,
          'isAuthor': false,
          'isLiked': false,
          'isScrapped': true,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 6)),
        },
        {
          'id': 5,
          'boardType': '자유게시판',
          'profile': profiles[4],
          'title': '망고보드 괜찮나요?',
          'content': '망고보드 쓰시는 분들 쓸만 한가요? 너무 비싸서 고민이네요',
          'category': '기타',
          'pictures': [],
          'like': 23,
          'comments': [],
          'commentCnt': 14,
          'scrap': 10,
          'isAuthor': false,
          'isLiked': true,
          'isScrapped': true,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 7)),
        },
      ];

      _posts = posts.map((e) => Post.fromJson(e)).toList();

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
