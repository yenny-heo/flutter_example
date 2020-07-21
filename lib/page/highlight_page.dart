import 'package:flutter/material.dart';
import 'package:keep_bible_app/data/title.dart';
import 'package:keep_bible_app/local_storage/highlighted_verses.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'verse_page.dart';

List<HighlightInfo> highlightList = List<HighlightInfo>();

class HighlightInfo {
  String fullName;
  String bookName;
  int book;
  int chapter;
  int verse;
  HighlightInfo(fullName, bookName, book, chapter, verse) {
    this.fullName = fullName;
    this.bookName = bookName;
    this.book = book;
    this.chapter = chapter;
    this.verse = verse;
  }
}

class HighlightList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark =
    Provider.of<AppStateNotifier>(context, listen: false).getModeState();
    highlightList = [];
    for (int i = 0; i < highlights.length; i++) {
      for (int j = 0; j < highlights[i].length; j++) {
        for (int k = 0; k < highlights[i][j].length; k++){
          if(highlights[i][j][k]){
            String fullName, bookName;
            if (i <= 38) {
              //구약
              fullName = korOldB[i] + " " + (j + 1).toString() + "장 " + (k+1).toString() + "절";
              bookName = korOldB[i];
            } else {
              fullName = korNewB[i - 39] + " " + (j + 1).toString() + "장 " + (k+1).toString() + "절";
              bookName = korNewB[i - 39];
            }
            HighlightInfo h = HighlightInfo(fullName, bookName, i, j, k);
            highlightList.add(h);
          }
        }
      }
    }
    return Scaffold(
        appBar: AppBar(title: Text('책갈피 목록')),
        body: ListView.builder(
            itemCount: highlightList.length,
            itemBuilder: (context, i) {
              return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1))),
                  child: ListTile(
                    title: Center(
                        child: Text(highlightList[i].fullName,
                            style: TextStyle(
                                fontSize: 25,
                                color: isDark? AppTheme.darkMode.accentColor : AppTheme.lightMode.accentColor
                            ))),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                  name: highlightList[i].bookName,
                                  book: highlightList[i].book,
                                  chapter: highlightList[i].chapter,
                                  verse: highlightList[i].verse)));
                    },
                  ));
            }));
  }
}
