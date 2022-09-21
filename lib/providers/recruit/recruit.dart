import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guam_community_client/helpers/http_request.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/models/projects/tech_stack.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:http/http.dart';

import '../../helpers/decode_ko.dart';
import '../../models/projects/project.dart';

class Recruit extends ChangeNotifier with Toast {
  late Authenticate _authProvider;
  Project? _project;
  bool? _hasNext;
  bool? _hasNextAlmostFull;
  List<Project>? _projects;
  List<Project>? _newProjects;
  List<Project>? _starredProjects;
  List<Project>? _almostFullProjects;
  List<Project>? _newAlmostFullProjects;
  bool loading = false;

  Recruit(Authenticate authProvider){
    _authProvider = authProvider;
  }

  Project? get project => _project;
  bool? get hasNest => _hasNext;
  bool? get hasNextAlmostFull => _hasNextAlmostFull;
  List<Project>? get projects => _projects;
  List<Project>? get starredProjects => _starredProjects;
  List<Project>? get almostFullProjects => _almostFullProjects;

  var dummy = [
    Project(
        id: 1,
        title: 'StackOverflow 토이 프로젝트',
      leader: Profile(nickname: 'DockerS2', profileImg: 'DEV/PROFILE/8/image_picker_A11D9F16-D6BE-415C-8E74-1505826D1CB6-2693-000000AB1F3911BA.jpg'),
      thumbnail: 'https://cdn.pixabay.com/photo/2020/09/09/02/12/smearing-5556288_960_720.jpg',
      techStacks: [
        TechStack(
          icon: 'https://engineering.linecorp.com/wp-content/uploads/2019/08/flutter1.png'
        ),
      ],
        createdAt: "2022-09-19T09:49:52.021Z",
      starCount: 0,
      starred: false,
    ),
    Project(
      id: 1,
      title: 'SoundCloud 만들기',
      leader: Profile(nickname: '영현님 팬', profileImg: 'DEV/PROFILE/8/image_picker_A11D9F16-D6BE-415C-8E74-1505826D1CB6-2693-000000AB1F3911BA.jpg'),
      thumbnail: 'https://cdn.pixabay.com/photo/2020/09/09/02/12/smearing-5556288_960_720.jpg',
      techStacks: [
        TechStack(
            icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/220px-React-icon.svg.png'
        ),
        TechStack(
            icon: 'https://engineering.linecorp.com/wp-content/uploads/2019/08/flutter1.png'
        ),
      ],
      createdAt: "2022-09-19T09:49:52.021Z",
      starCount: 1,
      starred: true,
    ),
    Project(
      id: 1,
      title: '괌 만들기',
      leader: Profile(nickname: 'marcel ko', profileImg: 'DEV/PROFILE/8/image_picker_A11D9F16-D6BE-415C-8E74-1505826D1CB6-2693-000000AB1F3911BA.jpg'),
      thumbnail: 'https://cdn.pixabay.com/photo/2020/09/09/02/12/smearing-5556288_960_720.jpg',
      techStacks: [
        TechStack(
            icon: 'https://5pecia1.github.io/spring-study/static/images/spring-logo.png'
        ),
        TechStack(
            icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/220px-React-icon.svg.png'
        ),
        TechStack(
            icon: 'https://engineering.linecorp.com/wp-content/uploads/2019/08/flutter1.png'
        ),
      ],
      createdAt: "2022-09-19T09:49:52.021Z",
      starCount: 0,
      starred: false,
    ),
    Project(
      id: 1,
      title: 'StackOverflow 토이 프로젝트',
      leader: Profile(nickname: 'DockerS2', profileImg: 'DEV/PROFILE/8/image_picker_A11D9F16-D6BE-415C-8E74-1505826D1CB6-2693-000000AB1F3911BA.jpg'),
      thumbnail: 'https://cdn.pixabay.com/photo/2020/09/09/02/12/smearing-5556288_960_720.jpg',
      techStacks: [
        TechStack(
            icon: 'https://engineering.linecorp.com/wp-content/uploads/2019/08/flutter1.png'
        ),
      ],
      createdAt: "2022-09-19T09:49:52.021Z",
      starCount: 0,
      starred: false,
    ),
    Project(
      id: 1,
      title: 'SoundCloud 만들기',
      leader: Profile(nickname: '영현님 팬', profileImg: 'DEV/PROFILE/8/image_picker_A11D9F16-D6BE-415C-8E74-1505826D1CB6-2693-000000AB1F3911BA.jpg'),
      thumbnail: 'https://cdn.pixabay.com/photo/2020/09/09/02/12/smearing-5556288_960_720.jpg',
      techStacks: [
        TechStack(
            icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/220px-React-icon.svg.png'
        ),
        TechStack(
            icon: 'https://engineering.linecorp.com/wp-content/uploads/2019/08/flutter1.png'
        ),
      ],
      createdAt: "2022-09-19T09:49:52.021Z",
      starCount: 1,
      starred: true,
    ),
    Project(
      id: 1,
      title: '괌 만들기',
      leader: Profile(nickname: 'marcel ko', profileImg: 'DEV/PROFILE/8/image_picker_A11D9F16-D6BE-415C-8E74-1505826D1CB6-2693-000000AB1F3911BA.jpg'),
      thumbnail: 'https://cdn.pixabay.com/photo/2020/09/09/02/12/smearing-5556288_960_720.jpg',
      techStacks: [
        TechStack(
            icon: 'https://5pecia1.github.io/spring-study/static/images/spring-logo.png'
        ),
        TechStack(
            icon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/220px-React-icon.svg.png'
        ),
        TechStack(
            icon: 'https://engineering.linecorp.com/wp-content/uploads/2019/08/flutter1.png'
        ),
      ],
      createdAt: "2022-09-19T09:49:52.021Z",
      starCount: 0,
      starred: false,
    ),
  ];

  Future<List<Project>?> fetchProjects({String? keyword, String? skill,
    int? due, String? position, int rankFrom=0}) async {
    loading = true;
    /*try {
      await HttpRequest()
          .get(
        path: "community/api/v1/projects",
        queryParams: {"keyword": keyword, "skill": skill, "due":due?.toString() , "position": position},
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        /// 현재 게시판 위치 저장해두기 (게시판 reload 시 사용)
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _projects = jsonList.map((e) => Project.fromJson(e)).toList();
          loading = false;
        } else {
          String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
          switch (response.statusCode) {
            case 400: msg = '정보를 모두 입력해주세요.'; break;
            case 401: msg = '열람 권한이 없습니다.'; break;
            case 404: msg = '존재하지 않는 게시판입니다.'; break;
          }
          showToast(success: false, msg: msg);
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
     */
    _hasNext = true;
    _projects = dummy;
    loading = false;
    notifyListeners();
    return _projects;
  }

  Future<List<Project>?> fetchAlmostFullProjects({String? keyword, String? skill,
    int? due, String? position, int rankFrom=0}) async {
    loading = true;
    /*try {
      await HttpRequest()
          .get(
        path: "community/api/v1/projects",
        queryParams: {"almostFull": true,},
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        /// 현재 게시판 위치 저장해두기 (게시판 reload 시 사용)
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNextImpending = json.decode(jsonUtf8)["hasNext"];
          _impendingProjects = jsonList.map((e) => Project.fromJson(e)).toList();
          loading = false;
        } else {
          String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
          switch (response.statusCode) {
            case 400: msg = '정보를 모두 입력해주세요.'; break;
            case 401: msg = '열람 권한이 없습니다.'; break;
            case 404: msg = '존재하지 않는 게시판입니다.'; break;
          }
          showToast(success: false, msg: msg);
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
     */
    _hasNextAlmostFull = true;
    _almostFullProjects = dummy;
    loading = false;
    notifyListeners();
    return _almostFullProjects;
  }

  var temp = 0;
  Future addProjects({int? beforeProjectId}) async {
    loading = true;
    /*try {
      await HttpRequest()
          .get(
        path: "community/api/v1/projects",
        queryParams: {
          "beforeProjectId": beforeProjectId.toString(),
        },
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _newProjects = jsonList.map((e) => Project.fromJson(e)).toList();
          loading = false;
        } else {
          showToast(success: false, msg: '더 이상 게시글을 불러올 수 없습니다.');
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    } */
    if((temp++) > 2) return null;
    _newProjects = dummy;
    loading = false;
    notifyListeners();
    return _newProjects;
  }

  var temp2 = 0;
  Future addAlmostFullProjects({int? beforeProjectId}) async {
    loading = true;
    /*try {
      await HttpRequest()
          .get(
        path: "community/api/v1/projects",
        queryParams: {
          "beforeProjectId": beforeProjectId.toString(),
          "almostFull": true,
        },
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _newImpendingProjects = jsonList.map((e) => Project.fromJson(e)).toList();
          loading = false;
        } else {
          showToast(success: false, msg: '더 이상 게시글을 불러올 수 없습니다.');
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
     */
    if((temp2++) > 1) return null;
    _newAlmostFullProjects = dummy;
    loading = false;
    notifyListeners();
    return _newAlmostFullProjects;
  }

  Future<Project?> getProject(int? projectId) async {
    loading = true;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .get(
          authToken: authToken,
          path: "community/api/v1/projects/$projectId",
        ).then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8);
            _project = Project.fromJson(jsonData);
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = '접근 권한이 없습니다.'; break;
              case 404: msg = '존재하지 않는 프로젝트입니다.'; break;
            }
            _project = null;
            showToast(success: false, msg: msg);
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
    return _project;
  }

  Future<bool> starProject({int? projectId}) async {
    loading = true;
    bool successful = false;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .post(
          path: "community/api/v1/projects/$projectId/stars",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            loading = false;
            successful = true;
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "존재하지 않는 프로젝트입니다."; break;
              // 메시지 내용을 뭐라고 쓸지 모르겠어요
              case 409: msg = "이미 '즐겨찾기'한 프로젝트입니다."; break;
            }
            showToast(success: false, msg: msg);
          }
        });
        loading = false;
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return successful;
  }

  Future<bool> unStarPost({int? projectId}) async {
    loading = true;
    bool successful = false;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .delete(
          path: "community/api/v1/projects/$projectId/stars",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            loading = false;
            successful = true;
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "'즐겨찾기'하지 않은 프로젝트입니다."; break;
              case 409: msg = "이미 '즐겨찾기' 취소한 프로젝트입니다."; break;
            }
            showToast(success: false, msg: msg);
          }
        });
        loading = false;
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return successful;
  }
}