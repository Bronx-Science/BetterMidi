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

import 'game_page.dart';

/// HomePage widget.
///
/// [Scaffold] that displays the KeyMotion menu
class HomePage extends StatelessWidget {
  /// @macro home_page
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tightForFinite(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    child: Image.asset('assets/images/app_icon.png'),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'KEYMOTION',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Pick a 🔒, win a 🗝.',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'How many can you get?',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () =>
                    Navigator.push<void>(context, GamePage.route()),
                child: const Text('PLAY'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
