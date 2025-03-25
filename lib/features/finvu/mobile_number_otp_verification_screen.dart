import 'package:finvu_flutter_sdk/finvu_manager.dart';
import 'package:finvu_test/features/finvu/components/close_bank_connection.dart';
import 'package:finvu_test/features/finvu/components/constant_color.dart';
import 'package:finvu_test/features/finvu/components/fonts.dart';
import 'package:finvu_test/features/finvu/components/primart_cta.dart';
import 'package:finvu_test/features/finvu/index.dart';
import 'package:finvu_test/features/finvu/mobile_number_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class MobileNumberOtpVerificationScreen extends StatefulWidget {
  final List<BankConnectionItem> fipIdList;
  final String mobile;
  final String otpReference;
  final String consentHandleId;
  final FinvuManager finvuManager;
  const MobileNumberOtpVerificationScreen(
      {super.key,
      required this.fipIdList,
      required this.mobile,
      required this.otpReference,
      required this.consentHandleId,
      required this.finvuManager});

  @override
  State<MobileNumberOtpVerificationScreen> createState() =>
      _MobileNumberOtpVerificationScreenState();
}

class _MobileNumberOtpVerificationScreenState
    extends State<MobileNumberOtpVerificationScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _focusNodes[0].requestFocus();
    for (int i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(() => _onOtpChange());
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onOtpChange() {
    String otp = _otpControllers.map((controller) => controller.text).join();
    setState(() {
      _isButtonEnabled = otp.length == 6 && !otp.contains(" ");
    });
  }

  void _onKeyPressed(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _onBackspace(int index) {
    if (index > 0 && _otpControllers[index].text.isEmpty) {
      _focusNodes[index - 1].requestFocus();
      _otpControllers[index - 1].clear();
    }
  }

  // void verifyOTPFromFinvu(String otp){
  //   widget.finvuManager.verifyLoginOtp(otp, widget.otpReference);
  //   logger.i("OTP Reference: ${widget.otpReference}");
  // }

  void goBack() {
    showModalBottomSheet(
        barrierColor: ConstantColor.gray_900.withOpacity(0.85),
        backgroundColor: ConstantColor.transparentColor,
        isScrollControlled: true,
        context: context,
        enableDrag: true,
        builder: (context) {
          return CloseBankConnection(onPressed: () {
            Navigator.pop(context);
            FinvuManagerInstance.disconnectConnectionFinvu();
            Navigator.pop(context);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColor.gray_50,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: ConstantColor.backgroundWhite,
                ),
                child: IconButton(
                  padding: EdgeInsets.all(2),
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: goBack,
                ),
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Fonts.dynamicText(
              "OTP verification",
              24,
              600,
              color: Colors.black,
            ),
            const SizedBox(height: 16),
            _buildOtpInputField(),
            const SizedBox(height: 8),
            Fonts.dynamicText(
              "Enter the 6 digit OTP sent on ${widget.mobile}",
              14,
              500,
              color: ConstantColor.gray_600,
            ),
            const SizedBox(height: 16),
            Fonts.dynamicText(
              "Resend in 30s",
              14,
              500,
              color: ConstantColor.gray_400,
            ),
            const Spacer(),
            AAPartnerRow(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: PrimaryCTA(
                buttonName: "Verify mobile number",
                enabled: _isButtonEnabled,
                onPressed: _isButtonEnabled ? _onVerifyButtonPressed : null,
                rightIcon: Icon(
                  Iconsax.arrow_right_1,
                  color: _isButtonEnabled
                      ? ConstantColor.backgroundWhite
                      : ConstantColor.gray_300,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpInputField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: ConstantColor.backgroundWhite,
          ),
          width: (MediaQuery.of(context).size.width - 72) / 6,
          height: 60,
          child: TextField(
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ConstantColor.gray_300),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ConstantColor.colorAccent),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) => _onKeyPressed(index, value),
            onTap: () => _focusNodes[index].requestFocus(),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            // on: (node, event) {
            //   if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
            //     _onBackspace(index);
            //   }
            //   return KeyEventResult.handled;
            // },
          ),
        );
      }),
    );
  }

  void _onVerifyButtonPressed() {
    String otp = _otpControllers.map((controller) => controller.text).join();
    // verifyOTPFromFinvu(otp);
    FinvuManagerInstance.verifyOTPFromFinvu(otp, widget.otpReference);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BankDiscoveredAccountsScreen(
                  mobile: widget.mobile,
                  fipIdList: widget.fipIdList,
                  // finvuManager: widget.finvuManager,
                  consentHandleId: widget.consentHandleId,
                )));

    print("OTP Verified: $otp");
  }
}
