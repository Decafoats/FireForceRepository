import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:fireforce/main/bloc/main_repo.dart';

class MainViewModel {
  final _tip;

  MainViewModel(this._tip);

  String get getHelpTip => _tip;

  factory MainViewModel.fromJson(Map<String, dynamic> json) {
    return MainViewModel(json['tip']);
  }
}

class MainEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class MainUpdateEvent extends MainEvent {
  MainUpdateEvent();

  @override
  List<Object> get props => [];
}

/* bloc states */

class MainState extends Equatable {
  @override
  List<Object> get props => null;
}

class MainNotLoadedState extends MainState {}

class MainLoadedState extends MainState {
  final _viewModel;

  MainLoadedState(this._viewModel);

  MainViewModel get getViewModel => _viewModel;

  @override
  List<Object> get props => [_viewModel];
}

class MainBloc extends Bloc<MainEvent, MainState> {
  MainRepo _repo;

  MainBloc(this._repo);

  @override
  MainState get initialState => MainNotLoadedState();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is MainUpdateEvent) {
      MainViewModel model = await _repo.getRandomTip();
      yield MainLoadedState(model);
    }
  }
}
