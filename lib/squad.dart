import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Squad extends StatefulWidget {
  const Squad({super.key, required this.index, required this.name, required this.intBeers, required this.callback});

  final String name;
  final int index;
  final int intBeers;
  final Function callback;

  @override
  State<Squad> createState() => _SquadState();
}

class _SquadState extends State<Squad> with TickerProviderStateMixin {
  int beers = 0;
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    beers = widget.intBeers;
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      beers++;
    });
    widget.callback(widget.index, beers);
    // if (beers % 5 == 0) {
    _controller.forward(from: 0);
    // }
  }

  void _decrementCounter() {
    if (beers > 0) {
      setState(() {
        beers--;
      });
      widget.callback(widget.index, beers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 350,
            child: Text(
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
              widget.name,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: _decrementCounter,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 150,
          ),
          Lottie.asset(
            "assets/beer.json",
            height: 80,
            controller: _controller,
            repeat: true,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward();
            },
          ),
          Text(
            '$beers',
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
