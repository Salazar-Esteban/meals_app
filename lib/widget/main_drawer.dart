import 'package:flutter/material.dart';

enum DrawerScreenIdentifiers { filters, meals }

class MainDrawer extends StatelessWidget {
  const MainDrawer({required this.selectScreen, super.key});
  final void Function(DrawerScreenIdentifiers identifier) selectScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black45,
      child: Column(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fastfood_outlined,
                    color: Colors.orangeAccent,
                    size: 30,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Cooking up !!',
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
          ),
          ListTile(
            onTap: () => selectScreen(DrawerScreenIdentifiers.filters),
            leading: const Icon(Icons.filter_list_alt),
            title: const Text(
              'Filters',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () => selectScreen(DrawerScreenIdentifiers.meals),
            leading: const Icon(Icons.restaurant_outlined),
            title: const Text(
              'Meals',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
