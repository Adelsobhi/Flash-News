import 'package:flash_news/utils/app_colors.dart';
import 'package:flash_news/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SectionDrawerItem extends StatelessWidget {
  String imagePath;
  String text;
SectionDrawerItem({required this.imagePath,required this.text});
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(

        children: [
          SizedBox(width:width*0.04 ,),
          Image.asset(imagePath,color: AppColors.whiteColor,width:30 ,height: 30,),
          SizedBox(width:width*0.07 ,),
          Text(text,style: AppStyles.bold16White,)
        ],
      ),
    );
  }
}
