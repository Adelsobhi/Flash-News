import 'package:flash_news/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../model/category_model.dart';

class CategoryFragment extends StatelessWidget {
  List<CategoryModel> categoriesList=[];
  Function onViewAllPressed;
  CategoryFragment({required this.onViewAllPressed});
  @override
  Widget build(BuildContext context) {
    categoriesList=CategoryModel.getCategoriesList(false);
    var height =MediaQuery.of(context).size.height;
    var width =MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal:width*0.03 ,vertical: height*0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Good Morning \nHere is Some News For You',style: Theme.of(context).textTheme.titleMedium,),
          SizedBox(height: height*0.02,),
          Expanded(child:ListView.separated(
              itemBuilder: (context, index) {
               return Container(
                 child: Stack(
                 alignment: index % 2 ==0?Alignment.bottomRight:Alignment.bottomLeft,
                 children: [

                   ClipRRect(
                       borderRadius: BorderRadius.circular(24),
                       child: Image.asset(categoriesList[index].imagePath,fit: BoxFit.cover,)),
                   Padding(
                     padding:  EdgeInsets.symmetric(
                         horizontal: width*0.03, vertical: height*0.02),

                     child: ToggleSwitch(
                       customWidgets: [
                         Text('View All',style: Theme.of(context).textTheme.bodySmall,),

                         CircleAvatar(
                           backgroundColor: Theme.of(context).primaryColor,
                             child:
                             Icon(Icons.arrow_forward_ios_rounded,color: AppColors.greyColor,size: 25,),)
                       ],
                       customWidths: [
                         width*0.28,
                         width*0.15
                       ],
                       cornerRadius: 20.0,
                       activeBgColors: [
                         [AppColors.transparentColor],
                         [AppColors.transparentColor],
                        ],
                       activeFgColor: Colors.white,
                       inactiveBgColor: AppColors.greyColor,
                       inactiveFgColor: Colors.white,
                       initialLabelIndex: 1,
                       totalSwitches: 2,
                       animate: true,
                       radiusStyle: true,
                       onToggle: (indexx) {
                         print('switched to: $index');
                         onViewAllPressed(categoriesList[index!]);
                       },
                     ),
                   ),
                 ],
               ),);
              },
              separatorBuilder:  (context, index) {
                return SizedBox(height: height*0.02);
              },
              itemCount: categoriesList.length))
        ],
      ),
    );
    }
}
