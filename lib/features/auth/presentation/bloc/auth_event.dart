import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login(String email, String password) = LoginEvent;

  const factory AuthEvent.logout() = LogoutEvent;

  const factory AuthEvent.checkAuth() = CheckAuthEvent;
}
