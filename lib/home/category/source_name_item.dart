import 'package:flash_news/model/SourceResponse.dart';
import 'package:flash_news/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SourceNameItem extends StatelessWidget {
Source source;
bool isSelected;
SourceNameItem({required this.source,required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Text(source.name??'',style: isSelected? Theme.of(context).textTheme.labelLarge:Theme.of(context).textTheme.labelMedium,);
  }
}
