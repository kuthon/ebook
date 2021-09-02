part of "book_view.dart";

class BookController {
  _BookViewState? state;

  final Book book;
  final String htmlColorText;
  final String htmlColorTextBackground;
  final String htmlColorBackground;
  final bool reverse;

  late int _initPosition;
  late int _initChapter;

  BookController(
      {required this.book,
      this.htmlColorText = 'black',
      this.htmlColorBackground = 'white',
      this.htmlColorTextBackground = 'white',
      this.reverse = false}) {
    _initPosition = book.lastReadPosition;
    _initChapter = book.lastReadChapter;
  }

  Future<int?> get position => state!.position;

  int get chapter => state?.chapter ?? _initChapter;

  int get numberOfChapters => book.chapters.length;

  void _attach(_BookViewState state) {
    this.state = state;
  }

  void forwardChapter() {
    if (chapter < numberOfChapters - 1) state?.forwardChapter();
  }

  void backChapter() {
    if (chapter > 0) state?.backChapter();
  }
}
