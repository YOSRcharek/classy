import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'BeforeHeader.dart';
import 'categories.dart';
import 'home_header.dart';
import 'icon_btn_with_counter.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(20)),
            BeforeHeader(),
            SizedBox(height: getProportionateScreenHeight(10)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(15)),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Categories(),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
