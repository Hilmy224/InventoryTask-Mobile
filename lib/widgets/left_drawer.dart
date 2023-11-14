import 'package:catharsis_plus/screens/item_display.dart';
import 'package:flutter/material.dart';
import 'package:catharsis_plus/screens/menu.dart';
import 'package:catharsis_plus/screens/shoplist_form.dart';
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
  decoration: BoxDecoration(
    color: Colors.redAccent,
  ),
  child: Column(
    children: [
      Text(
        'Cartharsis+',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Padding(padding: EdgeInsets.all(10)),
      Text(
            "Release all the stress",
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontSize: 15, 
              color: Colors.white, 
              fontWeight: FontWeight.normal, 
            ),
            ),
    ],
  ),
),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home Page'),
            // redirect to MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Add Item'),
            // redirect to ShopFormPage
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopFormPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.category_rounded),
            title: const Text('View Items'),
            // redirect to ShopFormPage
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Itemvault(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}