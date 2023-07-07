import 'package:flutter/material.dart';

class Squad extends StatefulWidget {
  const Squad({super.key,required this.index, required this.name, required this.intBeers, required this.callback});

  final String name;
  final int index;
  final int intBeers;
  final Function callback;

  @override
  State<Squad> createState() => _SquadState();
}

class _SquadState extends State<Squad> {
  int beers = 0;
  @override
  void initState() {
    super.initState();
    beers = widget.intBeers;
  }

  void _incrementCounter() {
    setState(() {
      beers++;
    });
    widget.callback(widget.index, beers);
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.name,
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _decrementCounter,
            child: const Icon(Icons.remove),
          ),
          Text(
            '$beers',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
