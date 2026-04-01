// import 'dart:developer' as dev;

import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  // Connect to the remote websocket endpoint
  final uri = Uri.parse('ws://localhost:8080/ws');
  final channel = WebSocketChannel.connect(uri);

  // Send a message to the server
  channel.sink.add('Hello, server!');

  // Subscribe to messages from the server
  channel.stream.listen(
    (message) {
      // Print the message
    },
  );

  // Close the connection
  channel.sink.close();
}
