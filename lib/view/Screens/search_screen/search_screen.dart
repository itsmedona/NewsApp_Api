import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/search_screen_controller.dart';
import '../../Widgets/news_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    TextEditingController textController = TextEditingController();
    SearchScreenController provider =
        Provider.of<SearchScreenController>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .1,
        title: Container(
          padding: EdgeInsets.only(left: 10),
          height: 45,
          width: width * .75,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1)),
          child: Center(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Search Here",
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                fillColor: Colors.white,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              provider.searchData(
                  searchText: textController.text.toLowerCase());
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Text(
              "Search",
              style: TextStyle(color: Colors.red),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black54)),
          ),
          SizedBox(
            width: 10,
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)))),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Expanded(
              child: Provider.of<SearchScreenController>(context, listen: false)
                          .isLoading ==
                      true
                  ? Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemBuilder: (context, index) => NewsCard(
                          title: provider.newsModel?.articles?[index].title ??
                              "",
                          description: provider.newsModel?.articles?[index]
                                  .description ??
                              "",
                          date: provider
                              .newsModel?.articles?[index].publishedAt,
                          imageUrl: provider
                                  .newsModel?.articles?[index].urlToImage ??
                              "",
                          content: provider.newsModel?.articles?[index].content ??
                              "",
                          sourceName: provider.newsModel?.articles?[index]
                                  .source?.name ??
                              "",
                          url: provider.newsModel?.articles?[index].url ?? ""),
                      separatorBuilder: (context, index) =>
                          const Divider(height: 20),
                      itemCount: provider.newsModel?.articles?.length ?? 0),
            )
          ],
        ),
      )),
    );
  }
}
