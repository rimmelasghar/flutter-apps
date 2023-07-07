import 'package:flutter/material.dart';

void main() {
  runApp(const CarsApp());
}

// class to hold cars information.
class Cars {
  String label;
  String imageUrl;
  double price;
  List<Engine> engine;
  Cars(
    this.label,
    this.imageUrl,
    this.price,
    this.engine,
  );
}

class Engine {
  String cc;
  String ltr;
  String type;
  Engine(
    this.cc,
    this.ltr,
    this.type,
  );
}

List<Cars> samples = [
  Cars(
    "Honda Civic",
    "imageUrl",
    2000.0,
    [Engine("2000", "2.0", "Petrol")],
  ),
];

class CarsApp extends StatelessWidget {
  const CarsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cars App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CarsListPage(),
    );
  }
}

class CarsListPage extends StatelessWidget {
  const CarsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars List'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: samples.length,
          itemBuilder: (BuildContext context, int index) {
            final recipe = samples[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailPage(recipe: recipe),
                  ),
                );
              },
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Image(image: AssetImage(recipe.imageUrl)),
                      const SizedBox(height: 14.0),
                      Text(
                        recipe.label,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Palatino',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CarDetailPage extends StatefulWidget {
  final Cars recipe;

  const CarDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  int _sliderVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(widget.recipe.imageUrl),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Engine:',
              style: const TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(7.0),
                itemCount: widget.recipe.engine.length,
                itemBuilder: (BuildContext context, int index) {
                  final ingredient = widget.recipe.engine[index];
                  return ListTile(
                    leading: Text('${ingredient.cc} ${ingredient.ltr}'),
                    title: Text(ingredient.type),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
