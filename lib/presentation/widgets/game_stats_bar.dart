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
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import '../../app/colors.dart';
import '../../domain.dart';

/// Game Stats Bar
///
/// Displays the current game's stats.
class GameStatsBar extends StatelessWidget {
  /// @macro
  const GameStatsBar({
    Key? key,
    required this.keys,
    required this.timeLeft,
  }) : super(key: key);

  /// Amount of keys that the player has unlocked.
  final int keys;

  /// Time left that the player has to unlock the lock.
  final Duration timeLeft;

  @override
  Widget build(BuildContext context) {
    final hasLost = context.read<Game>().hasLost;
    final minutesLeft =
        timeLeft.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secondsLeft =
        timeLeft.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              keys.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 8),
            const Icon(FeatherIcons.key),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FeatherIcons.clock,
              color: timeLeft.inSeconds <= 10 || hasLost
                  ? KeyMotionColors.error
                  : null,
            ),
            const SizedBox(width: 16),
            Text(
              '$minutesLeft:$secondsLeft',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: timeLeft.inSeconds <= 10 || hasLost
                        ? KeyMotionColors.error
                        : null,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
