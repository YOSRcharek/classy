import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/joursMenu.dart';
import 'package:shop_app/screens/reservation/components/calendrier.dart';
import 'package:shop_app/screens/reservation/components/prestation.dart';
import 'package:shop_app/screens/seeMoreCentre/seeMoreCentre.dart';

import '../../../adresse.dart';
import '../../../client.dart';
import '../../../components/categories_menu.dart';
import '../../../size_config.dart';

final dio = Dio();

class Body extends StatefulWidget {
  final String nomService;
  final String nomCentre;
  final int refCentre;
  final int? CIN;

  Body({
    Key? key,
    required this.refCentre,
    required this.nomService,
    required this.nomCentre,
    this.CIN,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int? selectedCIN = 0;
  String? email;

  @override
  void initState() {
    super.initState();
    getEmail();
    print("hettt CIN ");
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

  Future<void> insert(DateTime param1, int param2, int param3) async {
    if (param2 == null) {
      param2 = 0;
    }
    final DateTime formattedDateTime = DateTime.utc(
      param1.year,
      param1.month,
      param1.day,
      param1.hour,
      param1.minute,
      param1.second,
    );
    DateTime selectDateTime =
        DateTime.parse(formattedDateTime.toString().replaceAll(' ', 'T'));
    print(selectDateTime);

    try {
      final response = await dio.post(
        'http://${Adresse.adresseIP}:5000/api/addResvPerso',
        data: {
          'nomService': widget.nomService,
          'nomSalon': widget.nomCentre,
          'selectedTime': selectDateTime.toIso8601String(),
          'cinClient': param3,
          'cinPersonnel': param2,
        },
      );
      print(param2);
      print('Insert success');
    } catch (err) {
      print(err);
      print('Insert failed');
    }
  }

  void handleResv(DateTime param1, int cin) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      title: 'Confirmation',
      text: 'Vous etes sur de confirmer votre rendez-vous ?',
      confirmBtnText: 'Oui',
      cancelBtnText: 'Non',
      onConfirmBtnTap: () {
        insert(param1, selectedCIN!, cin);
      },
      onCancelBtnTap: () {
        print('Cancelled');
      },
    );
  }

  void onChangeCIN(int? cin, String? duree) {
    setState(() {
      selectedCIN = cin;
      duree = duree;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
        title: const Text(
          "Prendre RDV",
          style: TextStyle(
            color: Color.fromARGB(255, 15, 15, 15),
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: Color.fromARGB(67, 236, 236, 236),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(25),
                    vertical: getProportionateScreenWidth(6),
                  ),
                  child: Text(
                    widget.nomCentre,
                    style: TextStyle(
                        fontSize: 20, fontFamily: "Times", color: Colors.black),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(25),
                    right: getProportionateScreenWidth(64),
                  ),
                  child: const Text(
                    "1. Prestation sélectionnée",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Robot",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          prestation(
            refCentre: widget.refCentre,
            nomService: widget.nomService,
            nomCentre: widget.nomCentre,
            onChangeCIN: (cin, duree) => onChangeCIN(cin, duree),
          ),
          SizedBox(height: 12),
          Container(
            color: const Color.fromARGB(100, 236, 236, 236),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(25),
                    right: getProportionateScreenWidth(64),
                  ),
                  child: const Text(
                    "2. Choix de la date & heure",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Robot",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder<client?>(
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
                        return Calendrier(
                          onReservation: (param1) =>
                              handleResv(param1, client!.CIN),
                          nomService: widget.nomService,
                          nomCentre: widget.nomCentre,
                          refCentre: widget.refCentre,
                        );
                      }
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
