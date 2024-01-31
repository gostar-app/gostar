import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gostar/core/utils/ui_helper.dart';
import 'package:gostar/locator.dart';
import 'package:gostar/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: space2x),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<UserProvider>(
                builder: (context, provider, child) {
                  final driver = provider.user;
                  if (driver == null) return Container();
                  return Container(
                    padding: const EdgeInsets.all(space2x),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 48,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                driver.profileImg,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: space2x.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              driver.name,
                              style: TextStyle(
                                fontSize: 16.r,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              driver.email,
                              style: TextStyle(
                                fontSize: 14.r,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: space4x.h),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () => context.push('/add-vehicle'),
                title: const Text('Add Vehicle'),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.r,
                ),
              ),
              SizedBox(height: space1x.h),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  locator<FirebaseAuth>().signOut();

                  while (context.canPop()) {
                    context.pop();
                  }
                  context.go('/sign-in');
                },
                title: const Text('Log out'),
                trailing: Icon(
                  Icons.logout,
                  size: 18.r,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
