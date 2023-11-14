import 'package:catharsis_plus/widgets/shop_card.dart';
import 'package:flutter/material.dart';
import 'package:catharsis_plus/widgets/left_drawer.dart';


class Itemvault extends StatefulWidget {
  const Itemvault({super.key});
  @override
  State<Itemvault> createState() => _ItemVault();
}

class _ItemVault extends State<Itemvault> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Vault',
          ),
        ),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: savedItems.length,
                itemBuilder: (BuildContext context, int id) {
                  return ListTile(
                      title: Text(
                        "${id + 1}. ${savedItems[id].name}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Container(
                        margin: const EdgeInsets.only(left: 22.0),
                        child: Text(
                          """
                          Type: ${savedItems[id].type}
                          Amount: ${savedItems[id].amount}
                          Severity: ${savedItems[id].severity}
                          Causality: ${savedItems[id].causality}
                          Description: ${savedItems[id].description}
                          """,
                          textAlign: TextAlign.left,
                        ),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}