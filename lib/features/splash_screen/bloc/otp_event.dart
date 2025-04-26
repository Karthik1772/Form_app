part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class SendOtpRequested extends OtpEvent {
  final String email;
  SendOtpRequested({required this.email});
}

class VerifyOtpRequested extends OtpEvent {
  final String email;
  final String otp;
  VerifyOtpRequested({required this.email, required this.otp});
}

class ResendOtpRequested extends OtpEvent {
  final String email;
  ResendOtpRequested({required this.email});
}
