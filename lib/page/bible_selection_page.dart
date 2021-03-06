import 'package:flutter/material.dart';
import 'package:keep_bible_app/local_storage/selected_bibles.dart';
import 'package:keep_bible_app/state/app_state_notifier.dart';
import 'package:keep_bible_app/theme/app_theme.dart';
import 'package:keep_bible_app/toast/toast.dart';
import 'package:provider/provider.dart';


class BibleSelection extends StatefulWidget{
  _BibleSelectionState createState() => _BibleSelectionState();
}

class _BibleSelectionState extends State<BibleSelection>{
  @override
  Widget build(BuildContext context) {
    bool isDark =
    Provider.of<AppStateNotifier>(context, listen: false).getModeState();
    return Scaffold(
      appBar: AppBar(title: Text('역본 선택')),
      body: Column(
        children: <Widget>[
          ListTile(
            title: _title('KJV 흠정역 한글', isDark),
            leading: Checkbox(
              value: selectedBible[0],
              activeColor: AppTheme.lightMode.primaryColor,
              onChanged: (val){
                setState((){
                  if(selectedBible[0] == true && selectedBible[1] == false && selectedBible[2] == false)
                    {
                      toast("최소 하나 이상의 역본을 선택해야 합니다.");
                    }
                  else{
                    Provider.of<AppStateNotifier>(context, listen: false).setSelectedBibleState(0);
                    writeSelectedBible(0);//save in local storage
                  }
                });
              },
            )
          ),
          ListTile(
              title: _title('KJV 흠정역 영어', isDark),
              leading: Checkbox(
                value: selectedBible[1],
                activeColor: AppTheme.lightMode.primaryColor,
                onChanged: (val){
                  setState((){
                    if(selectedBible[0] == false && selectedBible[1] == true && selectedBible[2] == false)
                      {
                        toast("최소 하나 이상의 역본을 선택해야 합니다.");
                      }
                    else{
                      Provider.of<AppStateNotifier>(context, listen: false).setSelectedBibleState(1);
                      writeSelectedBible(1);//save in local storage
                    }
                  });
                },
              )
          ),
          ListTile(
              title: _title('개역 성경', isDark),
              leading: Checkbox(
                value: selectedBible[2],
                activeColor: AppTheme.lightMode.primaryColor,
                onChanged: (val){
                  setState((){
                    if(selectedBible[0] == false && selectedBible[1] == false && selectedBible[2] == true)
                    {
                      toast("최소 하나 이상의 역본을 선택해야 합니다.");
                    }
                    else{
                       Provider.of<AppStateNotifier>(context, listen: false).setSelectedBibleState(2);
                      writeSelectedBible(2);//save in local storage
                    }
                  });
                },
              )
          ),
        ],
      )
    );
  }

}


Text _title(String title, bool isDark) {
  return Text(
    title,
    style: TextStyle(fontSize: 20, color: isDark? AppTheme.darkMode.accentColor:AppTheme.lightMode.accentColor),
  );
}