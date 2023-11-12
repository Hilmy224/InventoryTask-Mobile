# Week 07
## Setup Flutter
### 1) Creating an App and organizing
Pertama untuk membuat sebuah applikasi flutter dalam terminal `flutter create <APP_NAME>` lalu ke direktorinya dengan `cd <APP_NAME>`. Setelah itu, anda ingin membuat sebuah `menu.dart` file dalam folder `<APP_NAME>/lib`. Isi file tersebut sbb:
```dart
import 'package:flutter/material.dart';

//Dari dalam file main.dart pindahkan  isi dari line 39- akhir agar didalam menu.dart ada class berikut:

class MyHomePage ... {
    ...
}

class _MyHomePageState ... {
    ...
}
```

>Jangan lupa untuk import `import 'package:<APP_NAME>/menu.dart';` dalam `main.dart`

### 2) Widget Making

Pertama kita akan buat sebuah class untuk sebuah `StoreItem`:
```dart
class StoreItem {
  final String name;
  final IconData icon;
  final Color color;

  StoreItem(this.name, this.icon, this.color);

  //Change the colour
  static final StoreItem lihatItem = StoreItem("Lihat Item", Icons.checklist, Color(0xFFC06C84));
  static final StoreItem tambahItem = StoreItem("Tambah Item", Icons.add_box, Color(0xFF6C5B7B));
  static final StoreItem logout = StoreItem("Logout", Icons.accessible_forward_sharp, Color(0xFF355C7D));
}
```
Lalu kita akan buat tampilan cards yang bernama `shopcard` yang  extends Stateless widget(they don't change anything but pixels).

```dart
class ShopCard extends StatelessWidget {
  final StoreItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
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
```

Terakhir dalam `myHomePage` ada beberapa yang harus ditambah dan diubah 
+ Ubah `({super.key, required this.title})` dg `({Key? key}) : super(key: key);`
+ Dalam class tersebut buat list of Shop items, ex:
```
final List<StoreItem> items = [
      StoreItem.lihatItem, // Use the predefined instances with different colors
      StoreItem.tambahItem,
      StoreItem.logout,
  ];
```
+ Ubah `final String title` dengan widget build method yang berisi sebagi berikut:
```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CatharsisPlus',
        ),
      ),
      backgroundColor: Color(0xFFF67280),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Vault',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((StoreItem item) {
                  // Iterasi untuk setiap item
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
+ Di dalam `main.dart` file ubah `MyHomePage(title: 'Flutter Demo Home Page')` agar menjadi `MyHomePage()` ex hasil:
```dart
home: MyHomePage(),
```

### 3) Result
![image](https://github.com/Hilmy224/InventoryTask-Mobile/assets/108089955/365c9f88-cf55-476a-b6a6-af2f5cbf6572)


## Diffrence between stateless and statefull widget in Flutter
__Stateless widgets__ adalah widget yang tidak berubah, artinya properti mereka tidak dapat berubah setelah diatur. Mereka tidak memiliki keadaan internal yang harus dikelola. Mereka tidak bergantung pada data eksternal atau masukan pengguna, dan mereka tidak mengubah penampilan atau perilaku mereka dari waktu ke waktu. Contoh dari stateless widgets meliputi `Text`, `Icon`, `IconButton`, dan `RaisedButton`.

Di sisi lain, __Stateful widgets__ adalah widget yang dapat berubah, artinya properti mereka dapat dimodifikasi setelah widget dibuat. Mereka memiliki keadaan internal yang dapat berubah dari waktu ke waktu, baik sebagai respons terhadap interaksi pengguna atau saat mereka menerima data. Contoh dari stateful widgets meliputi `Checkbox`, `Radio`, `Slider`, `InkWell`, `Form`, dan `TextField`.

## Widget Used and it's function
+ `Scaffold`: Widget ini menyediakan kerangka kerja yang mengimplementasikan struktur tata letak visual Material Design dasar. Ini menyediakan API untuk menampilkan laci, snack bar, dan lembaran bawah.
+ `AppBar`: Widget ini adalah app bar Material Design. Ini sering digunakan untuk menampilkan judul, tindakan, dan widget pengantar.
+ `SingleChildScrollView`: Widget ini adalah kotak yang dapat digulirkan. Ini sering digunakan ketika kontennya terlalu besar untuk muat di layar.
+ `Material`: Ini adalah widget yang menangani sejumlah fitur Material Design yang berbeda. Ini menyediakan tema, percikan tinta, dan tata letak ke widget anaknya. Ini sering digunakan sebagai widget root dalam aplikasi Flutter.
+ `InkWell`: Widget ini merespons acara sentuhan. Ini dapat mendeteksi ketukan, ketukan ganda, tekan lama, dan gerakan lainnya. Ini sering digunakan untuk membuat tombol atau elemen interaktif lainnya.
+ `Container`: Ini adalah widget kenyamanan yang menggabungkan widget gambaran umum, penempatan, dan penentuan ukuran. Ini sering digunakan untuk membuat elemen visual berbentuk persegi panjang dengan warna, lebar, tinggi, dan widget anak tertentu.
+ `GridView`: Widget ini adalah array 2D yang dapat digulirkan dari widget. Ini sering digunakan untuk menampilkan kumpulan item dalam bentuk grid.
+ `Center`: Widget ini memusatkan widget anaknya di dalamnya. Ini sering digunakan untuk memusatkan widget lain.
+ `Column`: Widget ini menyusun anak-anaknya dalam larik vertikal. Ini sering digunakan untuk menyusun widget secara vertikal.
+ `Icon`: Widget ini menampilkan ikon. Ini sering digunakan untuk menampilkan ikon dalam antarmuka pengguna.
+ `Text`: Widget ini menampilkan string teks dengan gaya tunggal. Ini sering digunakan untuk menampilkan teks dalam antarmuka pengguna.
+ `Padding`: Widget ini memberikan jarak di sekitar widget anaknya sesuai dengan jarak yang diberikan. Ini sering digunakan untuk menciptakan ruang di sekitar widget lain.


# Week 08
## Refactoring File
Buat struktur dalam direktori `lib` sebagai berikut:
```
lib
|___screens
|   |___menu.dart
|   |___shoplist_form.dart
|
|___widgets
|   |___left_drawer.dart
|   |___shop_card.dart
|
|___main.dart
```

>Buat file `shoplist_form.dart`,`shop_card.dart` dan `left_drawer.dart` jika belum ada
> Pastikan Import yang dilakukan sesuai dengan path


## Left Drawer Widget 
### 1) Widget Making
This will be a left drawer thats available on all the screens to do that we use the `Drawer` widget like the following:
```dart
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
        ],
      ),
    );
  }
}
```

> Pastikan  import  `menu.dart` dan `shoplist_form.dart` dari `screens` agar dapat menampilkan halaman ketika tombol yang di dalam left drawer tersebut dapat ke halaman tampilan  yang sesuai

### 2) Connecting
Di dalam `menu.dart` dan `shoplist_form.dart` pastikan saat ngebuild  didalam `scaffold` ditambahkan `LeftDrawer` sebagai berikut:
```dart
return Scaffold(

    ....
    
    drawer: const LeftDrawer(),
    );
    
## Form Page


```

### Form making
### 1) Import and create state for the page
```dart
import 'package:flutter/material.dart';
import 'package:catharsis_plus/widgets/left_drawer.dart'; // Import the previously created drawer

class ShopFormPage extends StatefulWidget {
   const ShopFormPage({super.key});

   @override
   State<ShopFormPage> createState() => _ShopFormPageState();
}
```

### 2) Form Values
Didalam `_ShopFormPageState` tambahkan:
```dart
class _ShopFormPageState extends State<ShopFormPage> {
final _formKey = GlobalKey<FormState>();
 String _name = "";
 int _amount = 0;
 String _severity="";
 String _description = "";
 
 ...

}
```
### 3) ShopFormPage UI
Untuk tampilan dapat dibuat sebagai berikut:
```dart
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
                          Text('Harga: $_amount'),
                          Text('Severity: $_severity'),
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
```

## ShopCard Placing
> Buat sebuah file bernama `shop_card.dart` dan isinya dengan class `StoreItem` dan class `ShopCard` dari `menu.dart` sebelumnya dan pastikan import yang sesuai agar penggantian halaman bekerja

## LeftDrawer and ShopForm Result
![image](https://github.com/Hilmy224/InventoryTask-Mobile/assets/108089955/a1dfc447-5d52-4541-9c9e-a24378c45359)


## Diffrence Between `Navigator.push()` and `Navigator.pushReplacement()`
and example

## Clean Architecture in flutter
Implementation

## Element Input on the Form that is used and Why?

## _Layout_ Widget that are Used


