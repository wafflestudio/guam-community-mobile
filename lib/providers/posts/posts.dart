import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import '../../helpers/decode_ko.dart';
import '../../helpers/http_request.dart';
import '../../models/boards/post.dart';
import '../user_auth/authenticate.dart';

class Posts extends ChangeNotifier with Toast {
  late Authenticate _authProvider;
  Post? _post;
  bool? _hasNext;
  List<Post>? _posts;
  List<Post>? _newPosts;
  List<Post>? _favoritePosts;
  List<Post>? _newFavoritePosts;
  List<Comment>? _comments;
  int? _boardId; // default : 피드게시판
  int? _createdPostId;
  bool loading = false;

  Posts(Authenticate authProvider) {
    _authProvider = authProvider;
    fetchPosts(boardId);
  }

  Post? get post => _post;
  bool? get hasNext => _hasNext;
  int? get boardId => _boardId;
  int? get createdPostId => _createdPostId;
  List<Post>? get posts => _posts;
  List<Post>? get newPosts => _newPosts;
  List<Post>? get favoritePosts => _favoritePosts;
  List<Post>? get newFavoritePosts => _newFavoritePosts;
  List<Comment>? get comments => _comments;

  /// ==== Posts ====
  Future fetchPosts(int? boardId) async {
    // print(await _authProvider.getFirebaseIdToken());
    loading = true;
    try {
      await HttpRequest()
          .get(
        path: "community/api/v1/posts",
        queryParams: {"boardId": boardId != null ? boardId.toString() : null},
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        /// 현재 게시판 위치 저장해두기 (게시판 reload 시 사용)
        _boardId = boardId;
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _posts = jsonList.map((e) => Post.fromJson(e)).toList();
          loading = false;
        } else {
          String msg = '서버가 게시글을 불러올 수 없습니다.: ${response.statusCode}';
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
    return _posts;
  }

  Future fetchFavoritePosts({int? boardId, int rankFrom=0}) async {
    loading = true;
    try {
      await HttpRequest()
          .get(
        path: "community/api/v1/posts/favorites",
        queryParams: {
          "boardId": boardId != null ? boardId.toString() : null,
          "rankFrom": rankFrom.toString(),
        },
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        /// 현재 게시판 위치 저장해두기 (게시판 reload 시 사용)
        _boardId = boardId;
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _favoritePosts = jsonList.map((e) => Post.fromJson(e)).toList();
          loading = false;
        } else {
          String msg = '서버가 게시글을 불러올 수 없습니다.: ${response.statusCode}';
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
    return _favoritePosts;
  }

  /// For Pagination in BoardsFeed Widget using _loadMore()
  Future addPosts({int? boardId, int? beforePostId}) async {
    loading = true;
    try {
      await HttpRequest()
          .get(
        path: "community/api/v1/posts",
        queryParams: {
          "boardId": boardId != null ? boardId.toString() : null,
          "beforePostId": beforePostId.toString(),
        },
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _newPosts = jsonList.map((e) => Post.fromJson(e)).toList();
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
    return _newPosts;
  }

  Future addFavoritePosts({int? boardId, int? rankFrom}) async {
    loading = true;
    try {
      await HttpRequest()
          .get(
        path: "community/api/v1/posts/favorites",
        queryParams: {
          "boardId": boardId != null ? boardId.toString() : null,
          "rankFrom": rankFrom.toString(),
        },
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _newFavoritePosts = jsonList.map((e) => Post.fromJson(e)).toList();
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
    return _newFavoritePosts;
  }

  Future<bool> createPost({Map<String, dynamic>? body, dynamic files}) async {
    bool successful = false;
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .post(
          path: "community/api/v1/posts",
          authToken: authToken,
          body: body,
        ).then((response) async {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8);

            /// S3 Presigned Urls
            List<dynamic> presignedUrls = jsonData['presignedUrls'];
            if (presignedUrls.isNotEmpty) {
              await HttpRequest().put(
                presignedUrls: presignedUrls,
                files: files,
              );
            }
            _createdPostId = jsonData['postId'];
            successful = true;
            loading = false;
            showToast(success: true, msg: '게시글을 작성했습니다.');
          } else {
            String msg = '게시글 작성 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 400: msg = '정보를 모두 입력해주세요. ${response.body}'; break;
              case 401: msg = '글쓰기 권한이 없습니다.'; break;
              case 404: msg = '정보를 모두 입력해주세요.'; break;
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

  Future<Post?> getPost(int? postId) async {
    loading = true;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .get(
          authToken: authToken,
          path: "community/api/v1/posts/$postId",
        ).then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8);
            _post = Post.fromJson(jsonData);
          } else {
            String msg = '서버가 게시글을 불러올 수 없습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = '접근 권한이 없습니다.'; break;
              case 404: msg = '존재하지 않는 게시글입니다.'; break;
            }
            _post = null;
            // showToast(success: false, msg: msg);
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
    return _post;
  }

  /// 게시글 삭제 시 getPost 호출 버그 회피를 위해 toast 제거한 getPost 대체 코드
  Future<Post?> getCreatedPost(int? postId) async {
    loading = true;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .get(
          authToken: authToken,
          path: "community/api/v1/posts/$postId",
        ).then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8);
            _post = Post.fromJson(jsonData);
          } else {
            _post = null;
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
    return _post;
  }

  Future<bool> editPost({int? postId, Map<String, dynamic>? body}) async {
    bool successful = false;
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .patch(
          path: "community/api/v1/posts/$postId",
          authToken: authToken,
          body: body,
        ).then((response) async {
          if (response.statusCode == 200) {
            successful = true;
            loading = false;
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8);
            await getPost(jsonData['postId']);
            showToast(success: true, msg: '게시글을 수정했습니다.');
          } else {
            String msg = '게시글 수정 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 400: msg = '정보를 모두 입력해주세요.'; break;
              case 401: msg = '수정 권한이 없습니다.'; break;
              case 404: msg = '정보를 모두 입력해주세요.'; break;
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

  Future<bool> deletePost(int? postId) async {
    bool successful = false;
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .delete(
          path: "community/api/v1/posts/$postId",
          authToken: authToken,
        ).then((response) {
          if (response.statusCode == 200) {
            showToast(success: true, msg: '게시글을 삭제했습니다.');
            successful = true;
          } else {
            String msg = '게시글 삭제 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = '삭제 권한이 없습니다.'; break;
              case 404: msg = '존재하지 않는 게시글입니다.'; break;
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

  Future<bool> likePost({int? postId}) async {
    loading = true;
    bool successful = false;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .post(
          path: "community/api/v1/posts/$postId/likes",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            loading = false;
            successful = true;
          } else {
            String msg = '게시글 좋아요 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "존재하지 않는 게시글입니다."; break;
              case 409: msg = "이미 '좋아요'한 글입니다."; break;
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

  Future<bool> unlikePost({int? postId}) async {
    loading = true;
    bool successful = false;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .delete(
          path: "community/api/v1/posts/$postId/likes",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            loading = false;
            successful = true;
          } else {
            String msg = '게시글 좋아요 취소 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "'좋아요'하지 않은 게시글입니다."; break;
              case 409: msg = "이미 '좋아요' 취소한 글입니다."; break;
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

  Future<bool> scrapPost({int? postId}) async {
    loading = true;
    bool successful = false;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .post(
          path: "community/api/v1/posts/$postId/scraps",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            loading = false;
            successful = true;
          } else {
            String msg = '게시글 스크랩 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "존재하지 않는 게시글입니다."; break;
              case 409: msg = "이미 스크랩한 글입니다."; break;
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

  Future<bool> unscrapPost({int? postId}) async {
    loading = true;
    bool successful = false;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .delete(
          path: "community/api/v1/posts/$postId/scraps",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            loading = false;
            successful = true;
          } else {
            String msg = '게시글 스크랩 취소 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "스크랩하지 않은 게시글입니다."; break;
              case 409: msg = "이미 스크랩 취소한 글입니다."; break;
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

  /// ==== Comments ====
  Future fetchComments(int? postId) async {
    List<Comment>? comments;
    try {
      loading = true;
      await HttpRequest()
          .get(
        path: "community/api/v1/posts/$postId/comments",
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          comments = jsonList.map((e) => Comment.fromJson(e)).toList();
          loading = false;
        } else {
          showToast(success: false, msg: "댓글을 불러올 수 없습니다.");
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return comments;
  }

  Future<bool> createComment({int? postId, Map<String, dynamic>? body, dynamic files}) async {
    bool successful = false;
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .post(
          path: "community/api/v1/posts/$postId/comments",
          authToken: authToken,
          body: body,
        ).then((response) async {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8);

            /// S3 Presigned Urls
            List<dynamic> preSignedUrls = jsonData['preSignedUrls'];
            if (preSignedUrls.isNotEmpty) {
              await HttpRequest().put(
                presignedUrls: preSignedUrls,
                files: files,
              );
            }
            successful = true;
            loading = false;
            showToast(success: true, msg: '댓글을 작성했습니다.');
          } else {
            String msg = '댓글 작성 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 400: msg = "빈 댓글은 입력할 수 없습니다."; break;
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "존재하지 않는 글입니다."; break;
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

  Future<bool> deleteComment({int? postId, int? commentId}) async {
    bool successful = false;
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .delete(
          path: "community/api/v1/posts/$postId/comments/$commentId",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            fetchComments(postId);
            showToast(success: true, msg: '댓글을 삭제했습니다.');
            successful = true;
          } else {
            String msg = '댓글 삭제 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "존재하지 않는 댓글입니다."; break;
              case 409: msg = "이미 삭제된 댓글입니다."; break;
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

  Future<bool> likeComment({int? postId, int? commentId}) async {
    loading = true;
    bool successful = false;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .post(
          path: "community/api/v1/posts/$postId/comments/$commentId/likes",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            loading = false;
            successful = true;
          } else {
            String msg = '댓글 좋아요 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "존재하지 않는 댓글입니다."; break;
              case 409: msg = "이미 '좋아요'한 댓글입니다."; break;
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

  Future<bool> unlikeComment({int? postId, int? commentId}) async {
    loading = true;
    bool successful = false;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .delete(
          path: "community/api/v1/posts/$postId/comments/$commentId/likes",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            loading = false;
            successful = true;
          } else {
            String msg = '댓글 좋아요 취소 실패: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "'좋아요'하지 않은 댓글입니다."; break;
              case 409: msg = "이미 '좋아요' 취소한 댓글입니다."; break;
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
