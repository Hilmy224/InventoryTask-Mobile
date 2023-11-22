import 'package:flutter/material.dart';
import 'package:catharsis_plus/models/product.dart';
import 'package:catharsis_plus/widgets/left_drawer.dart';

class DetailPage extends StatefulWidget {
    final Product item;

    const DetailPage({super.key, required this.item});

    @override
    State<DetailPage> createState() => _DetailItemPageState();
}

class _DetailItemPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Item Deets',
              ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
      drawer: const LeftDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Item Name:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.item.fields.name,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
             Text(
              'Species: ${widget.item.fields.species}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Amount: ${widget.item.fields.amount}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'spiritStatus: ${widget.item.fields.spiritStatus}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Causality: ${widget.item.fields.causeOfDeath}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Description: ${widget.item.fields.description}',
              style: const TextStyle(fontSize: 18),
            ),
            
            ElevatedButton(
              onPressed: () {
                // Navigasi kembali ketika tombol ditekan
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),            
          ],
        ),
      ),
    );
  }
}