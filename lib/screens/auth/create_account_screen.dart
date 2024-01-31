import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:gostar/core/constants.dart';
import 'package:gostar/core/services/image_picker_service.dart';
import 'package:gostar/core/services/storage_service.dart';
import 'package:gostar/core/utils/state_handler.dart';
import 'package:gostar/core/utils/ui_helper.dart';
import 'package:gostar/core/utils/validators.dart';
import 'package:gostar/core/widgets/button/flexible_button.dart';
import 'package:gostar/core/widgets/text_field/custom_text_form_field.dart';
import 'package:gostar/models/app_user.dart';
import 'package:gostar/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  XFile _selectedImage = XFile(DEFAULT_PROFILE_PIC);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  onSubmit() async {
    if (_formKey.currentState!.validate()) {
      Provider.of<AuthenticationProvider>(context, listen: false).signUp(
        _emailController.text.trim().toLowerCase(),
        _nameController.text,
        _cityController.text,
        _selectedImage?.path ?? DEFAULT_PROFILE_PIC,
      );
    }
  }

  _pickImage() async {
    final pickedImage = await ImagePickerService.pickImageFromGallery();

    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: space2x),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: space4x.h),
                  Text(
                    'Add your details',
                    style: TextStyle(
                      fontSize: 24.r,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: space4x.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 64,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular((100)),
                            ),
                            child: Image.asset(
                              _selectedImage.path,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _pickImage,
                        child: Text(
                          _selectedImage != null
                              ? 'Change image'
                              : 'Choose image',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: space2x.h),
                  CustomTextFormField(
                    controller: _nameController,
                    labelText: 'Name',
                    textInputType: TextInputType.name,
                    validator: Validators.basic,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: space2x.h),
                  CustomTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    validator: Validators.basic,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: space2x.h),
                  // Add profile pic field here
                  CustomTextFormField(
                    controller: _cityController,
                    labelText: 'Region/City',
                    validator: Validators.basic,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: space8x.h),
                  Consumer<AuthenticationProvider>(
                    builder: (context, provider, child) {
                      if (provider.state == ProviderState.success) {
                        scheduleMicrotask(() {
                          provider.handleEmpty();
                          context.pushReplacement('/');
                        });
                      }

                      return FlexibleButton(
                        width: double.infinity,
                        text: 'Submit',
                        isLoading: provider.state == ProviderState.loading,
                        onPressed: onSubmit,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
