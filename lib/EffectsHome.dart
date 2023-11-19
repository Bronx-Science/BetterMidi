import 'package:flutter/material.dart';
import 'dart:developer';

class EffectsHome extends StatefulWidget {
  const EffectsHome({Key? key}) : super(key: key);

  @override
  State<EffectsHome> createState() => _EffectsHomeState();
}

class _EffectsHomeState extends State<EffectsHome> {
  bool dropDown = false;
  List<Instrument> placedItems = [];
  Offset tempOffsetHolder = const Offset(0, 0);

  Color c = Colors.yellow;

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
              child: Row(
                children: [
                  Draggable<Instrument>(
                    // dragAnchorStrategy:
                    //     (Draggable<Object> _, BuildContext __, Offset ___) =>
                    //         const Offset(0, 0),
                    // feedback: Container(
                    //     alignment: Alignment.center,
                    //     child: Icon(Icons.arrow_downward_sharp)),
                    feedback: Opacity(
                      opacity: 0.5,
                      child: Instrument(type: 1),
                    ),
                    data: Instrument(type: 1, position: tempOffsetHolder),
                    child: Instrument(type: 1),
                    onDragEnd: (dragDetails) {
                      setState(() {
                        tempOffsetHolder = Offset(
                            dragDetails.offset.dx, dragDetails.offset.dy);
                      });
                    },
                  ),
                  Draggable<Instrument>(
                    // dragAnchorStrategy:
                    //     (Draggable<Object> _, BuildContext __, Offset ___) =>
                    //         const Offset(0, 0),
                    // feedback: Container(
                    //     alignment: Alignment.center,
                    //     child: Icon(Icons.arrow_downward_sharp)),
                    feedback: Opacity(
                      opacity: 0.5,
                      child: Instrument(type: 1),
                    ),
                    data: Instrument(type: 1, position: tempOffsetHolder),
                    child: Instrument(type: 1),
                    onDragEnd: (dragDetails) {
                      setState(() {
                        tempOffsetHolder = Offset(
                            dragDetails.offset.dx, dragDetails.offset.dy);
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: InkWell(
                splashColor: Colors.green,
                child: DragTarget<Instrument>(
                  builder: (BuildContext context, List<Instrument?> incoming,
                      List rejected) {
                    return Container(
                        alignment: Alignment.topCenter,
                        color: c,
                        child: Stack(
                          children: placedItems.map((e) {
                            return Positioned(
                              child: e,
                              left: e.position!.dx,
                              top: e.position!.dy - 370,
                            );
                          }).toList(),
                        ));
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    log(data.position.toString());
                    log(placedItems.map((e) => e.position).toString());
                    setState(() {
                      c = Colors.blue;
                      placedItems.add(data);
                    });
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

class Instrument extends StatefulWidget {
  Instrument({required this.type, this.position, super.key});

  final int type;
  final Map<int, String> list = {};
  final Offset? position;

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
