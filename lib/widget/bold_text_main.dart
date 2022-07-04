import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextMain extends StatelessWidget {
  String? text;
  TextMain({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: 20.sp,
          color: Color(0xffCF2719),
          fontWeight: FontWeight.bold),
    );
  }
}
