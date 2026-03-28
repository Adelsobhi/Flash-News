import 'package:flash_news/home/drawer/section_drawer_item.dart';
import 'package:flash_news/provider/theme_provider.dart';
import 'package:flash_news/utils/app_colors.dart';
import 'package:flash_news/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/assets_manager.dart';

class HomeDrawer extends StatefulWidget {
Function goToHome;
HomeDrawer({required this.goToHome});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

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
            widget.goToHome();

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
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.whiteColor,
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Select Theme', style: Theme.of(context).textTheme.headlineSmall),
                      SizedBox(height: 16),
                      ListTile(
                        onTap: () {
                          themeProvider.changeLanguage(ThemeMode.light);

                        },
                        title: themeProvider.themeMode==
                            ThemeMode.light?
                        getSelectedItemWidget(height, 'Light')
                        :getUnSelectedItemWidget(height, 'Light'),

                      ),
                      ListTile(
                        onTap: () {
                        themeProvider.changeLanguage(ThemeMode.dark);

                      },
                        title: themeProvider.themeMode==
                            ThemeMode.dark?
                        getSelectedItemWidget(height, 'Dart')
                            :getUnSelectedItemWidget(height, 'Dart'),

                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
            margin: EdgeInsets.symmetric(horizontal: width * 0.04),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.whiteColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(themeProvider.themeMode==ThemeMode.light?'Light':'Dart', style: AppStyles.medium16White),
                Icon(Icons.arrow_drop_down, size: 30, color: AppColors.whiteColor),
              ],
            ),
          ),
        ),        SizedBox(height: height*0.02,),
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

Widget getSelectedItemWidget(height, String text) {
  return Row(
    children: [
      Text(text, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.blackColor,fontWeight: FontWeight.w700)),
      Spacer(),
      Icon(Icons.check, color: AppColors.blackColor),
      SizedBox(height: height * 0.09),
    ],
  );
}

Widget getUnSelectedItemWidget(height, String text) {
  return Row(
    children: [
      Text(text, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.blackColor,fontWeight: FontWeight.w100)),
      Spacer(),
    ],
  );
}
}
