import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
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
  final List<String> _carouselImages = [];
  final List _products = [];
  var _dotPosition = 0;
  final _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection('carousel-slider').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(qn.docs[i]['img-path']);
      }
    });
    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection('products').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: SafeArea(
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
                          fillColor: Colors.white,
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
            SizedBox(height: 15.h),
            AspectRatio(
              aspectRatio: 2.5,
              child: CarouselSlider(
                items: _carouselImages
                    .map((item) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(item),
                                fit: BoxFit.fitWidth),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: false,
                    viewportFraction: 0.85,
                    aspectRatio: 0.5,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, CarouselPageChangedReason) {
                      setState(() {
                        _dotPosition = val;
                      });
                    }),
              ),
            ),
            SizedBox(height: 5.h),
            DotsIndicator(
              dotsCount: _carouselImages.isEmpty ? 1 : _carouselImages.length,
              position: _dotPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColors.deepOrange,
                color: AppColors.deepOrange.withOpacity(0.5),
                spacing: const EdgeInsets.all(2),
                activeSize: const Size.square(8),
                size: const Size.square(6),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Products",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.deepOrange,
                    ),
                  ),
                  Text(
                    "View All >",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.36,
                            child: Image.network(
                              _products[index]['product-img'][0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(_products[index]['product-name']),
                          Text(_products[index]['product-price'].toString()),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
