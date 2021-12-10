import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/models/language.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:provider/provider.dart';

import 'language_list.dart';

class LanguagePage extends StatefulWidget {
  LanguagePage({Key key, this.title, this.isAutomaticEnabled})
      : super(key: key);

  final String title;
  final bool isAutomaticEnabled;

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Remove the automatic element if disabled
    // if (!this.widget.isAutomaticEnabled) {
    //   var automaticElement = this
    //       ._languageList
    //       .where((language) => language.code == 'auto')
    //       .toList()[0];
    //   this._languageList.remove(automaticElement);
    // }
  }

  // Send back the selected language
  _sendBackLanguage(Language language) {
    Navigator.pop(context, language);
  }

  // Display the delete text icon if we typed text in the search input
  //close button
  Widget _displayDeleteTextIcon() {
    if (this._searchTextController.text.length > 0) {
      return IconButton(
        icon: Icon(Icons.close),
        color: Colors.grey,
        onPressed: () {
          setState(() {
            _searchTextController.text = "";
          });
        },
      );
    } else {
      return null;
    }
  }

  // Display the list with header if we are not searching
  // Display the list with only languages if we are searching
  Widget _displayTheRightList() {
    if (this._searchTextController.text == "") {
      return this._displayListWithHeaders();
    } else {
      return this._displaySearchedList();
    }
  }

  // Display the language list filtered
  Widget _displaySearchedList() {
    Provider.of<TranslateProvider>(context).searchLanguage(this._searchTextController.text);

    // Display
    return Consumer<TranslateProvider>(
      builder: (context, trans, child) {
        return Expanded(
          child: ListView.builder(
            itemCount: trans.searchedList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return
              //   ListTile(
              //   onTap: () {
              //   },
              //   title: Text(trans.searchedList[index].name),
              // );

                LanguageListElement(

                language: trans.searchedList[index],
                onSelect: this._sendBackLanguage,
              );
            },
          ),
        );
      },
    );
  }

  // Display the list with headers, means we are not searching
  Widget _displayListWithHeaders() {
    // List<Language> recentLanguages =
    // this._languageList.where((e) => e.isRecent).toList();

    // Render
    return Expanded(
      child: CustomScrollView(

        slivers: <Widget>[
          // SliverStickyHeader(
          //   header: Container(
          //     height: 60.0,
          //     color: Colors.blue[600],
          //     padding: EdgeInsets.symmetric(horizontal: 16.0),
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       'Recent Languages',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 16,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          //   sliver: SliverList(
          //     delegate: SliverChildBuilderDelegate(
          //           (context, i) => LanguageListElement(
          //         language: recentLanguages[i],
          //         onSelect: this._sendBackLanguage,
          //       ),
          //       childCount: recentLanguages.length,
          //     ),
          //   ),
          // ),
          SliverStickyHeader(

            header: Container(
              height: 60.0,
              color: AppColors.appBarColor,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'All languages',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            sliver: Consumer<TranslateProvider>(
              builder: (context, trans, child) {
                return SliverList(

                  delegate: SliverChildBuilderDelegate(
                    (context, i) => LanguageListElement(
                      language: trans.languageList[i],
                      onSelect: this._sendBackLanguage,
                    ),
                    childCount: trans.languageList.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        // backgroundColor: Colors.blueAccent,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Strings.text_translator_page_bg),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(
                top: 12.0,
                bottom: 12.0,
                left: 8.0,
                right: 8.0,
              ),
              child: TextField(
                controller: this._searchTextController,
                onChanged: (text) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[600])),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 24.0,
                    color: Colors.grey,
                  ),
                  suffixIcon: this._displayDeleteTextIcon(),
                ),
              ),
            ),
            this._displayTheRightList(),
          ],
        ),
      ),
    );
  }
}
