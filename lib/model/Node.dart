class Node {
  final String id;
  final String parentId;
  final String name;
  final double value;
  List<Node>? childNodes;

  Node(this.id, this.parentId, this.name, this.value);

  bool get hasChildNodes => childNodes?.isNotEmpty ?? false;
}
