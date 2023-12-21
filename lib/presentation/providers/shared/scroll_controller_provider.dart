import 'package:hooks_riverpod/hooks_riverpod.dart';

final scrollControllerProvider = StateNotifierProvider.autoDispose
    .family<ScrollControllerNotifier, ScrollControllerState, String>((ref, id) {
  return ScrollControllerNotifier();
});

class ScrollControllerNotifier extends StateNotifier<ScrollControllerState> {
  ScrollControllerNotifier() : super(ScrollControllerState());

  void uptadeScroll(double scrollPosition) {
    double diff = state.lastScrollPosition - scrollPosition;
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
    if (newState != state.isOpen) {
      state = state.copyWith(isOpen: newState, lastScrollPosition: scrollPosition);
    } else {
      state = state.copyWith(lastScrollPosition: scrollPosition);
    }
  }

  void updateIsOpen(bool isOpen) {
    if (isOpen != state.isOpen) {
      state = state.copyWith(isOpen: isOpen);
    }
  }
}

class ScrollControllerState {
  final bool isOpen;
  final double lastScrollPosition;
  ScrollControllerState({this.isOpen = true, this.lastScrollPosition = 0});

  ScrollControllerState copyWith({
    bool? isOpen,
    double? lastScrollPosition,
  }) {
    return ScrollControllerState(
      isOpen: isOpen ?? this.isOpen,
      lastScrollPosition: lastScrollPosition ?? this.lastScrollPosition,
    );
  }
}
