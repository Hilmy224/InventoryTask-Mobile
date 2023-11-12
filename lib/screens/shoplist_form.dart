import 'package:flutter/material.dart';
import 'package:catharsis_plus/widgets/left_drawer.dart'; // Import the previously created drawer

class ShopFormPage extends StatefulWidget {
   const ShopFormPage({super.key});

   @override
   State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {
 final _formKey = GlobalKey<FormState>();
 String _name = "";
 int _price = 0;
 String _description = "";

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Center(
         child: Text(
           'Add Item Form',
         ),
       ),
       backgroundColor: Color(0xFF6C5B7B),
       foregroundColor: Colors.white,
     ),
     drawer: const LeftDrawer(),
     backgroundColor: const Color(0xFFF67280), // Add the previously created drawer here
     body: Form(
       key: _formKey,
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Product Name",
              labelText: "Product Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onChanged: (String? value) {
              setState(() {
                _name = value!;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Name cannot be empty!";
              }
              return null;
            },
          ),),
           
           Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextFormField(
    decoration: InputDecoration(
      hintText: "Price",
      labelText: "Price",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    onChanged: (String? value) {
      setState(() {
        _price = int.parse(value!);
      });
    },
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return "Price cannot be empty!";
      }
      if (int.tryParse(value) == null) {
        return "Price must be a number!";
      }
      return null;
    },
  ),
),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextFormField(
    decoration: InputDecoration(
      hintText: "Description",
      labelText: "Description",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    onChanged: (String? value) {
      setState(() {
        _description = value!;
      });
    },
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return "Description cannot be empty!";
      }
      return null;
    },
  ),
),
           
           Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color(0xFF6C5B7B)),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Product successfully saved'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text('Name: $_name'),
                  Text('Harga: $_price'),
                  Text('Deskripisi: $_description'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  _formKey.currentState!.reset();
                },
              ),
            ],
          );
        },
      );
        }
      },
      child: const Text(
        "Save",
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
),
           ],
         ),
       ),
     ),
   );
 }
}

