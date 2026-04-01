import 'dart:developer' as dev;

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

/// WebSocket handler for the /ws route
Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      // Subscribe to messages from the client
      channel.stream.listen(
        (message) {
          dev.log(message.toString());
        },
      );

      // Send a message to the client
      channel.sink.add('Hello, client!');
    },
  );
  return handler(context);
}

/* /// Simplified WebSocket handler for the /ws route
Handler get onRequest {
  return webSocketHandler(
    (channel, protocol) {
      // Subscribe to messages from the client
      channel.stream.listen(
        (message) {
          dev.log(message.toString());
        },
      );

      // Send a message to the client
      channel.sink.add('Hello, client!');
    },
  );
}
 */
