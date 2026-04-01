import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:web_socket_counter/counter/counter.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      // A new client has connected to our server.
      // Subcribe the new client to receive notifcations
      // whenever t he cubit state changes.
      final cubit = context.read<CounterCubit>()..subscribe(channel);

      // Send the current count to the new client.
      channel.sink.add('${cubit.state}');

      // Listen for messages from the client.
      channel.stream.listen(
        (event) {
          switch (event) {
            // Handle an increment message.
            case '__increment__':
              cubit.increment();
            // Handle a decrement message.
            case '__decrement__':
              cubit.decrement();
            // ignore any other messages.
            default:
              break;
          }
        },
        // The client has disconnected.
        // Unsubscribe the channel.
        onDone: () => cubit.unsubscribe(channel),
      );
    },
  );
  return handler(context);
}
