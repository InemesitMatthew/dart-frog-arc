import 'package:auth_app/authenticator.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler
      .use(
        provider<Authenticator>(
          (_) => Authenticator(),
        ),
      )
      .use(requestLogger());
}
