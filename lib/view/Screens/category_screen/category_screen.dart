import 'package:flutter/material.dart';
import 'package:news_app_api/view/Widgets/news_card.dart';
import 'package:provider/provider.dart';
import '../../../controller/category_controller.dart';

class CategoryScreen extends StatelessWidget {
  Future<void> fetchData(BuildContext context) async {
    Provider.of<CategoryController>(context, listen: false).fethchData();
  }

  @override
  Widget build(BuildContext context) {
    fetchData(context);
    var height = MediaQuery.of(context).size.height;
    return Consumer<CategoryController>(
      builder: (context, provider, child) {
        return DefaultTabController(
          length: provider.categoryList.length,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              titleTextStyle: const TextStyle(
                  color: Colors.red, fontSize: 25, fontWeight: FontWeight.w600),
              title: const Text("Categories"),
              centerTitle: true,
              bottom: TabBar(
                labelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
                unselectedLabelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                overlayColor: const MaterialStatePropertyAll(Colors.grey),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                isScrollable: true,
                tabs: List.generate(
                  provider.categoryList.length,
                  (index) => Tab(
                    text: provider.categoryList[index],
                  ),
                ),
                onTap: (value) {
                  provider.onTap(index: value);
                },
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              toolbarHeight: height * .06,
            ),
            body: provider.isLoading == true
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.separated(
                        itemBuilder: (context, index) => NewsCard(
                              title: provider.newsModel.articles?[index].title
                                      .toString() ??
                                  "",
                              description: provider
                                      .newsModel.articles?[index].description
                                      .toString() ??
                                  "",
                              date: provider
                                  .newsModel.articles?[index].publishedAt,
                              imageUrl: provider
                                      .newsModel.articles?[index].urlToImage
                                      .toString() ??
                                  "",
                              content: provider
                                      .newsModel.articles?[index].content
                                      .toString() ??
                                  "",
                              sourceName: provider
                                      .newsModel.articles?[index].source?.name
                                      .toString() ??
                                  "",
                              url: provider.newsModel.articles?[index].url
                                      .toString() ??
                                  "",
                            ),
                        separatorBuilder: (context, index) => const Divider(
                              height: 20,
                            ),
                        itemCount: provider.newsModel.articles?.length ?? 0),
                  ),
          ),
        );
      },
    );
  }
}
