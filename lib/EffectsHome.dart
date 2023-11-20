import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';

class EffectsHome extends StatefulWidget {
  const EffectsHome({Key? key}) : super(key: key);

  @override
  State<EffectsHome> createState() => _EffectsHomeState();
}

class _EffectsHomeState extends State<EffectsHome> {
  bool dropDown = false;
  List<Instrument> placedItems = [];
  late Offset tempOffsetHolder;
  late int alreadyPlacedIndex;

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
                  draggableInstrument(1),
                  draggableInstrument(1),
                ],
              ),
            ),
            Expanded(
              child: MusicBody(context),
            ),
          ],
        ));
  }

  Draggable<Instrument> draggableInstrument(int type) {
    return Draggable<Instrument>(
      feedback: Opacity(
        opacity: 0.5,
        child: Instrument(type: type),
      ),
      data: Instrument(type: type),
      child: Instrument(type: type),
      onDragEnd: (dragDetails) {
        setState(() {
          tempOffsetHolder =
              Offset(dragDetails.offset.dx, dragDetails.offset.dy);
          if (dropDown) {
            placedItems[placedItems.length - 1].position = tempOffsetHolder;
          }
        });
      },
    );
  }

  InkWell MusicBody(BuildContext context) {
    return InkWell(
      splashColor: Colors.green,
      child: GestureDetector(
        onTap: () {
          log('happened');
          final player = AudioPlayer();
          player.play(AssetSource('audio/bass_drum_hit.mp3'));
        },
        child: DragTarget<Instrument>(
          builder: (BuildContext context, List<Instrument?> incoming,
              List rejected) {
            return Container(
                alignment: Alignment.topCenter,
                color: c,
                child: Stack(
                  children: placedItems.map((e) {
                    return Positioned(
                      left: e.position!.dx,
                      top: e.position!.dy - (dropDown ? 370 : 170),
                      child: Draggable<Instrument>(
                        feedback: Opacity(
                          opacity: 0.5,
                          child: e,
                        ),
                        data: e,
                        child: e,
                        onDragEnd: (dragDetails) {
                          setState(() {
                            tempOffsetHolder = Offset(
                                dragDetails.offset.dx, dragDetails.offset.dy);
                            placedItems[alreadyPlacedIndex]
                                .setPosition(tempOffsetHolder);
                            log(placedItems[alreadyPlacedIndex]
                                .index
                                .toString());
                            log(placedItems.map((e) => e.position).toString());
                          });
                        },
                      ),
                    );
                  }).toList(),
                ));
          },
          onWillAccept: (data) {
            return true;
          },
          onAccept: (data) {
            if (data.index == null) {
              data.setIndex(placedItems.length);
              log(data.index.toString());
              setState(() {
                c = Colors.blue;
                placedItems.add(data);
              });
              log(placedItems.map((e) => e.position).toString());
            } else {
              alreadyPlacedIndex = data.index!;
            }
          },
        ),
      ),
    );
  }
}

class Instrument extends StatelessWidget {
  Instrument({required this.type, this.position, super.key});

  final int type;
  final Map<int, String> list = {};
  Offset? position;
  int? index;

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

  void setPosition(Offset p) {
    position = p;
  }

  void setIndex(int idx) {
    index = idx;
  }
}

// class Instrument extends StatefulWidget {
//   Instrument({required this.type, this.position, super.key});

//   final int type;
//   final Map<int, String> list = {};
//   final Offset? position;

//   @override
//   State<Instrument> createState() => _InstrumentState();
// }

// class _InstrumentState extends State<Instrument> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         alignment: Alignment.center,
//         height: 200,
//         width: 200,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.amber,
//         ),
//         child: Container(
//           height: 180,
//           width: 180,
//           child: ElevatedButton(
//             onPressed: () {},
//             child: Text('asd'),
//             style: ElevatedButton.styleFrom(
//               shape: const CircleBorder(),
//               padding: const EdgeInsets.all(20),
//               backgroundColor: Colors.blue, // <-- Button color
//               foregroundColor: Colors.red, // <-- Splash color
//             ),
//           ),
//         ));
//   }
// }