import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:shake/shake.dart';

class EffectsHome extends StatefulWidget {
  const EffectsHome({Key? key}) : super(key: key);

  @override
  State<EffectsHome> createState() => _EffectsHomeState();
}

class _EffectsHomeState extends State<EffectsHome> {
  //is instrument list dropped down
  bool dropDown = false;
  List<Instrument> placedItems = [];

  //Temporary storage for indices in placedItems list
  late Offset tempOffsetHolder;
  late int alreadyPlacedIndex;

  //Shaking plays a shake sound
  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        final player = AudioPlayer();
        player.play(AssetSource('audio/shake.mp3'));
      },
      // minimumShakeCount: 1,
      // shakeSlopTimeMS: 500,
      // shakeCountResetTime: 3000,
      // shakeThresholdGravity: 2.7,
    );
  }

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
            Container(
              margin: const EdgeInsets.all(3),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    dropDown = !dropDown;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 107, 107, 1),
                  padding: const EdgeInsets.all(5),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                    ),
                    Text("Instruments", style: TextStyle(fontSize: 25)),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: dropDown ? 200 : 0,
              child: Row(
                children: [
                  draggableInstrument(1),
                  draggableInstrument(2),
                ],
              ),
            ),
            Expanded(
              child: musicBody(context),
            ),
          ],
        ));
  }

  Widget musicBody(BuildContext context) {
    return Ink(
      color: const Color.fromRGBO(248, 255, 247, 1),
      child: InkWell(
        splashColor: const Color.fromRGBO(26, 83, 92, 1),
        onTap: () {
          final player = AudioPlayer();
          player.setVolume(1);
          player.play(AssetSource('audio/bass_drum_hit.mp3'));
        },
        child: DragTarget<Instrument>(
          builder: (BuildContext context, List<Instrument?> incoming,
              List rejected) {
            return Container(
                alignment: Alignment.topCenter,
                color: Colors.transparent,
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
              setState(() {
                placedItems.add(data);
              });
            } else {
              alreadyPlacedIndex = data.index!;
            }
          },
        ),
      ),
    );
  }

  Widget draggableInstrument(int type) {
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
}

class Instrument extends StatelessWidget {
  Instrument({required this.type, this.position, super.key});

  final int type;
  static final Map<int, List<String>> list = {
    1: ['audio/hi_hat_close.mp3', 'assets/images/hi_hat.jpg'],
    2: ['audio/unwelcome_school.mp3', 'assets/images/blue_archiveBGN.jpg'],
  };
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
          color: const Color.fromRGBO(255, 230, 109, 1),
        ),
        child: Container(
          height: 180,
          width: 180,
          child: ElevatedButton(
            onPressed: () {
              final player = AudioPlayer();
              player.setVolume(0.8);
              player.play(AssetSource(list[type]![0]));
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              backgroundColor: const Color.fromRGBO(78, 205, 196, 1),
            ),
            child: Image(
              image: AssetImage(list[type]![1]),
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
