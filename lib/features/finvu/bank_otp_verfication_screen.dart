import 'package:finvu_flutter_sdk_core/finvu_consent_info.dart';
import 'package:finvu_flutter_sdk_core/finvu_linked_accounts.dart';
import 'package:finvu_test/features/finvu/components/close_bank_connection.dart';
import 'package:finvu_test/features/finvu/components/constant_color.dart';
import 'package:finvu_test/features/finvu/components/fonts.dart';
import 'package:finvu_test/features/finvu/components/primart_cta.dart';
import 'package:finvu_test/features/finvu/index.dart';
import 'package:finvu_test/features/finvu/mobile_number_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class BankOtpVerificationScreen extends StatefulWidget {
  final String mobile;
  final String bankName;
  final String bankIcon;
  final String referenceNumber;
  final String consentHandleId;
  final String maskedAccountNumber;
  final List<BankConnectionItem> fipIdList;
  const BankOtpVerificationScreen(
      {super.key,
      required this.mobile,
      required this.bankName,
      required this.bankIcon,
      required this.referenceNumber,
      required this.consentHandleId,
      required this.maskedAccountNumber,
      required this.fipIdList});

  @override
  State<BankOtpVerificationScreen> createState() =>
      _BankOtpVerificationScreenState();
}

class _BankOtpVerificationScreenState extends State<BankOtpVerificationScreen> {
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
            FinvuManagerInstance.logoutWithFinvu();
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: ConstantColor.backgroundWhite,
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(2),
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
              "Bank OTP verification",
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
            const AAPartnerRow(),
            const SizedBox(height: 16),
            PrimaryCTA(
              buttonName: "Verify",
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

  void _onVerifyButtonPressed() async {
    String otp = _otpControllers.map((controller) => controller.text).join();
    FinvuConfirmAccountLinkingInfo accountinFo =
        await FinvuManagerInstance.confirmAccountLinking(
            widget.referenceNumber, otp);

    List<FinvuLinkedAccountDetailsInfo> initialConnectedBankList =
        await FinvuManagerInstance.fetchLinkedAccountsFinvu();
    List<FinvuLinkedAccountDetailsInfo> tempList = initialConnectedBankList;
    setState(() {
      initialConnectedBankList = tempList
          .where((e) => e.maskedAccountNumber == widget.maskedAccountNumber)
          .toList();
    });

    FinvuConsentRequestDetailInfo info =
        await FinvuManagerInstance.getConsentRequestDetails(
            widget.consentHandleId);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ApproveConsentScreen(
                  bankName: widget.bankName,
                  bankIcon: widget.bankIcon,
                  accountInfo: info,
                  detailInfo: initialConnectedBankList,
                  mobile: widget.mobile,
                  // consentHandleId: widget.consentHandleId,
                  fipIdList: widget.fipIdList,
                )));
  }
}
