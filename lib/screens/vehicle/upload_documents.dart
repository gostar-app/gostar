import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:gostar/core/services/image_picker_service.dart';
import 'package:gostar/core/utils/state_handler.dart';
import 'package:gostar/core/utils/ui_helper.dart';
import 'package:gostar/core/widgets/custom_widgets.dart';
import 'package:gostar/core/widgets/loader/error_container.dart';
import 'package:gostar/providers/vehicle_provider.dart';
import 'package:provider/provider.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({Key? key}) : super(key: key);

  @override
  _UploadDocumentsState createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  List<Map<String, String?>> documents = [
    {'name': 'Driver License', 'path': null},
    {'name': 'Vehicle Registration', 'path': null},
    {'name': 'Insurance Certificate', 'path': null},
    {'name': 'Certificate of Road-Worthiness', 'path': null}
  ];

  List<String> errors = [];

  _selectDocument(int index) async {
    documents[index]['path'] = null;
    setState(() {});

    final picked = await ImagePickerService.pickFile();

    if (picked != null) {
      documents[index]['path'] = picked;
      setState(() {});
    }
  }

  _onSubmit() {
    errors.clear();
    documents.forEach((e) {
      if (e['path'] == null) errors.add('${e['name']} document is required');
    });

    if (errors.isNotEmpty) {
      setState(() {});
      return;
    }

    Provider.of<VehicleProvider>(context, listen: false)
        .saveVehicleDocuments(documents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Documents')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: space2x),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: space4x.h),
                if (errors.isNotEmpty) ErrorContainer(errors: errors),
                ImageSelector(
                  text: 'Driver License',
                  imagePath: documents[0]['path'],
                  onTap: () => _selectDocument(0),
                ),
                SizedBox(height: space3x.h),
                ImageSelector(
                  text: 'Vehicle Registration',
                  imagePath: documents[1]['path'],
                  onTap: () => _selectDocument(1),
                ),
                SizedBox(height: space3x.h),
                ImageSelector(
                  text: 'Insurance Certificate',
                  imagePath: documents[2]['path'],
                  onTap: () => _selectDocument(2),
                ),
                SizedBox(height: space3x.h),
                ImageSelector(
                  text: 'Certificate of Road Worthiness',
                  imagePath: documents[3]['path'],
                  onTap: () => _selectDocument(3),
                ),
                SizedBox(height: space4x.h),
                Consumer<VehicleProvider>(
                  builder: (context, provider, child) {
                    if (provider.state == ProviderState.success) {
                      scheduleMicrotask(() {
                        provider.handleEmpty();
                        while (context.canPop()) {
                          context.pop();
                        }
                        context.go('/tabs');
                      });
                    }

                    return FlexibleButton(
                      width: double.infinity,
                      text: 'Submit',
                      isLoading: provider.state == ProviderState.loading,
                      onPressed: _onSubmit,
                    );
                  },
                ),
                SizedBox(height: space6x.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageSelector extends StatelessWidget {
  const ImageSelector({
    super.key,
    required this.text,
    required this.onTap,
    this.imagePath,
  });

  final String text;
  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text),
            if (imagePath != null)
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'Change',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.r,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: space1x.h),
        GestureDetector(
          onTap: onTap,
          child: AspectRatio(
            aspectRatio: 2,
            child: imagePath != null
                ? PDFView(
                    filePath: imagePath,
                    autoSpacing: true,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    onRender: (_pages) {},
                    onError: (error) {
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      showToast('Something went wrong');
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      // _controller.complete(pdfViewController);
                    },
                  )
                : Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade300,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(CupertinoIcons.doc_text),
                        SizedBox(height: 4.h),
                        const Text('Upload Document')
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
