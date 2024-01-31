import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:gostar/core/services/image_picker_service.dart';
import 'package:gostar/core/utils/state_handler.dart';
import 'package:gostar/core/utils/ui_helper.dart';
import 'package:gostar/core/utils/validators.dart';
import 'package:gostar/core/widgets/button/flexible_button.dart';
import 'package:gostar/core/widgets/loader/error_container.dart';
import 'package:gostar/core/widgets/text_field/custom_text_form_field.dart';
import 'package:gostar/providers/vehicle_provider.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

class AddVehicleInfo extends StatefulWidget {
  const AddVehicleInfo({Key? key}) : super(key: key);

  @override
  _AddVehicleInfoState createState() => _AddVehicleInfoState();
}

class _AddVehicleInfoState extends State<AddVehicleInfo> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _registrationNoController = TextEditingController();
  String _selectedVehicleType = 'mini';
  String? _carFrontImage;
  String? _carBackImage;

  List<String> errors = [];

  _onSubmit() async {
    errors.clear();

    if (_formKey.currentState!.validate()) {
      if (_carBackImage == null) {
        errors.add('Car back image is required');
      }
      if (_carFrontImage == null) {
        errors.add('Car front image is required');
      }

      setState(() {});

      if (errors.isNotEmpty) return;

      Provider.of<VehicleProvider>(context, listen: false).saveVehicleInfo(
        _selectedVehicleType,
        _brandController.text,
        _modelController.text,
        _plateNumberController.text,
        _registrationNoController.text,
        _carFrontImage!,
        _carBackImage!,
      );
    }
  }

  _captureFrontImage() async {
    final file = await ImagePickerService.pickImageFromGallery();
    if (file != null) {
      _carFrontImage = file.path;
      setState(() {});
    }
  }

  _captureBackImage() async {
    final file = await ImagePickerService.pickImageFromGallery();
    if (file != null) {
      _carBackImage = file.path;
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: const Text('Add Vehicle Info'),
        // title: Text('Add Vehicle Info'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: space2x),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: space4x.h),
                  SizedBox(height: space3x.h),
                  if (errors.isNotEmpty) ErrorContainer(errors: errors),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedVehicleType,
                    underline: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    items: <String>['Mini', 'Sedan', 'Suv'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value.toLowerCase(),
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedVehicleType = value!;
                      });
                    },
                  ),
                  CustomTextFormField(
                    controller: _brandController,
                    labelText: 'Vehicle Brand',
                    validator: Validators.basic,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: space1x.h),
                  CustomTextFormField(
                    controller: _modelController,
                    labelText: 'Vehicle Model',
                    validator: Validators.basic,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: space1x.h),
                  CustomTextFormField(
                    controller: _plateNumberController,
                    labelText: 'Plate Number',
                    validator: Validators.basic,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: space1x.h),
                  CustomTextFormField(
                    controller: _registrationNoController,
                    labelText: 'Registration No',
                    validator: Validators.basic,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: space4x.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ImageSelector(
                          text: 'Car Front Image',
                          onTap: _captureFrontImage,
                          imagePath: _carFrontImage,
                        ),
                      ),
                      SizedBox(width: space2x.w),
                      Expanded(
                        child: ImageSelector(
                          text: 'Car Back Image',
                          onTap: _captureBackImage,
                          imagePath: _carBackImage,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: space4x.h),
                  Consumer<VehicleProvider>(
                    builder: (context, provider, child) {
                      if (provider.state == ProviderState.success) {
                        scheduleMicrotask(() {
                          provider.handleEmpty();
                          context.push('/upload-documents');
                        });
                      }
                      return FlexibleButton(
                        width: double.infinity,
                        isLoading: provider.state == ProviderState.loading,
                        onPressed: _onSubmit,
                        text: ('Submit'),
                      );
                    },
                  ),
                  SizedBox(height: space4x.h),
                ],
              ),
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
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 5 / 4,
        child: imagePath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath!,
                  fit: BoxFit.cover,
                ),
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
                    const Icon(CupertinoIcons.camera),
                    SizedBox(height: 4.h),
                    Text(text)
                  ],
                ),
              ),
      ),
    );
  }
}
