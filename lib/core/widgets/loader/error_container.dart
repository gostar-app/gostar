import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gostar/core/utils/ui_helper.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({super.key, required this.errors});

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: space3x.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.red.withOpacity(0.08),
        border: Border.all(color: Colors.red.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                size: 16.r,
                color: Colors.red,
              ),
              SizedBox(width: space1x.w),
              const Text(
                'Errors',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: space1x.h),
          ...errors.map((e) => Text('- $e')),
        ],
      ),
    );
  }
}
