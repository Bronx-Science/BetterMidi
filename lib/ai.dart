import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyDragAndDropApp(),
    );
  }
}

class MyDragAndDropApp extends StatefulWidget {
  const MyDragAndDropApp({super.key});

  @override
  _MyDragAndDropAppState createState() => _MyDragAndDropAppState();
}

class _MyDragAndDropAppState extends State<MyDragAndDropApp> {
  Offset buttonPosition = const Offset(0, 0);

  Color myColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag and Drop with Button'),
      ),
      body: Stack(
        children: <Widget>[
          // Empty Canvas as a DragTarget
          Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  myColor = Colors.green;
                });
              },
              child: Ink(
                color: myColor,
                child: DragTarget<String>(
                  builder: (BuildContext context, List<String?> incoming,
                      List rejected) {
                    return Container(
                      width: 300,
                      height: 300,
                    );
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    setState(() {
                      // Set the buttonPosition to match the drop position.
                      final parts = data.split(',');
                      Offset dropPosition = Offset(
                          double.parse(parts[0]), double.parse(parts[1]));

                      // Update buttonPosition to match the dropPosition.
                      buttonPosition = dropPosition;
                    });
                  },
                ),
              ),
            ),
          ),
          // Button Menu
          Positioned(
            left: 20,
            top: 20,
            child: Draggable<String>(
              onDragEnd: (dragDetails) {
                setState(() {
                  Offset neTw =
                      Offset(dragDetails.offset.dx, dragDetails.offset.dy);
                  buttonPosition = neTw;
                });
              },
              data:
                  '${buttonPosition.dx},${buttonPosition.dy}', // Use current buttonPosition as data.
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('bruh'),
              ),
              feedback: Container(
                width: 50,
                height: 50,
                color: Colors.blue.withOpacity(0.5),
                child: const Center(
                  child: Text('Button'),
                ),
              ),
            ),
          ),
          // Placed Button
          Positioned(
            left: buttonPosition.dx,
            top: buttonPosition.dy,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.blue,
              child: const Center(
                child: Text('Button'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
