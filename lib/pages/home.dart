import 'package:ebook/components/book_tile.dart';
import 'package:ebook/components/my_scroll_behavior.dart';
import 'package:ebook/components/show_loading.dart';
import 'package:ebook/generated/l10n.dart';
import 'package:ebook/model/book.dart';
import 'package:ebook/model/book_cover.dart';
import 'package:ebook/pages/favorites_books.dart';
import 'package:ebook/pages/search.dart';
import 'package:ebook/pages/settings.dart';
import 'package:ebook/presentation/my_icons.dart';
import 'package:ebook/providers/book.dart';
import 'package:ebook/services/book.dart';
import 'package:ebook/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/books_list';

  late BooksProvider _booksProvider;

  @override
  Widget build(BuildContext context) {
    _booksProvider = Provider.of<BooksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${S.of(context).all_books}',
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              icon: Icon(Icons.search))
        ],
      ),
      drawer: Drawer(
        elevation: 0,
        child: ScrollConfiguration(
          behavior: MyScrollBehavior(),
          child: ListView(
            children: [
              _createDrawerHeader(context, _booksProvider.books.length > 0 ? _booksProvider.books.first : null),
              _createDrawerItem(context,
                  icon: MyIcons.bookmark,
                  text: '${S.of(context).favorites}',
                  onTap: () => Navigator.pushNamed(context, FavoritesBooksPage.routeName)),
              _createDrawerItem(context,
                  icon: MyIcons.settings,
                  text: '${S.of(context).settings}',
                  onTap: () => Navigator.pushNamed(context, SettingsPage.routeName)),
            ],
          ),
        ),
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
                  for (var book in _booksProvider.books) BookTile(book),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result == null) return;

            showLoading(context);
            Book? _book = await BookService.getBookFromPath(result.files.first.path!);
            Navigator.pop(context);
            if (_book == null) {
              final snackBar = SnackBar(content: Text('${S.of(context).supported_formats}'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }

            _booksProvider.addBook(_book);
          }),
    );
  }

  _createDrawerHeader(BuildContext context, BookCover? book) => DrawerHeader(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/head_drawer.png'), fit: BoxFit.cover),
          ),
          child: Align(
            child: Container(
              color: Colors.white.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: Constants.paddingS, horizontal: Constants.paddingL),
              width: double.infinity,
              child: Text(
                '${book?.title ?? S.of(context).welcome}',
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Color(0xFFFFFFFF)),
              ),
            ),
            alignment: Alignment.bottomLeft,
          ),
        ),
      );

  Widget _createDrawerItem(BuildContext context,
      {required IconData icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(
            width: 32,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
