
import 'package:flash_news/api/Api_manager.dart';
import 'package:flash_news/model/SourceResponse.dart';
import 'package:flash_news/model/newsResponse.dart';
import 'package:flash_news/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/assets_manager.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  final String searchText; // 👈 ضيف ده

  NewsWidget({required this.source,this.searchText=''});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {

  void showNewsOverlay(News news) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return; // نتأكد إن الـ widget مازال موجود

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (sheetContext) { // استخدم context الخاص بال BottomSheet
          var height =MediaQuery.of(sheetContext).size.height;
          var width =MediaQuery.of(sheetContext).size.width;
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(sheetContext).indicatorColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (news.urlToImage != null && news.urlToImage!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(news.urlToImage!, height: 200, fit: BoxFit.cover),
                  ),
                 SizedBox(height:height*0.02 ),
                Text(news.content  ?? "No content available.",
                  style: Theme.of(sheetContext).textTheme.bodyMedium?.copyWith(fontSize: 13,color: Theme.of(sheetContext).primaryColor),
                ),
                SizedBox(height:height*0.02 ),
                Container(
                  width: double.infinity,
                  height: height*0.08,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(13)
                      ),
                      backgroundColor: Theme.of(sheetContext).primaryColor,

                    ),
                    onPressed: () async {
                      final urlString = news.url;
                      if (urlString != null) {
                        final uri = Uri.parse(urlString);
                        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                          if (mounted) {
                            ScaffoldMessenger.of(sheetContext).showSnackBar(
                              const SnackBar(content: Text('Unable to open link')),
                            );
                          }
                        }
                      }
                    },
                    child: Text("View Full Article",
                      style: Theme.of(sheetContext).textTheme.labelLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;
    var width =MediaQuery.of(context).size.width;
    return FutureBuilder<NewsResponse?>(
      future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(color: AppColors.greyColor),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.error.toString(),
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Text("No data available", style: Theme.of(context).textTheme.bodyMedium),
          );
        }

        var newsResponse = snapshot.data!;
        if (newsResponse.status != 'ok') {
          return Center(
            child: Text(newsResponse.message ?? 'Error', style: Theme.of(context).textTheme.headlineLarge),
          );
        }

        var newsList = newsResponse.articles ?? [];
        if (widget.searchText.isNotEmpty) {
          newsList = newsList
              .where((news) =>
          (news.title ?? '').toLowerCase().contains(widget.searchText.toLowerCase()) ||
              (news.description ?? '').toLowerCase().contains(widget.searchText.toLowerCase()) ||
              (news.content ?? '').toLowerCase().contains(widget.searchText.toLowerCase()))
              .toList();
        }

        if (newsList.isEmpty) {
          return Center(
            child: Text("No news matches your search.", style: Theme.of(context).textTheme.headlineMedium),
          );
        }
        if (newsList.isEmpty) {
          return Center(
            child: Container(
              margin: EdgeInsets.all(22),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(AssetsManager.sorryImage,
                      height: height*0.4,width: width*0.9,),
                  Text("Sorry", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20)),
                  SizedBox(height:height*0.03,),
                  Text("This channel does not contain news. Choose another channel from the top.",   textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 15,fontWeight: FontWeight.normal) ,)
                ],
                ),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => showNewsOverlay(newsList[index]), // آمنة الآن
              child: NewsItem(news: newsList[index]),
            );
          },
        );
      },
    );
  }
}



// import 'package:flash_news/api/Api_manager.dart';
// import 'package:flash_news/model/SourceResponse.dart';
// import 'package:flash_news/utils/app_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'news_item.dart';
//
// class NewsWidget extends StatefulWidget {
// Source source;
// NewsWidget({required this.source});
//
//   @override
//   State<NewsWidget> createState() => _NewsWidgetState();
// }
//
// class _NewsWidgetState extends State<NewsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: ApiManager.getNewsBySourceId(widget.source.id??''),
//         builder:(context,snapshot){
//     if(snapshot.connectionState==ConnectionState.waiting){
//       return const Center(child:  CupertinoActivityIndicator(color: AppColors.greyColor,),);
//     }
//     else if(snapshot.hasError){
//       return Center(
//         child: Column(children: [
//           Text(snapshot.error.toString(),style: Theme.of(context).textTheme.headlineLarge,),
//           ElevatedButton(onPressed: (){
//             ApiManager.getNewsBySourceId(widget.source.id??'');
//             setState(() {
//
//             });
//           }, child: Text('try again',style: Theme.of(context).textTheme.headlineLarge))
//         ],),
//       );
//     }
//     if(snapshot.data!.status!='ok'){
//       return Center(
//         child: Column(children: [
//           Text(snapshot.data!.message!,style: Theme.of(context).textTheme.headlineLarge,),
//           ElevatedButton(onPressed: (){
//             ApiManager.getNewsBySourceId(widget.source.id??'');
//             setState(() {
//
//             });
//           }, child: Text('try again',style: Theme.of(context).textTheme.headlineLarge))
//         ],),
//       );
//     }
//     var newsList=snapshot.data!.articles??[];
//     if (newsList.isEmpty) {
//       return Container(
//         alignment: Alignment.center,
//         child: Center(
//           child: Text("No news is currently available.",style:Theme.of(context).textTheme.labelMedium,),
//         ),
//       );
//     }
//     return ListView.builder(itemBuilder: (context,index){
//       return  NewsItem(news: newsList[index]);
//     },itemCount: newsList.length,)  ;
//     } );
//   }
// }
