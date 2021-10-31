import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
          'profile': {
            'id': 1,
            'nickname': 'marcelko',
            // 일부러 profileImageUrl = null 만듦
            // 'profileImageUrl': 'http://img.danawa.com/prod_img/500000/030/472/img/4472030_1.jpg?shrink=330:330&_v=20160923121953',
            'githubUrl': 'https://github.com/yeonghyeonKO',
            'blogUrl': 'https://newstellar.tistory.com',
            'skillSet': ['Flutter, Django, React', 'pyTorch'],
            'interests': ['개발', '디자인'],
          },
          'title': '코딩 뭐부터 시작해야 하나요?',
          'content': '다른 일 하다가 프론트엔드 개발에 관심이 생겼는데 주변에 아는 현업자도 없고 뭐부터 해야할 지 감이 안오네요. 보통 어떤 것부터 시작하시나요?',
          'interest': '개발',
          'pictures': [],
          'like': 31,
          'commentCnt': 10,
          'scrap': 10,
          'isLiked': true,
          'isScrapped': true,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 1)),
        },

        {
          'id': 2,
          'profile': {
            'id': 2,
            'nickname': 'jwjeong',
            'profileImageUrl': 'https://cdn.speconomy.com/news/photo/201705/20170514_1_bodyimg_82397.png',
            'githubUrl': 'https://github.com/yeonghyeonKO',
            'blogUrl': 'https://newstellar.tistory.com',
            'skillSet': ['Flutter, Django, React', 'pyTorch'],
            'interests': ['개발', '디자인'],
          },
          'title': '네이버 코테 보신 분?',
          'content': '어제 네이버 코테 보신 분? 저 좀 잘 본 듯 ㅎㅎ',
          'interest': '데이터분석',
          'pictures': [
            {
              'id': 1,
              'urlPath': 'https://blog.kakaocdn.net/dn/K8Wt1/btq3otTvVJq/i1bXW8koOEg7Sy6azhWuLK/img.png',
            },
          ],
          'like': 87,
          'commentCnt': 30,
          'scrap': 10,
          'isLiked': false,
          'isScrapped': true,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },
        {
          'id': 3,
          'profile': {
            'id': 3,
            'nickname': 'bluesky',
            'profileImageUrl': 'https://w.namu.la/s/40de86374ddd74756b31d4694a7434ee9398baa51fa5ae72d28f2eeeafdadf0c475c55c58e29a684920e0d6a42602b339f8aaf6d19764b04405a0f8bee7f598d2922db9475579419aac4635d0a71fdb8a4b2343cb550e6ed93e13c1a05cede75',
            'githubUrl': 'https://github.com/yeonghyeonKO',
            'blogUrl': 'https://newstellar.tistory.com',
            'skillSet': ['Flutter, Django, React', 'pyTorch'],
            'interests': ['개발', '디자인'],
          },
          'title': '맥북 사양 추천',
          'content': '맥북 사양 좀 추천해주세요. 주로 피그마, 일러스트정도 쓸 것 같습니당 ㅎㅎㅎ',
          'interest': '디자인',
          'pictures': [],
          'like': 10,
          'commentCnt': 5,
          'scrap': 3,
          'isLiked': true,
          'isScrapped': false,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 5)),
        },
        {
          'id': 4,
          'profile': {
            'id': 4,
            'nickname': '맨날비와',
            'profileImageUrl': 'https://t1.daumcdn.net/cfile/tistory/99A97E4C5D25E9C226',
            'githubUrl': 'https://github.com/yeonghyeonKO',
            'blogUrl': 'https://newstellar.tistory.com',
            'skillSet': ['Flutter, Django, React', 'pyTorch'],
            'interests': ['개발', '디자인'],
          },
          'title': '설계할 때 무슨 툴 쓰시나요?',
          'content': '웹 서비스 설계 중인데 ppt 쓰다가 툴 바꿔보려고 합니다. 쓰시는 툴 중에 괜찮은 거 추천해주세요.',
          'interest': '기획/마케팅',
          'pictures': [],
          'like': 23,
          'commentCnt': 14,
          'scrap': 10,
          'isLiked': false,
          'isScrapped': true,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 6)),
        },
        {
          'id': 5,
          'profile': {
            'id': 5,
            'nickname': '해피언니',
            'profileImageUrl': 'https://t1.daumcdn.net/cfile/tistory/241F824757B095710E',
            'githubUrl': 'https://github.com/yeonghyeonKO',
            'blogUrl': 'https://newstellar.tistory.com',
            'skillSet': ['Flutter, Django, React', 'pyTorch'],
            'interests': ['개발', '디자인'],
          },
          'title': '망고보드 괜찮나요?',
          'content': '망고보드 쓰시는 분들 쓸만 한가요? 너무 비싸서 고민이네요',
          'interest': '기타',
          'pictures': [],
          'like': 23,
          'commentCnt': 14,
          'scrap': 10,
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
