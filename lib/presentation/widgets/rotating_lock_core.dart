/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to
/// deal in the Software without restriction, including without limitation the
/// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
/// sell copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge,
/// publish, distribute, sublicense, create a derivative work, and/or sell
/// copies of the Software in any work that is designed, intended, or marketed
/// for pedagogical or instructional purposes related to programming, coding,
/// application development, or information technology.  Permission for such
/// use, copying, modification, merger, publication, distribution, sublicensing,
///  creation of derivative works, or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
///  IN THE SOFTWARE.
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import '../../app/colors.dart';
import '../../domain.dart';
import 'keymotion_gesture_detector.dart';

/// Rotating Lock Core
///
/// Handles the lock's core widget and user gestures.
class RotatingLockCore extends StatefulWidget {
  /// @macro
  const RotatingLockCore({
    Key? key,
    required this.combinationsLeft,
  }) : super(key: key);

  /// Amount of combinations left to unlock.
  final int combinationsLeft;

  @override
  State<RotatingLockCore> createState() => _RotatingLockCoreState();
}

class _RotatingLockCoreState extends State<RotatingLockCore> {
  double currentAngle = 0;

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.height / 4;
    // 1.
    return KeymotionGestureDetector(
      onRotationUpdate: (details) {
        setState(() {
          // 2.
          final angleDegrees = (details.rotationAngle * 180 ~/ math.pi).abs();
          currentAngle = details.rotationAngle;
          // 3.
          if (details.acceleration <= 0.0025) {
            final isCorrect = context.read<Game>().tryCombination(angleDegrees);

            if (isCorrect) currentAngle = 0;
          }
        });
      },
      onDoubleTap: () => context.read<Game>().foundSecretKey(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: ((currentAngle * 180.0) / math.pi) / 10,
            child: ConstrainedBox(
              constraints: BoxConstraints.tightForFinite(
                height: radius,
              ),
              child: Image.asset('assets/images/lock_core.png'),
            ),
          ),
          AnimatedOpacity(
            opacity: widget.combinationsLeft == 0 ? 0.4 : 1,
            duration: const Duration(milliseconds: 200),
            child: Column(
              children: [
                Text(
                  widget.combinationsLeft.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    color: KeyMotionColors.tint1,
                  ),
                ),
                const SizedBox(height: 8),
                const Icon(
                  FeatherIcons.shield,
                  color: KeyMotionColors.tint1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
