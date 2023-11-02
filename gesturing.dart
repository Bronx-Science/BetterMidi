import 'package:flutter/material.dart';

class gesturing extends StatefulWidget {
  const gesturing({Key? key}) : super(key: key);

  @override
  State<gesturing> createState() => _gesturingState();
}

class _gesturingState extends State<gesturing> {
  int text = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 155, 210, 255),
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: 80,
        elevation: 0,
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => setState(() {
            text++;
          }),
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 212, 252, 255),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Gesturing',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 40,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text(
              text.toString(),
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
