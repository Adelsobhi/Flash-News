import 'package:flutter/material.dart';
import 'package:flash_news/home/category/category_details.dart';
import 'package:flash_news/home/category/category_fragment.dart';
import 'package:flash_news/utils/app_colors.dart';
import '../model/category_model.dart';
import 'drawer/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false; // حالة البحث
  TextEditingController searchController = TextEditingController();
  CategoryModel? categorySelect;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: isSearching
            ? TextField(

          controller: searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Theme.of(context).indicatorColor.withOpacity(0.7)), // لون الهينت

            border: InputBorder.none,
          ),
          style: TextStyle(color:Theme.of(context).indicatorColor , fontSize: 18),
          onChanged: (value) {
            // هنا ممكن تضيف فلترة الأخبار حسب النص
          },
        )
            : Text(
          'Home',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: height * 0.01, horizontal: width * 0.04),
            child: IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search, size: 30),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController.clear(); // مسح النص لو ضغط الغلق
                  }
                });
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.blackColor,
        child: HomeDrawer(goToHome: goToHome),
      ),
      body: categorySelect == null
          ? CategoryFragment(
        onViewAllPressed: onViewAllPressed,
      )
          : CategoryDetails(categoryModel: categorySelect!),
    );
  }

  void onViewAllPressed(CategoryModel newSelectedCategory) {
    categorySelect = newSelectedCategory;
    setState(() {});
  }

  void goToHome() {
    categorySelect = null;
    Navigator.pop(context);
    setState(() {});
  }
}