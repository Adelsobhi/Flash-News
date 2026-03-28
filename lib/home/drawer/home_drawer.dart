import 'package:flash_news/home/drawer/section_drawer_item.dart';
import 'package:flash_news/utils/app_colors.dart';
import 'package:flash_news/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../utils/assets_manager.dart';

class HomeDrawer extends StatelessWidget {
Function goToHome;
HomeDrawer({required this.goToHome});
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: height*0.18,
          width: double.infinity,
          color: AppColors.whiteColor,
          child: Center(child: Text('Flash News',style: AppStyles.bold24Black,)),),

        SizedBox(height: height*0.02,),
        InkWell(
          onTap: (){
            //todo: go to home
            goToHome();

          },
            child: SectionDrawerItem(imagePath: AssetsManager.homeIcon, text: 'Go To Home')),
        Divider(
          color: AppColors.whiteColor,
          thickness: 2,
          indent: width*0.04,
          endIndent: width*0.04,
        ),
        SizedBox(height: height*0.04,),
        SectionDrawerItem(imagePath: AssetsManager.themeIcon, text: 'theme'),
        SizedBox(height: height*0.01,),
        Container(

          padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
          margin: EdgeInsets.symmetric(horizontal: width*0.04),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),border: Border.all(color: AppColors.whiteColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
            Text('Dark',style: AppStyles.medium16White,),
            Icon(Icons.arrow_drop_down,size: 30,color: AppColors.whiteColor,)
          ],),
        ),
        SizedBox(height: height*0.02,),
        Divider(
          color: AppColors.whiteColor,
          thickness: 2,
          indent: width*0.04,
          endIndent: width*0.04,
        ),
        SizedBox(height: height*0.04,),
        SectionDrawerItem(imagePath: AssetsManager.languageIcon, text: 'language',),
        SizedBox(height: height*0.01,),
        Container(

          padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
          margin: EdgeInsets.symmetric(horizontal: width*0.04),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),border: Border.all(color: AppColors.whiteColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('English',style: AppStyles.medium16White,),
              Icon(Icons.arrow_drop_down,size: 30,color: AppColors.whiteColor,)
            ],),
        ),


      ],
    ) ;
  }
}
