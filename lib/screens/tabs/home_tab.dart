import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gostar/core/utils/ui_helper.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _isOnline = false;

  onStatusChange(bool val) {
    _isOnline = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: space4x.h),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: space4x.h),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade200,
            ),
          ),
        ),
      ],
    );
  }
}
