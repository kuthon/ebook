import 'package:ebook/model/book.dart';
import 'package:ebook/providers/book.dart';
import 'package:ebook/services/book.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewBookPage extends StatelessWidget {
  late BooksProvider _booksProvider;

  @override
  Widget build(BuildContext context) {
    _booksProvider = Provider.of<BooksProvider>(context);

    return Scaffold(
        body: SizedBox.expand(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result == null) return;

              Book? _book = await BookService.getBookFromPath(result.files.first.path!);
              if (_book == null) return;

              _booksProvider.addBook(_book);
            },
            child: Text('Open'))
      ],
    )));
  }
}
