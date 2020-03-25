import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:fireforce/phone/bloc/phone_repo.dart';

class PhoneViewModel {
  final _currentNum;
  final _lastCorrectFlag;
  final _consecutiveWrongs;
  final _nextNum;

  int get getCurrentNumber => _currentNum;

  int get getNextNumber => _nextNum;

  bool get getLastCorrect => _lastCorrectFlag;

  int get getConsecutiveWrongs => _consecutiveWrongs;

  PhoneViewModel(this._currentNum, this._lastCorrectFlag,
      this._consecutiveWrongs, this._nextNum);

  factory PhoneViewModel.fromJson(Map<String, dynamic> json) {
    return PhoneViewModel(json['current_num'], json['last_correct_flag'],
        json['consecutive_wrongs'], json['next_num']);
  }
}

/* bloc events */
class PhoneEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class PhoneLoadedEvent extends PhoneEvent {
  PhoneLoadedEvent();

  @override
  List<Object> get props => [];
}

class PhoneInputEvent extends PhoneEvent {
  final int _data;

  PhoneInputEvent(this._data);

  @override
  List<Object> get props => [];
}

/* bloc states */

class PhoneState extends Equatable {
  @override
  List<Object> get props => null;
}

class PhoneLockState extends PhoneState {}

class PhoneLoadedState extends PhoneState {}

class PhoneCorrectState extends PhoneState {
  final _viewModel;

  PhoneCorrectState(this._viewModel);

  PhoneViewModel get getViewModel => _viewModel;

  @override
  List<Object> get props => [this._viewModel];
}

class PhoneFinishState extends PhoneState {
  final _viewModel;

  PhoneFinishState(this._viewModel);

  PhoneViewModel get getViewModel => _viewModel;

  @override
  List<Object> get props => [this._viewModel];
}

class PhoneIncorrectState extends PhoneState {
  final _viewModel;

  PhoneIncorrectState(this._viewModel);

  PhoneViewModel get getViewModel => _viewModel;

  @override
  List<Object> get props => [_viewModel];
}

class PhoneIncorrectSecondState extends PhoneState {
  final _viewModel;

  PhoneIncorrectSecondState(this._viewModel);

  PhoneViewModel get getViewModel => _viewModel;

  @override
  List<Object> get props => [_viewModel];
}

class PhoneIncorrectThirdState extends PhoneState {
  final _viewModel;

  PhoneIncorrectThirdState(this._viewModel);

  PhoneViewModel get getViewModel => _viewModel;

  @override
  List<Object> get props => [_viewModel];
}

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneRepo repo = new PhoneRepo();

  @override
  PhoneState get initialState => PhoneLockState();

  PhoneRepo get getRepo => repo;

  @override
  Stream<PhoneState> mapEventToState(PhoneEvent event) async* {
    if (event is PhoneInputEvent) {
      PhoneViewModel viewModel = await repo.isCorrect(event._data);
      if(viewModel._currentNum == 911) {
        yield PhoneFinishState(viewModel);
      } else if (viewModel._lastCorrectFlag == true) {
        yield PhoneCorrectState(viewModel);
      } else {
        yield {
          1: PhoneIncorrectState(viewModel),
          2: PhoneIncorrectSecondState(viewModel),
          3: PhoneIncorrectThirdState(viewModel)
        }[viewModel._consecutiveWrongs];
      }
    } else if (event is PhoneLoadedEvent) {
      yield PhoneLoadedState();
    }
  }
}
