import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class OtpService {
  // In-memory OTP store
  final Map<String, String> _otpStore = {};

  // Generate a random 6-digit OTP
  String _generateOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  Future<Map<String, dynamic>> sendOtp(String email) async {
    try {
      if (email.isEmpty) {
        return {'success': false, 'message': 'Email cannot be empty'};
      }

      // Basic email validation
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        return {
          'success': false,
          'message': 'Please enter a valid email address',
        };
      }

      final otp = _generateOtp();
      _otpStore[email] = otp;

      // For debugging purposes, still print the OTP to console
      print('Generated OTP for $email: $otp');

      // Configure email sending credentials
      final smtpServer = SmtpServer(
        'smtp.gmail.com', // Gmail SMTP server
        port: 587,
        username:
            'formifyacess@gmail.com', // Replace with your actual Gmail address
        password:
            'isnwjuiroeafaakh', // Replace with your 16-character App Password
        ssl: false,
        allowInsecure: false,
      );

      final message =
          Message()
            ..from = Address(
              'formifyacess@gmail.com',
              'Formify App',
            ) // Replace with your actual Gmail address
            ..recipients.add(email)
            ..subject = 'Your Formify Verification Code'
            ..html = '''
          <h1>Verification Code</h1>
          <p>Your OTP code is: <strong>$otp</strong></p>
          <p>This code will expire in 10 minutes.</p>
          <p>Thank you for using Formify!</p>
        ''';

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ${sendReport.toString()}');
        return {'success': true, 'message': 'OTP sent successfully to $email'};
      } catch (e) {
        print('Error sending email: $e');
        return {
          'success': false,
          'message': 'Failed to send OTP email: ${e.toString()}',
        };
      }
    } catch (e) {
      print('Error in OTP service: $e');
      return {
        'success': false,
        'message': 'Failed to send OTP. Please try again.',
      };
    }
  }

  Map<String, dynamic> verifyOtp(String email, String otp) {
    if (!_otpStore.containsKey(email)) {
      return {'success': false, 'message': 'OTP has expired or was not sent'};
    }

    if (_otpStore[email] == otp) {
      // Remove the OTP after successful verification
      _otpStore.remove(email);
      return {'success': true, 'message': 'OTP verified successfully'};
    } else {
      return {'success': false, 'message': 'Invalid OTP. Please try again.'};
    }
  }
}
