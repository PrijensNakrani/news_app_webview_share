import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/api_service/api_service.dart';
import 'package:news_app/screens/web_vew_screen.dart';
import 'package:news_app/widget/bold_text_main.dart';

import '../model/news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _drawerKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: TextMain(
          text: "News",
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: ApiService.getNews2(),
        builder: (BuildContext context, AsyncSnapshot<NewsAPi?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    TextMain(text: "Category"),
                    SizedBox(height: 15.h),
                    CategoryList(),
                    SizedBox(height: 15.h),
                    TextMain(text: "Headline"),
                    SizedBox(height: 10.h),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.articles!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final news = snapshot.data!.articles![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WebViewScreen(url: news.url!),
                                ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 220.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: DecorationImage(
                                      image: NetworkImage("${news.urlToImage}"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "${news.title}",
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "${news.description}",
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.sp,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height: 30.h,
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  CategoryList({Key? key}) : super(key: key);
  List<String> category = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science"
  ];

  List<String> image = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 10.w),
            height: 60.h,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Color(0xffCF2719),
            ),
            child: Center(
              child: Text(
                "${category[index]}",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ),
    );
  }
}
