import 'package:hooks_riverpod/hooks_riverpod.dart';

final scrollControllerProvider = StateNotifierProvider.autoDispose
    .family<ScrollControllerNotifier, ScrollControllerState, String>((ref, id) {
  return ScrollControllerNotifier();
});

class ScrollControllerNotifier extends StateNotifier<ScrollControllerState> {
  ScrollControllerNotifier() : super(ScrollControllerState());

  double lastScrollPosition = 0;

  void uptadeScroll(double scrollPosition) {
    double diff = lastScrollPosition - scrollPosition;
    bool newState = state.isOpen;
    if (diff < -8) {
      //scroll down
      if (newState == true) {
        newState = false;
      }
    } else if (diff > 0) {
      // scroll up
      if (newState == false) {
        newState = true;
      }
    }
    lastScrollPosition = scrollPosition;
    updateIsOpen(newState);
  }

  void updateIsOpen(bool isOpen) {
    if(isOpen != state.isOpen) {
      state = state.copyWith(isOpen: isOpen);
    }
  }
}

class ScrollControllerState {
  final bool isOpen;
  ScrollControllerState({
    this.isOpen = true
  });

  ScrollControllerState copyWith({
    bool? isOpen,
  }) {
    return ScrollControllerState(
      isOpen: isOpen ?? this.isOpen
    );
  }
}
