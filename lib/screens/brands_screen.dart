import 'dart:ffi';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../contants.dart';
import '../controllers/Brand_controller.dart';
import '../models/brand.dart';
import 'coupons_screen.dart';

class BrandsScreen extends StatelessWidget {
  final brandController = Get.put(BrandController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brands'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: brandController.brands.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 /3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                      () => CouponsScreen(brandId: brandController.brands[index].id, brandName: brandController.brands[index].name),
                  preventDuplicates: false,
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/30,
                    ),
                    Container(
                      width: 100,
                      child: Image.network(
                        url + brandController.brands[index].image,
                        fit: BoxFit.fill,
                        width: 100,
                        height: 70,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text(
                          brandController.brands[index].name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10,),
                        Text(brandController.brands[index].couponsCount.toString() + ' Coupons'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BrandForAllBrandsItem extends StatelessWidget {
  late final Brand brand;

  BrandForAllBrandsItem(this.brand);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.2),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            width: 100,
            child: Image.network(
              url + brand.image,
              fit: BoxFit.fill,
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                brand.name,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(brand.couponsCount.toString() + ' Coupons'),
            ],
          ),
        ],
      ),
    );
  }
}

class BrandItem extends StatelessWidget {
  const BrandItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 120,
        color: Colors.white,
      ),
      elevation: 0,
    );
  }
}
