import 'package:flutter/material.dart';
import 'map_data.dart'; // This should contain your GoogleMapsDataGetter class.
export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GoogleMapsDataGetter getter;
  Map<String, dynamic> _dcData = {};

  @override
  void initState() {
    super.initState();
    // Initialize the GoogleMapsDataGetter asynchronously.
    GoogleMapsDataGetter.create().then((value) {
      setState(() {
        getter = value;
      });
    });
  }

  // Fetch the place details for Washington, DC.
  // Replace the place ID below with a valid one for Washington, DC.
  void _fetchDCData() async {
    // Ensure getter is initialized before calling the API.
    const dcPlaceId = "ChIJW-T2Wt7Gt4kR3D7xJ1A1_wU"; // Example DC place ID.
    final data = await getter.getPlaceDetails(dcPlaceId);
    setState(() {
      _dcData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Data for Washington, DC:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _dcData.isNotEmpty
                  ? Text(_dcData.toString())
                  : const Text('No data loaded yet.'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchDCData,
        tooltip: 'Fetch DC Data',
        child: const Icon(Icons.location_city),
      ),
    );
  }
}
