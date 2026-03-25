import 'package:dart_frog/dart_frog.dart';
import 'package:web_socket_counter/counter/cubit/counter_cubit.dart';

final _counter = CounterCubit();

/// Provide the center instance via 'RequestContext'
final counterProvider = provider<CounterCubit>((context) => _counter);
