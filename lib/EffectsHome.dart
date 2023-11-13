import 'package:flutter/material.dart';

class EffectsHome extends StatefulWidget {
  const EffectsHome({Key? key}) : super(key: key);

  @override
  State<EffectsHome> createState() => _EffectsHomeState();
}

class _EffectsHomeState extends State<EffectsHome> {
  bool dropDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 155, 210, 255),
        appBar: AppBar(
          toolbarHeight: 100,
          leadingWidth: 80,
          elevation: 0,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    dropDown = !dropDown;
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_drop_down),
                    Text("Click me!", style: TextStyle(fontSize: 20)),
                    Icon(Icons.arrow_drop_down),
                  ],
                )),
            Container(
                height: dropDown ? 200 : 0,
                child: const Row(
                  children: [
                    Instrument(),
                  ],
                )),
            InkWell(
              splashColor: Colors.green,
              child: DragTarget<String>(
                builder: (BuildContext context, List<String?> incoming,
                    List rejected) {
                  return Container(
                    color: Colors.yellow,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('asdas'),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class Instrument extends StatefulWidget {
  const Instrument({super.key});

  @override
  State<Instrument> createState() => _InstrumentState();
}

class _InstrumentState extends State<Instrument> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.amber,
        ),
        child: Container(
          height: 180,
          width: 180,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('asd'),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.blue, // <-- Button color
              foregroundColor: Colors.red, // <-- Splash color
            ),
          ),
        ));
  }
}
