notificationsType(String? kind) {
  String description;
  switch (kind) {
    case 'POST_COMMENT': description = ' 님이 댓글을 남겼습니다.'; break;
    case 'POST_COMMENT_MENTION': description = ' 님이 댓글에서 언급했습니다.'; break;
    case 'POST_SCRAP': description = ' 님이 게시글을 스크랩했습니다.'; break;
    case 'POST_LIKE': description = ' 님이 게시글을 좋아합니다.'; break;
    case 'POST_COMMENT_LIKE': description = ' 님이 댓글을 좋아합니다.'; break;
    default: description = ''; break;
  }
  return description;
}
