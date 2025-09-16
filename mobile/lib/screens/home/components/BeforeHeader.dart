import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/home/components/photoClient.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import '../../../adresse.dart';
import '../../../client.dart';
import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class BeforeHeader extends StatefulWidget {
  const BeforeHeader({
    Key? key,
  }) : super(key: key);

  @override
  _BeforeHeaderState createState() => _BeforeHeaderState();
}

class _BeforeHeaderState extends State<BeforeHeader> {
  String? email;

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  final dio = Dio();

  Future<client?> getClient() async {
    if (email == null) {
      return null; // Retourne null si l'e-mail n'est pas disponible
    }

    try {
      final response = await dio
          .get('http://${Adresse.adresseIP}:5000/api/getInfosClient/$email');
      final List<dynamic> data = response.data;
      final items = data
          .map((itemJson) => client.fromJson(itemJson as Map<String, dynamic>))
          .toList();
      return items.isNotEmpty ? items[0] : null;
    } catch (e) {
      print('Failed to get client: $e');
      return null;
    }
  }

  Future<void> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<client?>(
      future: getClient(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(width: 10),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: SizedBox(width: 10),
          );
        } else {
          final client = snapshot.data;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/default.jpg",
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client != null ? "Hi, ${client.prenom}" : " ",
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                      ),
                      Text(
                        "Réservez maintenant votre centre",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  SizedBox(width: 50),
                  IconBtnWithCounter(
                    svgSrc: "assets/icons/Bell.svg",
                    numOfitem: 3,
                    press: () {},
                  ),
                  SizedBox(width: 0.5),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final Uint8List imageBytes;

  MyImageWidget({required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.memory(
        imageBytes,
        fit: BoxFit.cover,
        height: 40,
        width: 40,
      ),
    );
  }
}
