import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'dart:async';
import '../../adresse.dart';
import '../../models/Cart.dart';
import '../../salon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../size_config.dart';
import '../Carte/carte.dart';
import '../details/components/custom_app_bar.dart';

final dio = Dio();

Future<List<dynamic>> getTel(reference) async {
  try {
    final response =
        await dio.get('http://${Adresse.adresseIP}:5000/api/getTel/$reference');
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

Future<List<dynamic>> getHoraires(reference) async {
  try {
    final response = await dio
        .get('http://${Adresse.adresseIP}:5000/api/heureCalendrier/$reference');
    final List<dynamic> data = response.data;
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

void launchPhoneCall(String phoneNumber) async {
  String url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

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

class seeMoreCentreCopy extends StatefulWidget {
  final String text;

  const seeMoreCentreCopy({Key? key, required this.text}) : super(key: key);

  @override
  _seeMoreCentreCopyState createState() => _seeMoreCentreCopyState();
}

class _seeMoreCentreCopyState extends State<seeMoreCentreCopy>
    with TickerProviderStateMixin {
  Future<List<salon>> getItems() async {
    try {
      print(widget.text);
      final response = await dio.get(
          'http://${Adresse.adresseIP}:5000/api/getAllTypes/${widget.text}');

      final List<dynamic> data = response.data;
      final items = data
          .map((itemJson) => salon.fromJson(itemJson as Map<String, dynamic>))
          .toList();
      print(items);
      return items;
    } catch (e) {
      throw Exception('Failed to get items: $e');
    }
  }

  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();
  List<salon> _salons = []; // Liste de tous les salons
  List<salon> _searchResults = []; // Liste des résultats de recherche
  void _loadSalons() async {
    // Charger les salons depuis l'API ou toute autre source de données
    List<salon> salons = await getItems();
    setState(() {
      _salons = salons;
    });
  }

  void _performSearch(String value) {
    setState(() {
      if (value.isNotEmpty) {
        // Filtrer les salons en fonction de la valeur saisie
        _searchResults = _salons.where((salon) {
          // Vous pouvez personnaliser la logique de recherche ici
          return salon.nom.toLowerCase().contains(value.toLowerCase());
        }).toList();
      } else {
        _searchResults = _salons; // Afficher tous les centres
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadSalons(); // Charger les salons initialement
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 3,
            bottom: TabBar(
              indicatorColor: Colors.black,
              indicatorWeight: 1,
              tabs: [
                Tab(
                  child: Text('Résultats',
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ),
                Tab(
                  child: Text('Carte',
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ),
              ],
              controller: _tabController,
            ),
            title: const Text(
              "CLASSY",
              style: TextStyle(
                  color: Color.fromARGB(255, 15, 15, 15), fontSize: 14),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 14,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: TabBarView(
          children: [
            buildPageRes(MediaQuery.of(context).size.width),
            buildPageCart(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  Widget buildPageCart() => Scaffold(body: CartePage());
  Widget buildPageRes(width) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: (value) => _performSearch(value),
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
                  const SizedBox(height: 5),
                  if (_searchResults.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) =>
                          salon2Card(_searchResults[index], index, () {
                        Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: salonDetailsArguments(
                            reference: _searchResults[index].reference,
                            nomCentre: _searchResults[index].nom,
                          ),
                        );
                      }, _tabController),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                    )
                  else if (_searchController.text.isNotEmpty)
                    const Center(
                      child: Text('Aucun centre trouvé.'),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _salons.length,
                      itemBuilder: (context, index) =>
                          salon2Card(_salons[index], index, () {
                        Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: salonDetailsArguments(
                            reference: _salons[index].reference,
                            nomCentre: _salons[index].nom,
                          ),
                        );
                      }, _tabController),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
}

Widget salon2Card(salon salon, int index, tap, TabController tabController) {
  return GestureDetector(
    onTap: tap,
    child: Container(
      height: 169, // Adjust the height according to your needs
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyImageWidget(imageBytes: salon.src),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      salon.nom,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(salon.type),
                    CustomAppBar(rating: 4.5),
                    Fermeture(salon),
                    Row(
                      children: [
                        cardButtonsApp(salon),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget cardButtonsApp(salon salon) {
  return Padding(
    padding: const EdgeInsets.only(left: 5),
    child: ElevatedButton(
      onPressed: () async {
        try {
          final salons = await getTel(salon.reference);
          final phoneNumber = salons[0]['tel'].toString();
          print(phoneNumber);
          launchPhoneCall(phoneNumber);
        } catch (e) {
          print('Error: $e');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(6),
        minimumSize: Size.zero,
      ),
      child: const Row(
        children: [
          Icon(
            Icons.call,
            color: Colors.black,
            size: 13,
          ),
          SizedBox(width: 1),
          Text(
            "Appeler",
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
        ],
      ),
    ),
  );
}

Widget Fermeture(salon) {
  return FutureBuilder(
      future: getHoraires(salon.reference),
      builder: (context, snapshot) {
        final horaires = snapshot.data;
        final fermeture = horaires?[0]['fermeture'];

        if (fermeture == null) {
          return const Text('Fermé');
        } else {
          return Text(
            "Se ferme à ${formatDuration(fermeture)}",
            style: TextStyle(color: const Color.fromARGB(255, 216, 26, 8)),
          );
        }
      });
}

class Indicator extends StatelessWidget {
  const Indicator({Key? key, required this.isActive}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white54,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final Uint8List imageBytes;

  MyImageWidget({required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      imageBytes,
      fit: BoxFit.cover,
      height: 193,
      width: 140,
    );
  }
}
