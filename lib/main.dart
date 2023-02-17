import 'package:flutter/material.dart';
import 'package:contact_app/ContactDetail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Contact App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(),
    );
  }
}

// An Interable extension for the Map containing the various users
extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> indexedMap<T>(T Function(E element, int index) f) {
    var index = 0;
    return map((e) => f(e, index++));
  }
}

//Nesting a Map in a List
final _searchable = [
  {'name': 'Adamu Garba', 'tel': '459584930', 'image': 'adamu_garba.jpg'},
  {'name': 'Jane Doe', 'tel': '989584930', 'image': 'jane_doe.png'},
  {'name': 'Justine Timberlake', 'tel': '659584930', 'image': 'justin.jpg'},
  {'name': 'Elon Musk', 'tel': '789584930', 'image': 'elon_musk.png'},
  {'name': 'Doge Coin', 'tel': '456787886', 'image': 'dogecoin.jpg'},
];

var items = [];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text('${_searchable.length.toString()} Contacts'),
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  prefix: Icon(Icons.search),
                  labelText: 'Search',
                  hintText: 'Enter the name of the contact',
                ),
                onChanged: (value) {
                  filterContact(value.toLowerCase());
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: ((context, index) {
                  return new Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactDetail(
                                      title: '${items[index]['name']}',
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(9),
                        padding: EdgeInsets.all(6),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: Text('${items[index]['image']}'),
                              backgroundImage:
                                  AssetImage('assets/${items[index]['image']}'),
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.all(6),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${items[index]['name']}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${items[index]['tel']}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        child: new Icon(Icons.people),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
    );
  }

  var result = items.indexedMap((element, index) => items);

  void filterContact(String searchTerm) {
    var tmpSearchList = [];

    tmpSearchList.addAll(_searchable);
    if (searchTerm.isNotEmpty) {
      List<Map<String, dynamic>> tmpList = [];
      tmpSearchList.forEach((element) {
        if (element['name'].toLowerCase().contains(searchTerm.trim())) {
          tmpList.add(element);
          print(element);
        }
        ;
      });

      setState(() {
        items.clear();
        items.addAll(tmpList);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(_searchable);
      });
    }
  }
}
