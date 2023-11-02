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

/// Displays the give up confirmation dialog for the player and
/// returns the player's choice.
Future<bool> showGiveUpDialog(BuildContext context) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Never give up!'),
        content: const Text(
          'Are you sure you want to give up?',
        ),
        actions: [
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: const Text('GIVE UP'),
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              primary: const Color(0xFFFFDA57),
            ),
          ),
        ],
      ),
    ) ??
    false;
