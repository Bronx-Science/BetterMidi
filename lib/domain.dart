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
import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// {@template lock}
/// Lock model.
///
/// {@endtemplate}
class Lock extends Equatable {
  /// Constant value for the base combinations amount of a lock in the easiest
  /// level.
  static const kBaseLockCombinations = 1;

  /// Convenience constructor for a lock with a given difficulty.
  Lock.fromDifficulty({required int difficulty})
      : combinations = List.generate(kBaseLockCombinations + difficulty,
            (index) => math.Random().nextInt(181)) {
    log('''
    ====== COMBINATIONS =======
    ${combinations.toString()}
    ===========================
    ''');
  }

  /// Difficulty multiplier for the game.
  final List<int> combinations;

  @override
  List<Object?> get props => [
        combinations,
      ];
}

/// {@template quote}
/// Game handler.
///
/// {@endtemplate}
class Game extends ChangeNotifier {
  /// @macro
  Game({
    this.difficulty = 0,
    this.keys = 0,
    this.currentPin = 0,
    this.hasLost = false,
    this.timeLeft = const Duration(seconds: kGameStartingSeconds),
    this.hasSecretKey = false,
  }) : currentLock = Lock.fromDifficulty(difficulty: difficulty);

  /// The amount of seconds that the game starts with.
  static const int kGameStartingSeconds = 60;

  /// Margin of error when validating a combination.
  static const int kAngleErrorTolerance = 5;

  /// Difficulty multiplier for the game.
  int keys;

  /// Difficulty multiplier for the game.
  int difficulty;

  /// Game timer handler.
  late Timer gameTimer;

  /// Current Lock that the player has to unlock.
  Lock currentLock;

  /// Indicates the current pin (position) that the player is
  /// attempting to unlock
  int currentPin;

  /// Indicates the time left for the player to unlock a lock.
  late Duration timeLeft;

  /// Indicates if the player has already lost.
  bool hasLost;

  /// Indicates if the player has found the secret key.
  bool hasSecretKey;

  /// Indicates the combinations left for the player to unlock.
  int get combinationsLeft => currentLock.combinations.length - currentPin;

  /// Should start a new game.
  void start() {
    if (hasLost) _restart();
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft -= const Duration(seconds: 1);
      if (timeLeft.inSeconds == 0) {
        // Player lost.
        _playerLost();
      }
      notifyListeners();
    });
  }

  /// Checks if a combination is inside the [currentLock] combinations list.
  bool tryCombination(int combination) {
    if (currentPin < currentLock.combinations.length &&
        _combinationWithinTolerance(
            combination, currentLock.combinations[currentPin])) {
      currentPin += 1;
      // Check if the lock has more pins or if there should be a new lock
      // for the user.
      if (currentPin + 1 > currentLock.combinations.length) {
        _nextLevelLock();
      } else {
        notifyListeners();
      }
      return true;
    }

    return false;
  }

  /// Adds a secret key to the player.
  void foundSecretKey() {
    if (!hasSecretKey) {
      hasSecretKey = true;
      keys += 1;
      notifyListeners();
    }
  }

  bool _combinationWithinTolerance(int playerCombination, int pinCombination) =>
      pinCombination - 5 <= playerCombination &&
      playerCombination <= pinCombination + 5;

  void _restart() {
    difficulty = 0;
    keys = 0;
    currentPin = 0;
    hasLost = false;
    hasSecretKey = false;
    timeLeft = const Duration(seconds: kGameStartingSeconds);
    currentLock = Lock.fromDifficulty(difficulty: difficulty);

    notifyListeners();
  }

  void _nextLevelLock() {
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      difficulty += 1;
      keys += 1;
      currentPin = 0;
      timeLeft += const Duration(seconds: 17);
      currentLock = Lock.fromDifficulty(difficulty: difficulty);
      notifyListeners();
    });
  }

  void _playerLost() {
    hasLost = true;
    gameTimer.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    hasLost = true;
    gameTimer.cancel();
    super.dispose();
  }
}
