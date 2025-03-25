import 'dart:convert';
import 'package:finvu_flutter_sdk_core/finvu_consent_info.dart';
import 'package:finvu_flutter_sdk_core/finvu_discovered_accounts.dart';
import 'package:finvu_flutter_sdk_core/finvu_linked_accounts.dart';
import 'package:finvu_test/features/finvu/components/constant_color.dart';
import 'package:finvu_test/features/finvu/components/fonts.dart';
import 'package:finvu_test/features/finvu/components/image_handler.dart';
import 'package:finvu_test/features/finvu/index.dart';
import 'package:finvu_test/features/finvu/mobile_number_confirmation_screen.dart';
import 'package:flutter/material.dart';

class BankDiscoveredAccountsScreen extends StatefulWidget {
  final String mobile;
  final List<BankConnectionItem> fipIdList;
  // final FinvuManager finvuManager;
  final String consentHandleId;
  const BankDiscoveredAccountsScreen({
    super.key,
    required this.mobile,
    required this.fipIdList,
    // required this.finvuManager,
    required this.consentHandleId,
  });

  @override
  State<BankDiscoveredAccountsScreen> createState() =>
      _BankDiscoveredAccountsScreenState();
}

class _BankDiscoveredAccountsScreenState
    extends State<BankDiscoveredAccountsScreen> {
  List<FinvuDiscoveredAccountInfo> discoveredAccounts = [];
  List<FinvuLinkedAccountDetailsInfo> connectedBankList = [];
  String id = "BARB0KIMXXX";
  List<BankConnectionItem> fipList = [];
  int numberOfAccounts = 0;
  // String handleIdForApproval = "";

  @override
  void initState() {
    super.initState();
    fipList = widget.fipIdList;
    Future.delayed(Duration(seconds: 1), () async {
      setDiscoveredBankList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DiscoveredBankItem> discoveredBanks = [];

  // fipList.map((e) {
  //   return DiscoveredBankItem(accountList: [],)
  // },).toList();

  // [
  //   DiscoveredBankItem(
  //     bankName: "Axis Bank",
  //     bankIcon: "Axis Bank",
  //     accountList: [
  //       DiscoveredAccounts(
  //         maskedAccountNumber: "**1212",
  //         accountType: "Savings Account",
  //         isConnected: true
  //       ),
  //       DiscoveredAccounts(
  //         maskedAccountNumber: "**3212",
  //         accountType: "Savings Account",
  //         isConnected: false
  //       )
  //     ]
  //   ),
  //    DiscoveredBankItem(
  //     bankName: "HDFC Bank",
  //     bankIcon: "HDFC Bank",
  //     accountList: [
  //       DiscoveredAccounts(
  //         maskedAccountNumber: "**1212",
  //         accountType: "Savings Account",
  //         isConnected: false
  //       ),
  //     ]
  //   ),
  // ];

  setDiscoveredBankList() async {
    List<DiscoveredBankItem> initialDiscoveredBanks = [];
    initialDiscoveredBanks = fipList.map(
      (e) {
        return DiscoveredBankItem(
            accountList: [], bankName: e.name!, bankIcon: e.name!);
      },
    ).toList();

    List<FinvuLinkedAccountDetailsInfo> initialConnectedBankList =
        await FinvuManagerInstance.fetchLinkedAccountsFinvu();

    for (int i = 0; i < widget.fipIdList.length; i++) {
      List<FinvuDiscoveredAccountInfo> innerAccList = [];
      innerAccList =
          await FinvuManagerInstance.discoverAccountsFinvu(widget.mobile, id);
      // TODO : check for blank
      var body = innerAccList
          .map(
            (element) => {
              "accountType": "SAVINGS",
              "maskedAccountNumber": element.maskedAccountNumber,
              "fiType": "DEPOSIT"
            },
          )
          .toList();

      // List<ConnectedFinvuBankResp>? bankResp = await fetchConnnectedBanks(body);

      initialDiscoveredBanks[i].accountList = innerAccList.map((element) {
        bool isAccountLinked = initialConnectedBankList.any((bank) =>
            bank.maskedAccountNumber.contains(element.maskedAccountNumber));
        bool isAccountConnected = false;
        return DiscoveredAccounts(
            accountType: element.accountType,
            maskedAccountNumber: element.maskedAccountNumber,
            fiType: element.fiType,
            fipId: id,
            accountReferenceNumber: element.accountReferenceNumber,
            isLinked: isAccountLinked,
            isConnected: isAccountConnected);
      }).toList();
    }

    setState(() {
      discoveredBanks = initialDiscoveredBanks;
      numberOfAccounts = initialDiscoveredBanks.length;
      connectedBankList = initialConnectedBankList;
    });
  }

  void _onConnectAccountButtonPressed(
      String bankName, String bankIcon, DiscoveredAccounts account) async {
    // fetchUserConsentHandleId();
    // Future.delayed(Duration(seconds: 1));

    if (account.isLinked) {
      //TODO: ADD REASON FOR THIS BEHAVIOUR AS A COMMENT

      List<FinvuLinkedAccountDetailsInfo> tempList = connectedBankList;
      setState(() {
        connectedBankList = tempList
            .where((e) => e.maskedAccountNumber == account.maskedAccountNumber)
            .toList();
      });

      FinvuConsentRequestDetailInfo info =
          await FinvuManagerInstance.getConsentRequestDetails(
              widget.consentHandleId);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ApproveConsentScreen(
                    bankName: bankName,
                    bankIcon: bankIcon,
                    accountInfo: info,
                    detailInfo: connectedBankList,
                    mobile: widget.mobile,
                    fipIdList: widget.fipIdList,
                  )));
    } else {
      // logger.i("CONNECTED BANKS: ${connectedBankList.first.fipId},LENGTH: ${connectedBankList.length}");

      FinvuAccountLinkingRequestReference reference =
          await FinvuManagerInstance.linkAccounts(
              account.fipId,
              account.fiType,
              FinvuDiscoveredAccountInfo(
                  accountType: account.accountType,
                  accountReferenceNumber: account.accountReferenceNumber,
                  maskedAccountNumber: account.maskedAccountNumber,
                  fiType: account.fiType));

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BankOtpVerificationScreen(
                    mobile: widget.mobile,
                    bankName: bankName,
                    bankIcon: bankIcon,
                    referenceNumber: reference.referenceNumber,
                    consentHandleId: widget.consentHandleId,
                    maskedAccountNumber: account.maskedAccountNumber,
                    fipIdList: widget.fipIdList,
                  )));
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: ConstantColor.backgroundWhite,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.all(2),
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => goBack,
                  ),
                ),
              ),
            ]),
        body: Stack(
          children: [
            CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ConstantColor.backgroundWhite,
                          borderRadius: BorderRadius.circular(50)),
                      child: ImageHandler(
                        image: 'assets/bank2.svg',
                        asset: true,
                        h: 40,
                        w: 40,
                        color: ConstantColor.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Fonts.dynamicText(
                      "Discovered $numberOfAccounts bank accounts",
                      18,
                      600,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 8),
                    Fonts.dynamicText(
                        "Begin by selecting at least one \naccount to proceed",
                        14,
                        500,
                        color: ConstantColor.gray_600,
                        align: TextAlign.center),
                  ],
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 30)),
              SliverPadding(
                padding: EdgeInsets.only(left: 16, right: 16),
                sliver: SliverList.separated(
                  itemCount: discoveredBanks.length,
                  itemBuilder: (context, index) {
                    DiscoveredBankItem item = discoveredBanks[index];
                    int accountListLength = item.accountList.length;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: ConstantColor.backgroundWhite,
                                  borderRadius: BorderRadius.circular(30)),
                              // TODO: Add ICON OF BANK
                              child: SizedBox(
                                child: Text(item.bankIcon[0]),
                                height: 30,
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Fonts.dynamicText(item.bankName, 18, 600),
                                Fonts.dynamicText(
                                    "Found $accountListLength ${accountListLength > 1 ? "accounts" : "account"}",
                                    12,
                                    500,
                                    color: ConstantColor.gray_600),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ...item.accountList.map((account) {
                          return Container(
                            padding: EdgeInsets.only(
                                right: 16, left: 16, top: 8, bottom: 8),
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                                color: account.isConnected
                                    ? ConstantColor.green_100
                                    : ConstantColor.backgroundWhite,
                                border: account.isConnected
                                    ? Border.all(color: ConstantColor.gray_100)
                                    : null,
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Fonts.dynamicText(
                                    "${account.accountType} ${account.maskedAccountNumber}",
                                    14,
                                    600),
                                IgnorePointer(
                                  ignoring: account.isConnected,
                                  child: TextButton(
                                      onPressed: () {
                                        _onConnectAccountButtonPressed(
                                            item.bankName,
                                            item.bankIcon,
                                            account);
                                      },
                                      child: Fonts.dynamicText(
                                          account.isConnected
                                              ? "Connected"
                                              : "+ Add",
                                          12,
                                          500,
                                          color: ConstantColor.primaryColor)),
                                )
                              ],
                            ),
                          );
                        }),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Container(height: 24),
                ),
              ),
              SliverToBoxAdapter(
                child: AAPartnerRow(),
              )
            ]),

            // Positioned(
            //   bottom: 20,
            //   right: 16,
            //   left: 16,
            //   child:
            //   AAPartnerRow()
            // )
          ],
        ));
  }
}

//   Future<List<ConnectedFinvuBankResp>?> fetchConnnectedBanks(
//       List<Map<String, dynamic>> body) async {
//     String token = await Preferences.getToken();

//     final response = await http.post(Uri.parse(ConstUrl.getConnectedFinvuBanks),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(<String, dynamic>{"discover_accounts": body}));

//     if (response.statusCode == 200) {
//       Map<String, dynamic> resp = json.decode(response.body);
//       ConnectedFinvuResponse list = ConnectedFinvuResponse.fromJson(resp);
//       return list.banks;
//     } else {
//       throw Exception('Request Failed.');
//     }
//   }
// }

class DiscoveredBankItem {
  String bankName;
  String bankIcon;
  List<DiscoveredAccounts> accountList;
  DiscoveredBankItem({
    this.bankName = "",
    this.bankIcon = "",
    this.accountList = const [],
  });
}

class DiscoveredAccounts {
  String maskedAccountNumber;
  String accountType;
  bool isConnected;
  bool isLinked;
  String fipId;
  String accountReferenceNumber;
  String fiType;

  DiscoveredAccounts(
      {this.maskedAccountNumber = "",
      this.accountType = "",
      this.isConnected = false,
      this.isLinked = false,
      this.fiType = "",
      this.fipId = "",
      this.accountReferenceNumber = ""});
}

class ConnectedFinvuResponse {
  bool status;
  List<ConnectedFinvuBankResp>? banks;

  ConnectedFinvuResponse({
    required this.status,
    this.banks,
  });

  factory ConnectedFinvuResponse.fromJson(Map<String, dynamic> json) =>
      ConnectedFinvuResponse(
        status: json['status'] ?? false,
        banks: json['response'] == null
            ? []
            : List<ConnectedFinvuBankResp>.from(json['response']
                .map((x) => ConnectedFinvuBankResp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'response': banks == null
            ? []
            : List<dynamic>.from(banks!.map((x) => x.toJson())),
      };
}

class ConnectedFinvuBankResp {
  String accountType;
  String maskedAccountNumber;
  String fiType;
  bool connection_status;

  ConnectedFinvuBankResp(
      {this.accountType = "",
      this.maskedAccountNumber = "",
      this.fiType = "",
      this.connection_status = false});

  factory ConnectedFinvuBankResp.fromJson(Map<String, dynamic> json) =>
      ConnectedFinvuBankResp(
        accountType: json['accountType'] ?? '',
        maskedAccountNumber: json['maskedAccountNumber'] ?? '',
        fiType: json['fiType'] ?? '',
        connection_status: json['connection_status'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'accountType': accountType,
        'maskedAccountNumber': maskedAccountNumber,
        'fiType': fiType,
        'connection_status': connection_status,
      };
}
