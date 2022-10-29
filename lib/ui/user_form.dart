import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/const/app_colors.dart';
import 'package:e_commerce_app/ui/bottom_nav_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _dateofBirthController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        _dateofBirthController.text =
            "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  storeUserData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('user-form-data');
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "name": _nameController.text,
          "phone": _phoneNumberController.text,
          "dob": _dateofBirthController.text,
          "gender": _genderController.text,
          "age": _ageController.text,
        })
        .then((value) => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const BottomNavController())))
        .catchError((error) => print("Something went wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Submit the form to continue',
                  style: TextStyle(
                    color: AppColors.deepOrange,
                    fontSize: 25.sp,
                  ),
                ),
                Text(
                  'Those information will be private',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 15.h),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: _dateofBirthController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Date of Birth',
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Gender',
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                    suffixIcon: DropdownButton(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    hintText: 'Age',
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 100.h),
                SizedBox(
                  width: 1.sw,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: storeUserData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepOrange,
                      elevation: 3,
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
