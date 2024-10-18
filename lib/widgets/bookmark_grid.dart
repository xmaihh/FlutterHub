import 'package:flutter/material.dart';
import 'package:flutter_hub/models/bookmark.dart';

class BookmarkGrid extends StatefulWidget {
  final List<Bookmark> bookmarks;
  final Function(Bookmark) onEdit;
  final Function(Bookmark) onDelete;

  BookmarkGrid({
    required this.bookmarks,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<BookmarkGrid> createState() => _BookmarkGridState();
}

class _BookmarkGridState extends State<BookmarkGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.bookmarks.length,
      itemBuilder: (context, index) {
        return BookmarkTile(
          bookmark: widget.bookmarks[index],
          onEdit: widget.onEdit,
          onDelete: widget.onDelete,
        );
      },
    );
  }
}

class BookmarkTile extends StatelessWidget {
  final Bookmark bookmark;
  final Function(Bookmark) onEdit;
  final Function(Bookmark) onDelete;

  BookmarkTile({
    required this.bookmark,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark, size: 40),
          SizedBox(height: 8),
          Text(
            bookmark.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.edit, size: 20),
                onPressed: () => onEdit(bookmark),
              ),
              IconButton(
                icon: Icon(Icons.delete, size: 20),
                onPressed: () => onDelete(bookmark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
