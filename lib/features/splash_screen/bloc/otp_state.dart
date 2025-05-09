part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpLoading extends OtpState {}

final class OtpSendSuccess extends OtpState {
  final String message;
  OtpSendSuccess({required this.message});
}

final class OtpSendFailure extends OtpState {
  final String error;
  OtpSendFailure({required this.error});
}

final class OtpVerifySuccess extends OtpState {}

final class OtpVerifyFailure extends OtpState {
  final String error;
  OtpVerifyFailure({required this.error});
}
