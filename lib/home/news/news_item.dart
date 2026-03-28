import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImage;
import 'package:flash_news/utils/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flash_news/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/newsResponse.dart';

class NewsItem extends StatelessWidget {
 News news;

NewsItem({required this.news});
  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;
    var width =MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal:width*0.03 ,vertical: height*0.01),
      padding: EdgeInsets.symmetric(horizontal:width*0.02 ,vertical: height*0.008),
      decoration: BoxDecoration(
        border: Border.all( color: Theme.of(context).indicatorColor, width: 2,),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              fit: BoxFit.fill,height: height*0.24,width: width*0.9,
              imageUrl: news.urlToImage??'',
              placeholder: (context, url) =>  const Center(child: CircularProgressIndicator(color: AppColors.greyColor,)),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height:height *0.015,),

          Text(news.title??'',style: Theme.of(context).textTheme.headlineMedium,),
          SizedBox(height:height *0.015,),

          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'By : ${news.author != null ? news.author!.substring(0, min(10, news.author!.length)) : 'No Found'}', style: AppStyles.medium12Grey,
                ),
                SizedBox(width: width*0.01,),
                Spacer(),
                Text(
                  news.publishedAt != null
                      ? timeago.format(
                    DateTime.parse(news.publishedAt!).toLocal(), // مهم جداً
                  )
                      : '',
                  style: AppStyles.medium12Grey,
                )          ],),
          )

        ],
      ),
    );
  }

}
