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

/// GameOverDialog
///
/// Provides an overlay on top of the game screen and displays the game over
/// dialog
class GameOverDialog extends StatelessWidget {
  /// @macro
  const GameOverDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keys = context.watch<Game>().keys;
    return Stack(
      fit: StackFit.expand,
      children: [
        const Positioned.fill(
          child: ModalBarrier(
            dismissible: false,
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'GAME OVER',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: KeyMotionColors.tint1),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Text(
                  'You got a total of:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: KeyMotionColors.tint1),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$keys',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: KeyMotionColors.tint1),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      FeatherIcons.key,
                      size: 32,
                      color: KeyMotionColors.tint1,
                    )
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: KeyMotionColors.tint1,
                    onPrimary: KeyMotionColors.shade1,
                  ),
                  onPressed: () => context.read<Game>().start(),
                  child: const Text('TRY AGAIN'),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: KeyMotionColors.tint1,
                    side: const BorderSide(
                        width: 1, color: KeyMotionColors.tint1),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('BACK TO MENU'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
