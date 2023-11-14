import 'package:flutter/material.dart';
import 'package:catharsis_plus/widgets/left_drawer.dart'; // Import the previously created drawer
import 'package:catharsis_plus/widgets/shop_card.dart';

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
                
                onPressed: () {
                if (_formKey.currentState!.validate()) {
                  //Save it
                  setState(() {
                    savedItems.add(Item(_name,_type,_amount,_severity,_causality,_description));
                  });
                  
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
                          Text('Type: $_type'),
                          Text('Harga: $_amount'),
                          Text('Severity: $_severity'),
                          Text('Cause: $_causality'),
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

