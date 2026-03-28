import 'package:flash_news/api/Api_manager.dart';
import 'package:flash_news/home/category/source_tab_widget.dart';
import 'package:flash_news/model/SourceResponse.dart';
import 'package:flash_news/model/category_model.dart';
import 'package:flash_news/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatefulWidget {
  final String searchText; // 👈 جديد
  CategoryModel categoryModel;
  CategoryDetails({required this.categoryModel,this.searchText=''});


  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
        future: ApiManager.getSources(widget.categoryModel.id),
        builder: (context,snapshot){
          //todo: waiting
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: AppColors.greyColor,),);
          }
          //todo: error
          else if(snapshot.hasError){
            return
              Center(
                child: Column(children: [
                  Text('Something went wrong'),
                  ElevatedButton(onPressed: (){
                    ApiManager.getSources(widget.categoryModel.id);
                    setState(() {

                    });

                  }, child: Text('Try again'))

                ],),
              );
          }
          // todo: server=>response (success ,error)
          // todo: server=> error
          if(snapshot.data!.status !='ok'){
            return
              Center(
                child: Column(children: [
                  Text(snapshot.data!.message!),
                  ElevatedButton(onPressed: (){
                    ApiManager.getSources(widget.categoryModel.id);
                    setState(() {

                    });

                  }, child: Text('Try again'))

                ],),
              );
          }
          // todo: server=> success
          var sourcesList=snapshot.data!.sources!;
          return SourceTabWidget(
            searchText:widget.searchText ,
            sourcesList: sourcesList,

          );;

        },
    );
  }
}
