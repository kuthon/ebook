import 'package:ebook/components/book_tile.dart';
import 'package:ebook/components/my_scroll_behavior.dart';
import 'package:ebook/generated/l10n.dart';
import 'package:ebook/providers/book.dart';
import 'package:ebook/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesBooksPage extends StatelessWidget {
  static const String routeName = '/favorites';

  late BooksProvider _booksProvider;

  @override
  Widget build(BuildContext context) {
    _booksProvider = Provider.of<BooksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${S.of(context).favorites}',
        ),
        elevation: 0,
      ),
      body: _booksProvider.books.length == 0
          ? Center(
              child: Text(S.of(context).no_books_yet),
            )
          : ScrollConfiguration(
              behavior: MyScrollBehavior(),
              child: ListView(
                padding: const EdgeInsets.all(Constants.paddingS),
                children: [
                  for (var book in _booksProvider.books)
                    if (book.isFavorites) BookTile(book),
                ],
              ),
            ),
    );
  }
}
