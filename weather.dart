import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _weather = "Enter city name";

  Future<void> fetchWeather(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=211922dc4575ca7aa489da81548a4965&units=metric'));
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        _weather = "${data['main']['temp']}°C, ${data['weather'][0]['description']}";
      });
    } else {
      setState(() {
        _weather = "Error fetching weather";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Column(
        children: [
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(labelText: 'Enter City', border: OutlineInputBorder()),
          ),
          ElevatedButton(
            onPressed: () => fetchWeather(_cityController.text),
            child: const Text('Get Weather'),
          ),
          Text(_weather, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
