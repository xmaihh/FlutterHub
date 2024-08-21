class PaginationModel<T> {
  final int curPage;
  final List<T> datas;
  final int offset;
  final bool over;
  final int pageCount;
  final int size;
  final int total;

  PaginationModel({required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return PaginationModel<T>(
      curPage: json['curPage'],
      datas: (json['datas'] as List).map((item) => fromJsonT(item as Map<String, dynamic>)).toList(),
      offset: json['offset'],
      over: json['over'],
      pageCount: json['pageCount'],
      size: json['size'],
      total: json['total'],
    );
  }

  @override
  String toString() {
    return 'PaginationModel{curPage: $curPage, datas: $datas, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total}';
  }
}