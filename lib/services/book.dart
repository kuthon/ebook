import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:ebook/model/book.dart';
import 'package:ebook/utils/constants.dart';
import 'package:epubx/epubx.dart' as epub;
import 'package:fb2_parse/fb2_parse.dart' as fb2;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class BookService {
  static Future<Book?> getBookFromPath(String path) async {
    /// extension of file
    String extension = RegExp(r'\.([^\.]*)$').firstMatch(path)!.group(1).toString();

    /// supported formats fb2, fb2.zip, epub, txt, txt.zip
    if (extension != 'fb2' && extension != 'zip' && extension != 'epub' && extension != 'txt') return null;

    File _file = File(path);

    if (await _file.exists() == false) return null;

    /// ENCODE ZIP
    if (extension == 'zip') {
      _file = await encodeZip(_file);
    }

    /// update the file extension
    extension = RegExp(r'\.([^\.]*)$').firstMatch(_file.path)!.group(1).toString();

    /// PARSE FB2
    if (extension == 'fb2') {
      return await compute(parseFB2, _file);
    }

    /// PARSE EPUB
    if (extension == 'epub') {
      return await compute(parseEpub, _file);
    }

    /// PARSE TXT
    if (extension == 'txt') {
      return await compute(parseTxt, _file);
    }
  }

  static Future<Book> parseFB2(File fb2book) async {
    fb2.FB2Book _book = fb2.FB2Book(fb2book.path);
    await _book.parse();
    return Book(
      author:
          '${_book.description.authors?.first.firstName} ${_book.description.authors?.first.middleName} ${_book.description.authors?.first.lastName}',
      chapters: _book.body.sections!.map((e) => '${e.content}').toList(),
      path: _book.path,
      lastOpenTime: new DateTime.now(),
      description: '${_book.description.annotation}',
      title: '${_book.description.bookTitle}',
      coverImage: Image.memory(base64Decode('${_book.images.first.bytes}')),
      coverImageBytes: '${_book.images.first.bytes}',
    );
  }

  static Future encodeZip(File zip) async {
    final bytes = zip.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    String pathOut = (await pathProvider.getTemporaryDirectory()).path;
    var encodeFile = File(pathOut + archive.first.name)
      ..createSync()
      ..writeAsBytesSync(archive.first.content);
    return encodeFile;
  }

  static Future<Book> parseEpub(File epubFile) async {
    epub.EpubBook _epubBook = await epub.EpubReader.readBook(epubFile.readAsBytesSync());

    List<String> _chapters = [];

    /// iterating over all files
    _epubBook.Content!.Html!.forEach((key, value) {
      /// if the file is html or xhtml, then we process it as needed
      if (key!.contains('html')) {
        /// cover and titlepage - files that should not be in the book
        if (key.contains('cover')) return;
        if (key.contains('titlepage')) return;

        /// convert all images to base64 format
        value.Content = value.Content!.replaceAllMapped(RegExp(r'<img src="([\s\S]+?)"([\s\S]+?)><\/img>'), (match) {
          if (_epubBook.Content?.Images?[match.group(1)!]?.Content == null) {
            return '';
          }
          String bytesImage = '${base64Encode(_epubBook.Content!.Images![match.group(1)!]!.Content!)}';

          return '<img src="data:image/png;base64, $bytesImage"/>';
        });

        /// remove all links
        value.Content =
            value.Content!.replaceAllMapped(RegExp(r'<a ([a-zA-Z\:]*)href([\s\S]+?)>([\s\S]+?)<\/a>'), (match) {
          return '${match.group(3)}';
        });

        /// add the resulting chapter
        _chapters.add('${RegExp(r'<body([\s\S]+?)>([\s\S]+)<\/body>').firstMatch(value.Content!)?.group(2)}');
      }
    });

    /// convert an cover image in base 64
    String? coverBytes;
    _epubBook.Content?.Images!.forEach((key, value) {
      if (key!.contains('cover')) {
        coverBytes = base64Encode(value.Content!);
      }
    });

    return Book(
      author: '${_epubBook.Author}',
      chapters: _chapters,
      path: epubFile.path,
      lastOpenTime: new DateTime.now(),
      description: '${_chapters[0]}',
      title: '${_epubBook.Title}',
      coverImage:
          coverBytes != null ? Image.memory(base64Decode(coverBytes!)) : Image.asset('assets/images/default-cover.jpg'),
      coverImageBytes: coverBytes ?? Constants.base64DefaultCoverImage,
    );
  }

  static Future<Book> parseTxt(File txtFile) async {
    String content = txtFile.readAsStringSync();

    int charactersPerChapter = 20000;
    int numberOfChapters = content.length ~/ charactersPerChapter;
    //int chaptersPerLastChapter = content.length - numberOfChapters * charactersPerChapter;

    List<String> chapters = [];

    for (int i = 0; i < numberOfChapters - 1; i++) {
      chapters.add(content.substring(i * charactersPerChapter, (i + 1) * charactersPerChapter));
    }

    chapters.add(content.substring(numberOfChapters * charactersPerChapter));

    String title = RegExp(r'([^\/^\\^\.]+?)\.txt').firstMatch(txtFile.path)!.group(1)!;

    return Book(
      author: '',
      chapters: chapters,
      path: txtFile.path,
      lastOpenTime: new DateTime.now(),
      description: content.substring(0, 200),
      title: title,
      coverImage: Image.asset('assets/images/default-cover.jpg'),
      coverImageBytes: Constants.base64DefaultCoverImage,
    );
  }
}
