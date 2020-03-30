import 'main_bloc.dart';

class MainRepo {
  Future<MainViewModel> getRandomTip() async {
    final randomTips = [
      'Dont overload electrical circuits with too many appliances.',
      'Dont run extension cords under rugs or carpets. The cords wear easily and may short out, causing a fire.',
      'Replace frayed electrical cords before they burn or cause a fire.',
      'Keep combustibles away from the furnace, which can emit flames or sparks.',
      'Unplug your hair dryer or any other small appliance in the bathroom when not in use.',
      'Be sure to turn a heating pad off before you go to sleep.'
    ];

    return await Future(() => MainViewModel.fromJson(
        {'tip': (randomTips.toList()..shuffle()).first}));
  }
}
