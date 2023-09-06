import 'package:flutter/material.dart';

void main() {
  runApp(RaceCalculatorApp());
}

class RaceCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Yakalama Süresi Hesaplayıcı'),
          backgroundColor: Colors.green,
        ),
        body: RaceCalculator(),
      ),
    );
  }
}

class RaceCalculator extends StatefulWidget {
  @override
  _RaceCalculatorState createState() => _RaceCalculatorState();
}

class _RaceCalculatorState extends State<RaceCalculator> {
  TextEditingController _firstRunnerSpeedController = TextEditingController();
  TextEditingController _secondRunnerSpeedController = TextEditingController();
  String result = '';

  void calculateTimeToCatch() {
    double firstRunnerSpeed = double.tryParse(_firstRunnerSpeedController.text) ?? 0;
    double secondRunnerSpeed = double.tryParse(_secondRunnerSpeedController.text) ?? 0;

    if (firstRunnerSpeed >= secondRunnerSpeed) {
      setState(() {
        result = 'Hata: İkinci yarışmacı daha yavaş veya aynı hızda koşuyor.';
      });
      return;
    }

    double speedDifference = secondRunnerSpeed - firstRunnerSpeed;
    double timeToCatch = 0;

    if (speedDifference != 0) {
      timeToCatch = 1 / speedDifference;
    }

    setState(() {
      result = 'İkinci yarışmacı ilk yarışmacıyı $timeToCatch saat sonra yakalar.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _firstRunnerSpeedController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                labelText: 'İlk Yarışmacının Hızı (km/saat)',
                labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _secondRunnerSpeedController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                labelText: 'İkinci Yarışmacının Hızı (km/saat)',
                labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: calculateTimeToCatch,
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: TextStyle(fontSize: 18),
            ),
            child: Text('Hesapla'),
          ),
          SizedBox(height: 20),
          Text(
            result,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
