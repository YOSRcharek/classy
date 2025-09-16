import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../adresse.dart';
import '../../../size_config.dart';
import '../autrePrestation.dart';

final dio = Dio();

class prestation extends StatelessWidget {
  final Function(int, String) onChangeCIN;
  prestation({
    Key? key,
    required this.refCentre,
    required this.nomService,
    required this.nomCentre,
    required this.onChangeCIN,
    this.pressOnSeeMore,
  }) : super(key: key);
  final GestureTapCallback? pressOnSeeMore;
  final int refCentre;
  final String nomService;
  final String nomCentre;
  late String selectedPerso = '';
  String formatDuration(String duration) {
    final parts = duration.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    final seconds = int.parse(parts[2]);

    if (hours > 0) {
      return '$hours h';
    } else if (minutes > 0) {
      return '$minutes min';
    } else {
      return '$seconds s';
    }
  }

  void updateSelectedPersonnel(String? personnel) {
    setState(() {
      selectedPerso = personnel!;
      print(selectedPerso);
    });
  }

  Future<List<dynamic>> getItem() async {
    try {
      final response = await dio.get(
        'http://${Adresse.adresseIP}:5000/api/getDetailsServiceMobile',
        data: {
          'refCentre': refCentre,
          'nomService': nomService,
        },
      );
      final dynamic data = response.data;
      print(data);
      if (data != null) {
        return data as List<dynamic>;
      } else {
        throw Exception('No data available.');
      }
    } catch (e) {
      throw Exception('Failed to get item: $e');
    }
  }

  Future<List<dynamic>> getItems() async {
    try {
      final response = await dio.get(
        'http://${Adresse.adresseIP}:5000/api/getAllpersonnelResv',
        queryParameters: {
          'nomCentre': nomCentre,
          'nomService': nomService,
        },
      );
      final dynamic data = response.data;
      print(data);
      if (data != null) {
        return data as List<dynamic>;
      } else {
        throw Exception('No data available.');
      }
    } catch (e) {
      throw Exception('Failed to get item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getItem(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No salon data available');
        } else {
          final services = snapshot.data!;
          final serviceItem = services[0];
          return afficherDonneesPrestation(
              context, serviceItem, updateSelectedPersonnel);
        }
      },
    );
  }

  void setState(VoidCallback callback) {}

  Widget afficherDonneesPrestation(BuildContext context, dynamic serviceItem,
      Function(String?) updateSelectedPersonnel) {
    final String nomService = serviceItem['nomService'];
    final String duree = serviceItem['duree'];
    final int prix = serviceItem['prix'];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(25),
            right: getProportionateScreenWidth(64),
            top: getProportionateScreenWidth(5),
          ),
          child: Wrap(
            spacing: 5,
            children: [
              Text(
                nomService,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: "Roboto",
                  color: Colors.black,
                ),
              ),
              Icon(Icons.schedule_outlined, size: 13),
              SizedBox(width: 1),
              Text(
                '${formatDuration(duree)}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: "Roboto",
                ),
              ),
              SizedBox(width: 4),
              const Icon(Icons.monetization_on_outlined, size: 13),
              SizedBox(width: 1),
              Text(
                '$prix D',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(25),
          right: getProportionateScreenWidth(64),
          top: getProportionateScreenWidth(1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Personnel(
                      context,
                      nomService,
                      duree,
                      nomCentre,
                      updateSelectedPersonnel), // Passer la fonction de rappel
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              child: const Row(
                children: [
                  Text(
                    "Choisir avec qui",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      Container(
        color: const Color.fromARGB(100, 236, 236, 236),
        child: Padding(
            padding: EdgeInsets.all(0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AutrePrestation(
                      nomService: nomService,
                      nomCentre: nomCentre,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(174, 0, 0, 0),
                onPrimary: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 14,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Ajouter une autre prestation",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            )),
      ),
    ]);
  }

  Widget Personnel(BuildContext context, String nomService, String duree,
      String nomCentre, Function(String? p1) updateSelectedPersonnel) {
    String? selectedPersonnel;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<dynamic>>(
            future: getItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                final etablis = snapshot.data as List<dynamic>?;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int index = 0; index < etablis!.length + 1; index++)
                        ListTile(
                          title: index == 0
                              ? const Text(
                                  'Sans préférence',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 15, 15, 15),
                                    fontSize: 14,
                                  ),
                                )
                              : Text(
                                  etablis[index - 1]['persoName'],
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 15, 15, 15),
                                    fontSize: 14,
                                  ),
                                ),
                          onTap: () {
                            selectedPersonnel = index == 0
                                ? 'Sans préférence'
                                : etablis[index - 1]['persoName'];
                            setState(() {
                              int CIN = etablis[index - 1]['CIN'] ?? 0;
                            });
                            int CIN = etablis[index - 1]['CIN'] ?? 0;
                            if (CIN == null) {
                              int CIN = 0;
                            } else {
                              int CIN = etablis[index - 1]['CIN'] ?? 0;
                            }
                            onChangeCIN(CIN, duree);

                            updateSelectedPersonnel(selectedPersonnel);

                            Navigator.pop(context, selectedPersonnel);
                          },
                        ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
