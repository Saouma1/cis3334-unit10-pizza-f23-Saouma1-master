import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Pizza Order'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pizza> pizzasInOrder = [];
  final pizzaToppings = TextEditingController();
  int sizeSelected = 1;

  void _addPizza() {
    print("addPizza called -- size = " + pizzasInOrder.length.toString());
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,     // shrink the dialog down to a small size
              children: [
                Text("Build your pizza"),
                TextField(
                  controller: pizzaToppings,
                  textAlign: TextAlign.center,
                ),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter dropDownState) {
                      return DropdownButton(
                          style: Theme.of(context).textTheme.headline4,
                          value: sizeSelected,
                          items: [
                            DropdownMenuItem(child: Text("Small"), value: 0),
                            DropdownMenuItem(child: Text("Medium"), value: 1),
                            DropdownMenuItem(child: Text("Large"), value: 2),
                            DropdownMenuItem(child: Text("X-Lareg"), value: 3)
                          ],
                          onChanged: (value) {
                            dropDownState(() {
                              sizeSelected = value!;
                            });
                          });
                    }),
                SizedBox(height: 50),
                ElevatedButton(
                    child: Text("Place Pizza Order"),
                    onPressed: () {
                      setState(() {
                        pizzasInOrder
                            .add(Pizza(pizzaToppings.text, sizeSelected));
                        Navigator.pop(context);
                      });
                      ;
                    }),
                SizedBox(height: 50),
              ],
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),// Displays the title on the app bar.
      ),
       //ListView.builder creates a scrollable list of pizzas in the order.
      body: ListView.builder(
          itemCount: pizzasInOrder.length,
          itemBuilder: (BuildContext context, int position) {
            return Card(
              color: Colors.blue[50],
              child: ListTile(
                title: Text(pizzasInOrder[position].description),
                leading: Icon(Icons.local_pizza),
              ),
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: _addPizza, // Calls _addPizza when the button is pressed.
        child: Icon(Icons.add), // Icon for the floating action button.
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Pizza class to define properties of a pizza.

class Pizza {
  String toppings = "";
  String description = "";
  double price = 0.0;
  int size = 0;

  // Arrays to define prices and sizes of pizzas.

  final PIZZA_PRICES = [7.99, 9.99, 12.99, 14.99];
  final PIZZA_SIZES = ["Small", "Medium", "Large", "X-Large"];

  // Constructor for the Pizza class. Sets price and description based on size and toppings.

  Pizza(String this.toppings, int this.size) {
    price = PIZZA_PRICES[size];
    description = PIZZA_SIZES[size] + " pizza with " + toppings;
  }
}