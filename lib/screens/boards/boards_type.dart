enum BoardsType { feed, anonymous, free, recruit, info, advertisement }

const Map<BoardsType, String> boardsType = {
  BoardsType.feed: '피드',
  BoardsType.anonymous: '익명',
  BoardsType.free: '자유',
  BoardsType.recruit: '구인',
  BoardsType.info: '정보공유',
  BoardsType.advertisement: '홍보',
};

// TODO: Server로부터 fetchBoardId 받아오면 바뀔 예정
List<Map<String, dynamic>> boardsList = [
  {'id': 0, 'name': BoardsType.feed},
  {'id': 1, 'name': BoardsType.anonymous},
  {'id': 2, 'name': BoardsType.free},
  {'id': 3, 'name': BoardsType.recruit},
  {'id': 4, 'name': BoardsType.info},
  {'id': 5, 'name': BoardsType.advertisement},
];
