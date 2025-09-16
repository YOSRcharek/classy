import 'package:flutter/material.dart';
import 'package:shop_app/screens/seeMoreCentre/seeMoreCentre.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => seeMoreCentre()),
        );
      },
      child: Container(
        width: SizeConfig.screenWidth * 0.89,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          onChanged: (value) => print(value),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(30),
              vertical: getProportionateScreenWidth(9),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Chercher votre centre",
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
