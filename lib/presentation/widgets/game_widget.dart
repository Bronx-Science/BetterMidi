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

import '../../domain.dart';
import '../dialogs/dialogs.dart';
import 'widgets.dart';

/// GameWidget
///
/// A widget containing the KeyMotion game.
class GameWidget extends StatefulWidget {
  /// @macro
  const GameWidget({Key? key}) : super(key: key);

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<Game>().start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder: (context, game, child) {
        final gameScreen = Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(FeatherIcons.flag),
                label: const Text('GIVE UP'),
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hint:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Use two fingers to rotate the '
                  'lock\'s core slowly until you pick it.',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                LockWidget(
                  lock: game.currentLock,
                  combinationsLeft: game.combinationsLeft,
                ),
              ],
            ),
            const Spacer(),
            GameStatsBar(
              keys: game.keys,
              timeLeft: game.timeLeft,
            ),
          ],
        );

        return Stack(
          children: [
            gameScreen,
            if (game.hasLost) const GameOverDialog(),
          ],
        );
      },
    );
  }
}
