import 'package:ebook/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

part 'book_controller.dart';

class BookView extends StatefulWidget {
  const BookView({
    Key? key,
    required this.bookController,
  }) : super(key: key);

  final BookController bookController;

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  late InAppWebViewController _webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        mediaPlaybackRequiresUserGesture: false,
        javaScriptEnabled: true,
      ),
      android: AndroidInAppWebViewOptions(useHybridComposition: true),
      ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true, scrollsToTop: true));

  int? _position;
  int? _chapter;

  Future<int?> get position => _webViewController.getScrollY();

  int get chapter => _chapter ?? 0;

  @override
  void initState() {
    widget.bookController._attach(this);
    _position = widget.bookController._initPosition;
    _chapter = widget.bookController._initChapter;

    super.initState();
  }

  void forwardChapter() {
    _chapter = _chapter! + 1;
    _position = 0;
    _loadWebView(
        context: context,
        position: _position!,
        webViewController: _webViewController,
        htmlColorBackground: widget.bookController.htmlColorBackground,
        htmlColorTextBackground: widget.bookController.htmlColorTextBackground,
        htmlColorText: widget.bookController.htmlColorText,
        content: widget.bookController.book.chapters[_chapter!],
        reverse: widget.bookController.reverse);
  }

  void backChapter() {
    _chapter = _chapter! - 1;
    _position = 0;
    _loadWebView(
        context: context,
        position: _position!,
        webViewController: _webViewController,
        htmlColorBackground: widget.bookController.htmlColorBackground,
        htmlColorTextBackground: widget.bookController.htmlColorTextBackground,
        htmlColorText: widget.bookController.htmlColorText,
        content: widget.bookController.book.chapters[_chapter!],
        reverse: widget.bookController.reverse);
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialOptions: options,
      onWebViewCreated: (controller) async {
        _webViewController = controller;

        await _loadWebView(
            context: context,
            position: _position!,
            webViewController: _webViewController,
            htmlColorBackground: widget.bookController.htmlColorBackground,
            htmlColorTextBackground: widget.bookController.htmlColorTextBackground,
            htmlColorText: widget.bookController.htmlColorText,
            content: widget.bookController.book.chapters[_chapter!],
            reverse: widget.bookController.reverse);

        await _webViewController.scrollTo(x: 0, y: _position!, animated: false);
      },
      onLoadStop: (__, _) async {
        await Future.delayed(Duration(milliseconds: 40));

        int reversePosition = (_position != 0) ? (_position!) : 999999;

        await _webViewController.scrollTo(
            x: 0, y: widget.bookController.reverse ? reversePosition : _position!, animated: false);
      },
      onScrollChanged: (_, x, y) {
        print('position: $x, $y');
      },
    );
  }
}

Future<void> _loadWebView(
    {required BuildContext context,
    required InAppWebViewController webViewController,
    required String htmlColorBackground,
    required int position,
    required String htmlColorTextBackground,
    required String htmlColorText,
    required String? content,
    required bool reverse}) async {
  await webViewController.loadData(data: '''
          <!DOCTYPE html><html><head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
          <style>
            body{
              background-color: $htmlColorBackground;
              color: $htmlColorText;
              position: static;
              
            }
            
            ${(reverse == true) ? '''
                  .block1{
                      transform: rotate(-90deg);
                      transform-origin: top right;
                      position: absolute;
                      right: 100%;
                      writing-mode: vertical-lr;

                      max-height: 95vw;
                    }

                    ''' : ''}
                    
                    
            ${(reverse == true) ? '''
                  img {
                    transform: rotate(-90deg) scaleY(-1);
                    transform-origin: top right;
                    overflow: auto;
                    position: relative;   

                    max-width: 95vw;
                    max-height: 95vw;
                    
                    margin-left: 95vw;
                  }

                    ''' : '''
                    
                    img {
                      width: 100%; 
                    }
                    '''}
                    
     
            v {
              background-color: $htmlColorTextBackground;
              color: $htmlColorText;
              font-style: italic;
            }
          </style>
          

           <body>
            <div class = "block1">
                $content
            </div>

            
            
          </body>
                                                              
       
          ''', mimeType: 'text/html', encoding: 'utf-8');
}
