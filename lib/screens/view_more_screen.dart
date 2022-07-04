import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/api_service/api_service.dart';

import '../model/news_model.dart';

class ViewMoreScreen extends StatefulWidget {
  const ViewMoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewMoreScreen> createState() => _ViewMoreScreenState();
}

class _ViewMoreScreenState extends State<ViewMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiService.getNews(),
        builder: (BuildContext context, AsyncSnapshot<NewsAPi?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.articles!.length,
              itemBuilder: (context, index) {
                final news = snapshot.data!.articles![index];
                return Column(
                  children: [
                    Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("${news.urlToImage}"),
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
