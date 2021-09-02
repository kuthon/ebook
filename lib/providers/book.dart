import 'dart:convert';

import 'package:ebook/model/book.dart';
import 'package:ebook/model/book_cover.dart';
import 'package:ebook/services/json_storage.dart';
import 'package:ebook/services/preferences_storage.dart';
import 'package:flutter/cupertino.dart';

class BooksProvider with ChangeNotifier {
  /// [_jsonStorageService] carries out work with Locale Storage
  /// it stores large amounts of data (contents of books)
  JsonStorageService _jsonStorageService = JsonStorageService('new_books_storage');

  /// [_preferencesStorageService] carries out work with Shared Preferences
  PreferencesStorageService _preferencesStorageService = PreferencesStorageService();

  /// key for [_preferencesStorageService]
  /// it stores small amounts of data that need quick access
  static const String preferencesStorageKey = 'preferences_books_storage_key';

  /// list of books
  late List<BookCover> _books;

  List<BookCover> get books => _books;

  /// the book the user is currently reading
  Book? _currentBook;

  Book? get currentBook => _currentBook;

  void addBook(Book newBook) async {
    _books.add(new BookCover(
        description: newBook.description,
        path: newBook.path,
        title: newBook.title,
        coverImage: newBook.coverImage,
        coverImageBytes: newBook.coverImageBytes,
        lastOpenTime: newBook.lastOpenTime,
        author: newBook.author));
    await _jsonStorageService.set(newBook.path, jsonEncode(newBook.chapters));
    _sortBooks();
    notifyListeners();
    _saveData();
  }

  void changeFavorites(var book) {
    for (var _book in _books) {
      if (_book.path == book.path) {
        _book.isFavorites = !_book.isFavorites;
      }
    }
    notifyListeners();
    _saveData();
  }

  Future<void> openBook(BookCover book) async {
    for (var _book in _books) {
      if (_book.path == book.path) {
        _book.lastOpenTime = new DateTime.now();
        List<String> content = jsonDecode(await _jsonStorageService.get(_book.path)).cast<String>();
        _currentBook = new Book(
            description: _book.description,
            path: _book.path,
            title: _book.title,
            coverImage: _book.coverImage,
            coverImageBytes: _book.coverImageBytes,
            lastOpenTime: _book.lastOpenTime,
            chapters: content,
            isFavorites: _book.isFavorites,
            lastReadChapter: _book.lastReadChapter,
            lastReadPosition: _book.lastReadPosition,
            author: _book.author);
      }
    }

    _sortBooks();
    notifyListeners();
    _saveData();
  }

  void setLastReadPosition(Book book, {required int position, required int chapter}) {
    for (var _book in _books) {
      if (_book.path == book.path) {
        _book.lastReadPosition = position;
        _book.lastReadChapter = chapter;
      }
    }

    notifyListeners();
    _saveData();
  }

  void _sortBooks() {
    _books.sort((b, a) => a.lastOpenTime.compareTo(b.lastOpenTime));

    List<BookCover> tempBooks = [];
    List<String> tempPaths = [];

    for (var book in _books) {
      if (tempPaths.contains(book.path) == false) {
        tempBooks.add(book);
        tempPaths.add(book.path);
      }
    }

    _books = tempBooks;
  }

  Future<void> init() async {
    _books = [];

    /// get values from local storage
    var response = await _preferencesStorageService.get(preferencesStorageKey) as String?;

    if (response == null) return;

    var jsonRes;

    try {
      jsonRes = await json.decode(response);
    } catch (e) {
      print(e);
    }

    if (jsonRes['response'] != null && jsonRes['response'] != 'null') {
      for (var book in jsonRes['response']['items']) {
        _books.add(BookCover.fromJSON(book));
      }
    }

    _sortBooks();
  }

  void _saveData() async {
    String res = this.toJSON();

    await _preferencesStorageService.set(preferencesStorageKey, res);
  }

  String toJSON() {
    return '''
    {
      "response": {
        "items": ${_books.map((book) => book.toJSON()).toList()}
      }
    }
    ''';
  }
}
