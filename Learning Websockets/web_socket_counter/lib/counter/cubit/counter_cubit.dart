import 'package:broadcast_bloc/broadcast_bloc.dart';

/// A simple counter cubit that manages the state of a counter.
class CounterCubit extends BroadcastCubit<int> {
  /// Create an instance with an initial value of 0
  CounterCubit() : super(0);

  /// Increment the counter state.
  void increment() => emit(state + 1);

  /// Decrement the counter state.
  void decrement() => emit(state - 1);
}
