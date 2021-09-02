import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ebook/components/show_loading.dart';
import 'package:ebook/model/book_cover.dart';
import 'package:ebook/pages/read_book/read_book.dart';
import 'package:ebook/providers/app.dart';
import 'package:ebook/providers/book.dart';
import 'package:ebook/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookTile extends StatefulWidget {
  final BookCover book;

  BookTile(this.book);

  @override
  _BookTileState createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  late BooksProvider _booksProvider;

  late AppProvider _appProvider;

  @override
  Widget build(BuildContext context) {
    _booksProvider = Provider.of<BooksProvider>(context);
    _appProvider = Provider.of<AppProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.paddingM),
      child: InkWell(
        onTap: () async {
          showLoading(context);
          await _booksProvider.openBook(widget.book);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadBookPage(
                        _booksProvider.currentBook!,
                        isDarkTheme: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
                        reverse: _appProvider.reverse,
                      )));
        },
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Constants.borderRadiusS),
          topLeft: Radius.circular(Constants.borderRadiusS),
        ),
        child: Stack(
          children: [
            Ink(
                padding: const EdgeInsets.symmetric(horizontal: Constants.paddingL, vertical: Constants.paddingM),
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Constants.paddingS),
                      topLeft: Radius.circular(Constants.paddingS),
                    ),
                    color: Theme.of(context).primaryColor),
                child: Row(
                  children: [
                    Expanded(
                      child: widget.book.coverImage,
                      flex: 60,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 240,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '   ${widget.book.title}',
                              style: Theme.of(context).textTheme.subtitle1,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                            Text(
                              '${widget.book.description}',
                              style: Theme.of(context).textTheme.bodyText1,
                              overflow: TextOverflow.fade,
                              maxLines: 4,
                            ),
                          ]),
                    )
                  ],
                )),
            Positioned(
                right: 7,
                top: 0,
                height: 21,
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/bookmark.png',
                    color: widget.book.isFavorites ? Colors.red : Theme.of(context).buttonColor,
                  ),
                  onTap: () {
                    _booksProvider.changeFavorites(widget.book);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
