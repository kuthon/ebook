import 'package:ebook/model/book.dart';
import 'package:ebook/providers/book.dart';
import 'package:ebook/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_view.dart';

class ReadBookPage extends StatefulWidget {
  static const String routeName = '/read_book';

  late final BookController bookController;
  late final Book book;

  ReadBookPage(this.book, {bool isDarkTheme = true, bool reverse = false}) {
    bookController = BookController(
      book: book,
      htmlColorText: isDarkTheme ? Constants.htmlColorTextDark : Constants.htmlColorTextLight,
      htmlColorBackground: isDarkTheme ? Constants.htmlColorBackgroundDark : Constants.htmlColorBackgroundLight,
      htmlColorTextBackground:
          isDarkTheme ? Constants.htmlColorBackgroundTextDark : Constants.htmlColorBackgroundTextLight,
      reverse: reverse,
    );
  }

  @override
  _ReadBookPageState createState() => _ReadBookPageState();
}

class _ReadBookPageState extends State<ReadBookPage> {
  late BooksProvider _booksProvider;

  @override
  Widget build(BuildContext context) {
    _booksProvider = Provider.of<BooksProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        int position = await widget.bookController.position ?? 0;
        int chapter = widget.bookController.chapter;
        _booksProvider.setLastReadPosition(widget.book, position: position, chapter: chapter);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.book.title,
            overflow: TextOverflow.fade,
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  _booksProvider.changeFavorites(widget.book);
                  setState(() {
                    widget.book.isFavorites = !widget.book.isFavorites;
                  });
                },
                icon: Image.asset(
                  'assets/images/bookmark.png',
                  color: widget.book.isFavorites ? Colors.red : Theme.of(context).buttonColor,
                  width: Theme.of(context).textTheme.headline6!.fontSize,
                ))
          ],
        ),
        body: SizedBox.expand(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(
                          top: Constants.paddingXXL, left: Constants.paddingXXL, right: Constants.paddingXXL),
                      padding: const EdgeInsets.all(Constants.paddingM),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(Constants.borderRadiusS),
                      ),
                      child: BookView(
                        bookController: widget.bookController,
                      ))),
              Container(
                padding: const EdgeInsets.only(
                    left: Constants.paddingXXL,
                    right: Constants.paddingXXL,
                    top: Constants.paddingXL,
                    bottom: Constants.paddingXL),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _backButton(context, number: 1, onTap: () => widget.bookController.backChapter()),
                    _forwardButton(context,
                        number: widget.bookController.numberOfChapters,
                        onTap: () => widget.bookController.forwardChapter())
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _backButton(BuildContext context, {required int number, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(Constants.borderRadiusL),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.paddingM, horizontal: Constants.paddingM),
      child: Row(
        children: [
          Icon(CupertinoIcons.back),
          Text(' Back  $number'),
        ],
      ),
    ),
  );
}

Widget _forwardButton(BuildContext context, {required int number, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(Constants.borderRadiusL),
    child: Padding(
      padding: const EdgeInsets.all(Constants.paddingM),
      child: Row(
        children: [
          Text('$number  Forward '),
          Icon(CupertinoIcons.forward),
        ],
      ),
    ),
  );
}
