import 'package:e_commerce_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60.h,
                        child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            fillColor: Colors.red,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText: "Search products here",
                            hintStyle: TextStyle(fontSize: 15.sp),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        height: 60.h,
                        width: 50.w,
                        color: AppColors.deepOrange,
                        child: const Center(
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
