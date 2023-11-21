import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:catharsis_plus/widgets/left_drawer.dart'; // Import the previously created drawer
import 'package:catharsis_plus/widgets/shop_card.dart';
import 'package:catharsis_plus/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ShopFormPage extends StatefulWidget {
   const ShopFormPage({super.key});

   @override
   State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {
 final _formKey = GlobalKey<FormState>();
 String _name = "";
 String _type="";
 int _amount = 0;
 String _severity="";
 String _causality="";
 String _description = "";
 //add date later

 @override
 Widget build(BuildContext context) {

  final request = context.watch<CookieRequest>();
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

              //Item Name Input
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField( 
                decoration: InputDecoration(
                  hintText: "Item Name",
                  labelText: "Item Name",
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
                
              ),
            ),

            //Type Input
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField( 
                decoration: InputDecoration(
                  hintText: "Item Type",
                  labelText: "Item Type",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),

                onChanged: (String? value) {
                  setState(() {
                    _type = value!;
                  });
                },

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Type cannot be empty!";
                  }
                  return null;
                },
                
              ),
            ),
           
           //Price Input
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(

                decoration: InputDecoration(
                  hintText: "Amount",
                  labelText: "Amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),

                onChanged: (String? value) {
                  setState(() {
                    _amount = int.parse(value!);
                  });
                },

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Amount cannot be empty!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Amount must be a number!";
                  }
                  return null;
                },

                ),
              ),

            //Severity Input  
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(

              decoration: InputDecoration(
                hintText: "How Severe",
                labelText: "How Severe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),

              onChanged: (String? value) {
                setState(() {
                  _severity = value!;
                });
              },

              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Severity cannot be empty!";
                }
                return null;
              },

              ),
            ),

            //Causality Input
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField( 
                decoration: InputDecoration(
                  hintText: "How???",
                  labelText: "Causality",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),

                onChanged: (String? value) {
                  setState(() {
                    _causality = value!;
                  });
                },

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Causality cannot be empty!";
                  }
                  return null;
                },
                
              ),
            ),

            //Description Input  
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
           
           //Popup
            Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),

              child: ElevatedButton(

                style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(const Color(0xFF6C5B7B)),
                ),
                
                onPressed: () async {
                if (_formKey.currentState!.validate()) {
                    // Send request to Django and wait for the response
                    // TODO: Change the URL to your Django app's URL. Don't forget to add the trailing slash (/) if needed.
                    final response = await request.postJson(
                    "http://127.0.0.1:8000/create-flutter/",
                    jsonEncode(<String, String>{
                        'name': _name,
                        'species': _type,
                        'amount': _amount.toString(),
                        'spiritStatus': _severity,
                        'causeOfDeath': _causality,
                        'description': _description,
                        // TODO: Adjust the fields with your Django model
                    }));
                    if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                        content: Text("New product has saved successfully!"),
                        ));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                    } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content:
                                Text("Something went wrong, please try again."),
                        ));
                    }
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

