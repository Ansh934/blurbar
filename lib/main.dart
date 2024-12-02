import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
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
  int _counter = 0;
  double _blurIntensity = 1.0;

  void _incrementCounter() {
    setState(() {
      if (_counter < 100) {
        _counter++;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _updateCounter(double value) {
    setState(() {
      _counter = value.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Current count:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Slider(
                  value: _counter.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: _counter.toString(),
                  onChanged: _updateCounter,
                ),
                const SizedBox(height: 40),
                const Text('Blur intensity:'),
                Text(
                  '$_blurIntensity',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Slider(
                  value: _blurIntensity,
                  min: 0.0,
                  max: 10.0,
                  divisions: 20,
                  label: _blurIntensity.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      _blurIntensity = value;
                    });
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: FloatingActionButton(
                  onPressed: _decrementCounter,
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          // right: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: _blurIntensity,
                sigmaY: _blurIntensity,
              ),
              child: Container(
                height: MediaQuery.of(context).padding.top + kToolbarHeight,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                ),
                width: MediaQuery.of(context).size.width * _counter / 100,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3),
                      ),
                    ),
                    // Positioned(
                    //   left: 0,
                    //   right: 0,
                    //   bottom: 0,
                    //   child: Container(
                    //     height: kToolbarHeight,
                    //     padding: const EdgeInsets.symmetric(horizontal: 16),
                    //     child: Row(
                    //       children: [
                    //         // Text(
                    //         //   widget.title,
                    //         //   style: Theme.of(context).textTheme.titleLarge,
                    //         // ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
