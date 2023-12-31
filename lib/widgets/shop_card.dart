import 'package:catharsis_plus/screens/item_display.dart';
import 'package:catharsis_plus/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:catharsis_plus/screens/shoplist_form.dart';
import 'package:catharsis_plus/screens/item_display.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class StoreItem {
  final String name;
  final IconData icon;
  final Color color;

  StoreItem(this.name, this.icon, this.color);

  //Change the colour
  //0xFFC06C84,0xFF6C5B7B,0xFF355C7D
  static final StoreItem lihatItem = StoreItem("Lihat Item", Icons.checklist,  Color(0xFF6C5B7B));
  static final StoreItem tambahItem = StoreItem("Tambah Item", Icons.add_box,  Color(0xFF6C5B7B));
  static final StoreItem logout = StoreItem("Logout", Icons.accessible_forward_sharp,  Color(0xFF6C5B7B));
}

//Add a class for items
class Item{
  String name="";
  String type="";
  int amount=0;
  String severity="";
  String causality="";
  String description="";

  Item(this.name,this.type,this.amount,this.severity,this.causality,this.description);
}

//Make an instance of it
List<Item> savedItems=[];

class ShopCard extends StatelessWidget {
  final StoreItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
     final request = context.watch<CookieRequest>();
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
          // Navigate to the appropriate route (depending on the button type)
          if (item.name == "Tambah Item") {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopFormPage(),
                  ));
          }
          else if (item.name == "Lihat Item") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Itemvault(),
                ));
          }
          else if (item.name == "Logout") {
        final response = await request.logout(
            // TODO: Change the URL to your Django app's URL. Don't forget to add the trailing slash (/) if needed.
            "http://127.0.0.1:8000/auth/logout/");
        String message = response["message"];
        if (response['status']) {
          String uname = response["username"];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("$message Good bye, $uname."),
          ));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("$message"),
          ));
        }
      }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}