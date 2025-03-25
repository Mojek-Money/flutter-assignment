import 'dart:convert';

import 'package:finvu_flutter_sdk_core/finvu_consent_info.dart';
import 'package:finvu_flutter_sdk_core/finvu_linked_accounts.dart';
import 'package:finvu_test/features/finvu/components/close_bank_connection.dart';
import 'package:finvu_test/features/finvu/components/constant_color.dart';
import 'package:finvu_test/features/finvu/components/data_is_secure.dart';
import 'package:finvu_test/features/finvu/components/fonts.dart';
import 'package:finvu_test/features/finvu/components/primart_cta.dart';
import 'package:finvu_test/features/finvu/index.dart';
import 'package:finvu_test/features/finvu/mobile_number_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

class ApproveConsentScreen extends StatelessWidget {
  final String bankName;
  final String bankIcon;
  final FinvuConsentRequestDetailInfo accountInfo;
  final List<FinvuLinkedAccountDetailsInfo> detailInfo;
  final String mobile;
  // final String consentHandleId;
  final List<BankConnectionItem> fipIdList;
  ApproveConsentScreen(
      {super.key,
      required this.bankName,
      required this.bankIcon,
      required this.accountInfo,
      required this.detailInfo,
      required this.mobile,
      // required this.consentHandleId,
      required this.fipIdList});

  String consentHandleId = "";

  void goBack(BuildContext context) {
    showModalBottomSheet(
        barrierColor: ConstantColor.gray_900.withOpacity(0.85),
        backgroundColor: ConstantColor.transparentColor,
        isScrollControlled: true,
        context: context,
        enableDrag: true,
        builder: (context) {
          return CloseBankConnection(onPressed: () {
            Navigator.pop(context);
            FinvuManagerInstance.denyConsentRequest(accountInfo);
            FinvuManagerInstance.logoutWithFinvu();
            FinvuManagerInstance.disconnectConnectionFinvu();
            Navigator.pop(context);
          });
        });
  }

  void approveConsent(BuildContext context) async {
    fetchUserConsentHandleId(context);
    // Future.delayed(Duration(seconds: 3));
    // FinvuProcessConsentRequestResponse approveConsent = await FinvuManagerInstance.approveConsentRequest(accountInfo, detailInfo);
    // logger.i("FINVU APPROVE CONSENT: ${approveConsent.consentIntentId}");
    // logger.i("FINVU APPROVE CONSENT: ${approveConsent.consentInfo![0].consentId}");
    // logger.i("FINVU APPROVE CONSENT: ${approveConsent.consentInfo![0].fipId}");
    //  Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder:
    //   (context)=> BankDiscoveredAccountsScreen(
    //     mobile: mobile,
    //     fipIdList: fipIdList,
    //     consentHandleId: consentHandleId,
    //     )
    //   )
    // );
    // approveConsentBackend(approveConsent.consentIntentId?? "");
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
                    padding: EdgeInsets.all(2),
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      goBack(context);
                    },
                  ),
                ),
              ),
            ]),
        body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Stack(
              children: [
                ListView(padding: EdgeInsets.only(top: 20), children: [
                  Center(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: ConstantColor.backgroundWhite,
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                          child: Text(bankName[0]),
                          height: 40,
                          width: 40,
                        )),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ConstantColor.backgroundWhite,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 8, top: 16),
                          child: Fonts.dynamicText("Purpose", 14, 500,
                              color: ConstantColor.gray_600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: Fonts.dynamicText(
                              "For customer spending habits, budget allocations, and other financial reports.",
                              14,
                              500,
                              maxLines: 2),
                        ),
                        Container(
                          height: 1,
                          color: ConstantColor.gray_100,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 8, top: 16),
                          child: Fonts.dynamicText(
                              "Consent valid for 2 years", 14, 500,
                              color: ConstantColor.gray_600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: Fonts.dynamicText(
                              "May 09, 2024 to May 09, 2026", 14, 500,
                              maxLines: 2),
                        ),
                        Container(
                          height: 1,
                          color: ConstantColor.gray_100,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 8, top: 16),
                          child: Fonts.dynamicText(
                              "Financial data fetched", 14, 500,
                              color: ConstantColor.gray_600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child:
                              Fonts.dynamicText("Daily", 14, 500, maxLines: 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ConstantColor.backgroundWhite,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 16),
                            child: Fonts.dynamicText("Note", 14, 500,
                                color: ConstantColor.gray_600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: Fonts.dynamicText(
                                "You can disconnect this account anytime from the app",
                                14,
                                500,
                                maxLines: 2),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  DataIsSecureText(),
                  AAPartnerRow(),
                  const SizedBox(
                    height: 34,
                  ),
                ]),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: PrimaryCTA(
                    buttonName: "Approve consent",
                    enabled: true,
                    onPressed: () {
                      approveConsent(context);
                    },
                    rightIcon: const Icon(
                      Iconsax.arrow_right_1,
                      color: ConstantColor.backgroundWhite,
                      size: 20.0,
                    ),
                  ),
                )
              ],
            )));
  }

  fetchUserConsentHandleId(BuildContext context) async {
    FinvuProcessConsentRequestResponse approveConsent =
        await FinvuManagerInstance.approveConsentRequest(
            accountInfo, detailInfo);

    ///generate new `HandleId` after approving consent and moving to connection screen
    consentHandleId = "";

    // final response = await http.post(Uri.parse(ConstUrl.getConsenthandleId),
    //     headers: <String, String>{
    //       'Authorization': 'Bearer $token',
    //       'Content-Type': 'application/json',
    //     },
    //     body: jsonEncode(
    //         <String, dynamic>{"phone": mobile, "consent_type": "DEPOSIT"}));

    // if (response.statusCode == 200) {
    //   Map<String, dynamic> resp = json.decode(response.body);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BankDiscoveredAccountsScreen(
                  mobile: mobile,
                  fipIdList: fipIdList,
                  consentHandleId: consentHandleId,
                )));
    // } else {
    //   throw Exception('Request Failed.');
    // }
  }

  // approveConsentBackend(String consentId,) async {
  //   String token = await Preferences.getToken();
  //   logger.i("CONSENT ID: $consentId, CONSENT HANDLE ID: $consentHandleId, MOBILE: $mobile");

  //   final response = await http.post(
  //     Uri.parse(ConstUrl.approveConsentBackend),
  //     headers: <String, String>{
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       "consent_id": consentId,
  //       "consent_handle_id": consentHandleId,
  //       "phone":mobile
  //     })
  //   );

  //   if (response.statusCode == ConstantString.STATUS_200) {
  //     Map<String, dynamic> resp = json.decode(response.body);

  //       logger.i("Finvu Backend Consent Approval Success");

  //       //   consentHandleId = resp['response']['ConsentHandle'];

  //   } else {
  //     throw Exception('Request Failed.');
  //   }
  // }
}
