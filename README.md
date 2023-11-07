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
[insert image]

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
