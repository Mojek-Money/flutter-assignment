import 'package:finvu_test/features/finvu/components/constant_color.dart';
import 'package:finvu_test/features/finvu/components/fonts.dart';
import 'package:finvu_test/features/finvu/components/primart_cta.dart';
import 'package:finvu_test/features/finvu/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class FinvuMobileNumberConfirmationScreen extends StatefulWidget {
  final List<BankConnectionItem> fipIdList;
  const FinvuMobileNumberConfirmationScreen(
      {super.key, required this.fipIdList});

  @override
  State<FinvuMobileNumberConfirmationScreen> createState() =>
      _FinvuMobileNumberConfirmationScreenState();
}

class _FinvuMobileNumberConfirmationScreenState
    extends State<FinvuMobileNumberConfirmationScreen> {
  // final FinvuManager finvuManager = FinvuManager();
  late TextEditingController _phoneController;
  late FocusNode _phoneFocusNode;
  bool _isEmptyError = false;
  bool enableSendOTPButton = true;

  /// set `Handle id` here
  String consentHandleId = "ff193f8c-1990-48bd-8663-be57475831af";
  String mobileNumber = "";

  @override
  initState() {
    super.initState();

    FinvuManagerInstance.initialize();
    FinvuManagerInstance.connectFinvu();
    _getMobileNumber();

    _phoneController = TextEditingController(text: "");
    _phoneFocusNode = FocusNode();
    fetchUserConsentHandleId();
  }

  void _getMobileNumber() async {}
  void _navigateToOTPVerification(String mobile) async {
    if (mobileNumber != _phoneController.text) {
      fetchUserConsentHandleId();
    }
    FinvuManagerInstance.loginWithFinvu(mobile, consentHandleId)
        .then((onValue) {
      print("OTP Reference: $onValue");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MobileNumberOtpVerificationScreen(
                    mobile: mobile,
                    fipIdList: widget.fipIdList,
                    otpReference: onValue,
                    consentHandleId: consentHandleId,
                    finvuManager: FinvuManagerInstance.instance,
                  )));
    });
  }

  void _isEmptyErrorEvent() {
    setState(() {
      _isEmptyError = true;
      if (!_phoneFocusNode.hasFocus) {
        _phoneFocusNode.nextFocus();
      }
    });
  }

  void _isNotEmptyErrorEvent() {
    setState(() {
      _isEmptyError = false;
    });
  }

  Color _getContainerBorderColor() {
    return _phoneFocusNode.hasFocus
        ? _isEmptyError
            ? ConstantColor.colorError
            : ConstantColor.colorAccent
        : ConstantColor.backgroundWhite;
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
            FinvuManagerInstance.disconnectConnectionFinvu();
            Navigator.pop(context);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColor.gray_50,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: goBack,
                icon: Image.asset(
                  "assets/arrow_left.png",
                  width: 15,
                  height: 15,
                  color: ConstantColor.gray_900,
                ),
              ),
            ),
            Center(child: Fonts.dynamicText("Mobile verification", 18, 600))
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
            children: [
              Fonts.dynamicText(
                "Enter your phone number to proceed",
                14,
                500,
                color: ConstantColor.gray_600,
              ),
              const SizedBox(
                height: 16,
              ),
              _buildMobileNumberPlate()
            ],
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: PrimaryCTA(
                buttonName: "Get Otp",
                enabled: enableSendOTPButton,
                onPressed: () {
                  _navigateToOTPVerification(_phoneController.text);
                },
                rightIcon: Icon(
                  Iconsax.arrow_right_1,
                  color: enableSendOTPButton
                      ? ConstantColor.backgroundWhite
                      : ConstantColor.gray_300,
                  size: 20.0,
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildMobileNumberPlate() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(top: 0, left: 16),
            decoration: BoxDecoration(
                color: ConstantColor.backgroundWhite,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: _getContainerBorderColor())),
            child: IntrinsicHeight(
              child: Row(children: [
                Container(
                    padding: EdgeInsets.only(top: 0, right: 10, bottom: 4),
                    child: Fonts.dynamicText("+91", 14, 600)),
                Expanded(
                  child: _buildMobileNumberTextBox(),
                )
              ]),
            )),
        Align(
            alignment: Alignment.topLeft,
            child: _isEmptyError
                ? Container(
                    padding: EdgeInsets.only(top: 10),
                    child: const Text.rich(TextSpan(
                        text: "mobile number cannot be less that 10 digits.",
                        style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 14,
                            color: ConstantColor.colorError,
                            fontWeight: FontWeight.w500))),
                  )
                : null)
      ],
    );
  }

  Widget _buildMobileNumberTextBox() {
    return Container(
        padding: EdgeInsets.only(top: 0, bottom: 4),
        child: TextField(
          onChanged: (value) {
            setState(() {
              if (value.length == 10) {
                _isNotEmptyErrorEvent();
                enableSendOTPButton = true;
              } else {
                enableSendOTPButton = false;
              }
            });
          },
          cursorColor: ConstantColor.colorAccent,
          controller: _phoneController,
          focusNode: _phoneFocusNode,
          maxLength: 10,
          style: const TextStyle(
              color: ConstantColor.colorAccent,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.5),
          decoration: const InputDecoration(
              counterText: "",
              border: InputBorder.none,
              hintText: "",
              hintStyle: TextStyle(
                  color: ConstantColor.colorEditText,
                  fontFamily: 'NotoSans',
                  fontSize: 14)),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ));
  }

  fetchUserConsentHandleId() async {
    //API CALL to fetch habdle ID
  }
}

class BankConnectionItem {
  String? id;
  String? fipId;
  String? name;
  List<String>? fiTypes;
  String? status;
  String? icon;

  BankConnectionItem({
    this.id = "",
    this.fipId = "",
    this.name = "",
    this.fiTypes = const [],
    this.status = "",
    this.icon = "",
  });
}
