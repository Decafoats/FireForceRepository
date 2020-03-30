import 'dart:math';

import 'package:fireforce/phone/bloc/phone_bloc.dart';

class PhoneRepo {
  List _correctNumSeq = [9, 1, 1];
  int _currentNumIndex = 0;
  bool _lastCorrectFlag = false;
  int _consecutiveWrongs = 0;
  int _nextNum = 9;

  int get getNextNum => _nextNum;
  int get getCurrentNum => {1: 9, 2: 91, 3: 911}[_currentNumIndex];

  Future<PhoneViewModel> isCorrect(int numberPressed) async {
    if ({1: 9, 2: 91, 3: 911}[_currentNumIndex] != 911){
      _lastCorrectFlag = false;
      if (numberPressed == _correctNumSeq[_currentNumIndex]) {
        _lastCorrectFlag = true;
        _currentNumIndex += 1;
        _consecutiveWrongs = 0;
      }

      _nextNum = _currentNumIndex == 3 ? -1 : _correctNumSeq[_currentNumIndex];
    }

    return await Future(() => PhoneViewModel.fromJson({
          'current_num': {1: 9, 2: 91, 3: 911}[_currentNumIndex] ?? 0,
          'last_correct_flag': _lastCorrectFlag,
          'consecutive_wrongs': _lastCorrectFlag
              ? _consecutiveWrongs
              : min(_consecutiveWrongs += 1, 3),
          'next_num': _nextNum
        }));
  }
}
