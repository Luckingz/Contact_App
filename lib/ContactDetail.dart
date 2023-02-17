import 'package:flutter/material.dart';
import 'main.dart';

// This widget is the root of your application.
@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Contact App',
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
    home: const ContactDetail(title: 'Contact List'),
  );
}

final _searchable = [
  {'name': 'Adamu Garba', 'tel': '459584930', 'image': 'adamu_garba.jpg'},
  {'name': 'Jane Doe', 'tel': '989584930', 'image': 'jane_doe.png'},
  {'name': 'Justine Timberlake', 'tel': '659584930', 'image': 'justin.jpg'},
  {'name': 'Elon Musk', 'tel': '789584930', 'image': 'elon_musk.png'},
  {'name': 'Doge Coin', 'tel': '456787886', 'image': 'dogecoin.jpg'},
];

class ContactDetail extends StatefulWidget {
  const ContactDetail({super.key, required this.title});

  final String title;

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.addAll(_searchable);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              Icons.verified_user_outlined,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
      body: Center(
        child: Column(children: [
          Expanded(
              child: Container(
            color: Colors.amber[200],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '${items.indexedMap((element, index) => items[index]['tel'])}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.people),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
    );
  }
}
