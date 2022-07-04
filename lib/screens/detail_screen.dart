import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/bold_text_main.dart';

class DetailScreen extends StatefulWidget {
  final image;
  final title;
  final description;
  final content;
  final url;
  const DetailScreen(
      {Key? key,
      this.image,
      this.title,
      this.description,
      this.content,
      this.url})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xffCF2719),
          ),
        ),
        centerTitle: true,
        title: TextMain(
          text: "News",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Share.share("${widget.url}");
            },
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "${widget.title}",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Hero(
              tag: "${widget.image}",
              child: Container(
                height: 200.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${widget.image}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "${widget.description}",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "${widget.content}",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.sp),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const Text(
                "Fore More Detail",
                style: TextStyle(
                  color: Color(0xffCF2719),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: InkWell(
                onTap: () {
                  launch("${widget.url}");
                },
                child: Text(
                  "${widget.url}",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
