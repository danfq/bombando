import 'package:bombando/pages/favorites.dart';
import 'package:bombando/pages/settings.dart';
import 'package:bombando/pages/sounds.dart';
import 'package:bombando/util/audio/model.dart';
import 'package:bombando/util/data/web.dart';
import 'package:bombando/widgets/audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ///List Controller
  ScrollController listController = ScrollController();

  ///Current Index
  int _navIndex = 0;

  ///Body
  Widget body() {
    switch (_navIndex) {
      //Home - Sounds
      case 0:
        return Sounds(listController: listController);

      //Favorites
      case 1:
        return const Favorites();

      //Default
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    //App
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Bombando",
          style: TextStyle(
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
            tooltip: "Definições",
            icon: const Icon(Ionicons.ios_settings_outline),
          ),
        ],
      ),
      body: SafeArea(child: body()),
      floatingActionButton: _navIndex == 0
          ? FloatingActionButton(
              child: const Icon(Ionicons.return_up_back, color: Colors.white),
              onPressed: () async {
                await listController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.bounceInOut,
                );
              },
            )
          : null,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14.0)),
        child: SalomonBottomBar(
          currentIndex: _navIndex,
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          onTap: (index) {
            setState(() {
              _navIndex = index;
            });
          },
          items: [
            //Home
            SalomonBottomBarItem(
              icon: const Icon(Feather.volume_2),
              title: const Text("Início"),
            ),

            //Favorites
            SalomonBottomBarItem(
              icon: const Icon(Feather.star),
              title: const Text("Favoritos"),
            ),
          ],
        ),
      ),
    );
  }
}
