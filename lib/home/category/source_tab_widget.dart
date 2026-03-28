import 'package:flash_news/home/category/source_name_item.dart';
import 'package:flash_news/home/news/news_widget.dart';
import 'package:flash_news/model/SourceResponse.dart';
import 'package:flash_news/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SourceTabWidget extends StatefulWidget {
List<Source>sourcesList;
SourceTabWidget({required this.sourcesList});

  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}

class _SourceTabWidgetState extends State<SourceTabWidget> {

  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;
    var width =MediaQuery.of(context).size.width;
    return DefaultTabController(
        initialIndex: 0,
        length: widget.sourcesList.length,

        child: Column(
          children: [
            SizedBox(height: height*0.03,),
            TabBar(
              onTap:(index) {
                selectedIndex=index;
                setState(() {

                });
              },
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: Theme.of(context).indicatorColor,
              dividerColor: AppColors.transparentColor,
              tabs: widget.sourcesList.map((source){
              return SourceNameItem(source: source,
                  isSelected: selectedIndex==widget.sourcesList.indexOf(source));
            }).toList(), ),
            SizedBox(height: height*0.03,),
            Expanded(
              child: widget.sourcesList.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : NewsWidget(
                source: widget.sourcesList[selectedIndex],
              ),
            )          ],
        )) ;
  }
}
