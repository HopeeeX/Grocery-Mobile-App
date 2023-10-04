// ignore_for_file: prefer_final_fields,, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class GroceryApp extends StatefulWidget {
  const GroceryApp({super.key});

  @override
  StatefulElement createElement() {
    print('body CREATEELEMENT called');
    return super.createElement();
  }

  @override
  State<GroceryApp> createState() {
    return _UIUpdatesDemo();
  }
}

class _UIUpdatesDemo extends State<GroceryApp> {
  List<Map<String, dynamic>> allItems = [
    {'id':1, 'title': 'apple'},
    {'id':2, 'title': 'orange'},
    {'id':3, 'title': 'banana'},
  ];

  

  @override
  Widget build(BuildContext context) => SafeArea (
    child: Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 19)),
            Container(
              child: buildTitle()),
            const Padding(padding: EdgeInsets.only(top: 36)),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildItemTitle(),
                  const Padding(padding: EdgeInsets.only(right: 14)),
                  buildItemNumber(),
                  const Padding(padding: EdgeInsets.only(right: 14)),
                  buildAddItem()
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: buildSortButton(),
            ),
            const Padding(padding: EdgeInsets.only(top: 9)),
            Container(
              width: 385,
              height: 300,
              child: buildList(),
            )
          ],
        ) ),
    ),
  );


Widget buildTitle() => const Text(
  'Grocery List',
  style: TextStyle(
    color: Colors.grey,
    fontFamily: 'Montserrat', fontSize: 45,
    
  )
);

Widget buildItemTitle() => const SizedBox(
  width: 192,
  height: 35,
  child: TextField(
    decoration: InputDecoration(
      hintText: 'Title...',
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
    ),
  ),
);

Widget buildItemNumber() => const SizedBox(
  width: 64,
  height: 35,
  child: TextField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(),
    ),
  ),
);

Widget buildAddItem() => SizedBox(
  width: 101,
  height: 35,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: const Color(0xFF00FFFFFF),
      side: const BorderSide(
        color: Color(0xFFFFD700)
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
    ),
    onPressed: () {},
    child: const Text('Add',
    style: TextStyle(
      color: Color(0xFFFFD700),
    )
    )),
  
);

Widget buildSortButton() => IconButton( 
  padding: EdgeInsets.only(right: 35.67, top: 12),
  onPressed: (){}, 
  icon: Image.asset('../assets/icons/union.png')
);

Widget buildList() => Container(
  child: Expanded(
    child: ListView.builder(
      itemCount: allItems.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFFFD700)
            ))
          ),
          child: ListTile(
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700),
              borderRadius: BorderRadius.circular(3) 
            ),
            child: Center(
              child: Text(
                    '${allItems[index]['id']}',
                    style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700
              ),
            ),
            )
          ),
          title: Text(allItems[index]['title']),  
          trailing: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: IconButton(
            icon: const Icon(Icons.close, color: Color(0xFFFFD700)),
            onPressed: () {},
          ),
          )
        ));
      }
    ) 
  )
);
}