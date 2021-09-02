import 'package:ebook/components/book_tile.dart';
import 'package:ebook/components/my_scroll_behavior.dart';
import 'package:ebook/generated/l10n.dart';
import 'package:ebook/model/book_cover.dart';
import 'package:ebook/providers/book.dart';
import 'package:ebook/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woozy_search/woozy_search.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late BooksProvider _booksProvider;
  final TextEditingController _textEditingController = TextEditingController();
  List<BookCover> sortedBooks = [];

  @override
  void initState() {
    _textEditingController.addListener(() {
      sortedBooks = _sortBooks(_textEditingController.text, _booksProvider.books);
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _booksProvider = Provider.of<BooksProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                  controller: _textEditingController,
                  textAlignVertical: TextAlignVertical.center,
                  autofocus: true,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).primaryColor,
                    filled: true,
                    contentPadding:
                        new EdgeInsets.symmetric(vertical: Constants.paddingXL, horizontal: Constants.paddingXXXL),
                    focusedBorder: UnderlineInputBorder(),
                    hintText: '${S.of(context).book_name}',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Theme.of(context).textTheme.subtitle2!.color!.withOpacity(0.5)),
                  )),
              if (_textEditingController.text.isEmpty)
                Expanded(child: Center(child: Text('${S.of(context).search_for_books}')))
              else if (sortedBooks.isEmpty)
                Expanded(child: Center(child: Text('${S.of(context).books_not_found}')))
              else
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MyScrollBehavior(),
                    child: ListView(
                      padding: const EdgeInsets.all(Constants.paddingS),
                      children: [
                        for (var book in sortedBooks) BookTile(book),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

List<BookCover> _sortBooks(String text, List<BookCover> books) {
  final woozy = Woozy();
  for (int i = 0; i < books.length; i++) {
    woozy.addEntry(books[i].title, value: books[i]);
  }
  var output = woozy.search(text);

  List<BookCover> sortedBooks = output.map((e) => e.value).toList().cast<BookCover>();

  return sortedBooks;
}
