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
  List<Map<String, dynamic>> allItems = [];

  TextEditingController buildItemTitleController = TextEditingController(); // TextEditingController for capturing the title input from the user.
  TextEditingController buildItemNumberController = TextEditingController(); // TextEditingController for capturing the item number input from the user.

  // State variable to track sorting order
  bool isAscending = true;

    // Function to toggle sorting order
  void toggleSortOrder() {
    setState(() {
      isAscending = !isAscending;
      // Sort the list based on title in ascending or descending order
      allItems.sort((a, b) {
        if (isAscending) {
          return a['title'].compareTo(b['title']);
        } else {
          return b['title'].compareTo(a['title']);
        }
      });
    });
  }

  @override
  // Dispose of the controllers to release resources when the widget is removed
  void dispose() {
    buildItemNumberController.dispose();
    buildItemNumberController.dispose();
    super.dispose();
  }

    // This method adds an item to the grocery list.
    // It takes a title (String) and an id (int) as parameters.
    void addItemFromInput(String title, int id) {
    setState(() {
       // Create a new item using the provided title and id.
      final newItem = {'id': id, 'title': title};
      // Add the new item to the list of allItems.
      allItems.add(newItem);
    });
  }

    // Function to remove an item from the list
    void removeItem(int id) {
    setState(() {
    allItems.removeWhere((item) => item['id'] == id);
  });
}

  Widget build(BuildContext context) => SafeArea (
    child: Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("../assets/BG.png"),
          fit: BoxFit.fill)
        ),
        child: Center(
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
              const Padding(padding: EdgeInsets.only(top: 12)),
              Container(
                padding: const EdgeInsets.only(left:360),
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
    ),
  );


Widget buildTitle() => const Text(
  'Grocery List',
  style: TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat', fontSize: 45,
    
  )
);

Widget buildItemTitle() {
  return  SizedBox(
  width: 192,
  height: 35,
  child: TextField(
    controller: buildItemTitleController,
    decoration: const InputDecoration(
      hintText: 'Title...',
      filled: true,
      fillColor: Color(0xFFBCBCBE),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0))
        ),
      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
    ),
  ),
);
}

Widget buildItemNumber() {
  return SizedBox(
  width: 64,
  height: 35,
  child: TextField(
    controller: buildItemNumberController,
    decoration: const InputDecoration(
      filled: true,
      fillColor: Color(0xFFBCBCBE),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3.0))
        ),
      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
    ),
  ),
);
}

Widget buildAddItem() {
  return SizedBox(
  width: 101,
  height: 35,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.transparent,
      side: const BorderSide(
        color: Color(0xFFFFD700)
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
    ),
    onPressed: () {
      // Retrieve the title and item number entered by the user.
      String title = buildItemTitleController.text;
      String id = buildItemNumberController.text;

      // Call the addItemFromInput method to add the new item to the list.
      addItemFromInput(title, int.tryParse(id) ?? 0);

      // Clear the text fields to prepare for the next input.
      buildItemTitleController.clear();
      buildItemNumberController.clear();
    },
    child: const Text('Add',
    style: TextStyle(
      color: Color(0xFFFFD700),
    )
    )),
  
);
} 

Widget buildSortButton() => IconButton( 
  onPressed: (){
    toggleSortOrder();
  }, 
  icon: Image.asset('../assets/icons/union.png')
);

Widget buildList() => Container(
  child: Expanded(
    child: ListView.builder(
      itemCount: allItems.length,
      itemBuilder: (BuildContext context, int index) {
        // Reverse the order of the items to display the newest item at the top.
        final reversedIndex = allItems.length - 1 - index;
        final itemId = allItems[reversedIndex]['id'];
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
                    '${allItems[reversedIndex]['id']}',
                    style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700
              ),
            ),
            )
          ),
          title: Text(allItems[reversedIndex]['title'],
                style: const TextStyle(
                color: Colors.white, // Set the title color to white
              ),), 
          trailing: Container(
            margin: const EdgeInsets.only(top: 10),
            child: IconButton(
            icon: const Icon(Icons.close, color: Color(0xFFFFD700)),
            onPressed: () {
              removeItem(itemId);
            },
          ),
          )
        ));
      }
    ) 
  )
);
}