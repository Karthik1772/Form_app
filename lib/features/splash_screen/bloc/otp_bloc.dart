import 'package:Formify/features/splash_screen/models/otp_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpService _otpService = OtpService();
  
  OtpBloc() : super(OtpInitial()) {
    on<SendOtpRequested>(_onSendOtpRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
    on<ResendOtpRequested>(_onResendOtpRequested);
  }
  
  Future<void> _onSendOtpRequested(SendOtpRequested event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    
    final result = await _otpService.sendOtp(event.email);
    
    if (result['success']) {
      emit(OtpSendSuccess(message: result['message']));
    } else {
      emit(OtpSendFailure(error: result['message']));
    }
  }
  
  Future<void> _onVerifyOtpRequested(VerifyOtpRequested event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    
    if (event.otp.isEmpty) {
      emit(OtpVerifyFailure(error: 'Please enter the OTP'));
      return;
    }
    
    final result = _otpService.verifyOtp(event.email, event.otp);
    
    if (result['success']) {
      emit(OtpVerifySuccess());
    } else {
      emit(OtpVerifyFailure(error: result['message']));
    }
  }
  
  Future<void> _onResendOtpRequested(ResendOtpRequested event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    
    final result = await _otpService.sendOtp(event.email);
    
    if (result['success']) {
      emit(OtpSendSuccess(message: result['message']));
    } else {
      emit(OtpSendFailure(error: result['message']));
    }
  }
}