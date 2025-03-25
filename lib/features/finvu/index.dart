import 'package:finvu_flutter_sdk/finvu_config.dart';
import 'package:finvu_flutter_sdk/finvu_manager.dart';
import 'package:finvu_flutter_sdk_core/finvu_consent_info.dart';
import 'package:finvu_flutter_sdk_core/finvu_discovered_accounts.dart';
import 'package:finvu_flutter_sdk_core/finvu_fip_details.dart';
import 'package:finvu_flutter_sdk_core/finvu_linked_accounts.dart';

export 'mobile_number_confirmation_screen.dart';
export 'mobile_number_otp_verification_screen.dart';
export 'bank_otp_verfication_screen.dart';
export 'bank_discovered_accounts_screen.dart';
export 'approve_consent_screen.dart';
export 'components/index.dart';

class FinvuManagerInstance {
  static final FinvuManager _instance = FinvuManager();

  // Private constructor
  FinvuManagerInstance._();

  static FinvuManager get instance => _instance;

  static void _initialize() {
    _instance.initialize(
        FinvuConfig(finvuEndpoint: "wss://webvwdev.finvu.in/consentapi"));
  }

  static void initialize() => _initialize();

  /// ====================================================================

  static void _connectFinvu() async {
    bool isConnected = await _instance.isConnected();
    if (!isConnected) {
      _instance.connect();
    }
  }

  static void connectFinvu() => _connectFinvu();

  /// ====================================================================

  static Future<String> _loginWithFinvu(
      String mobile, String consentHandleId) async {
    bool hasSession = await _instance.hasSession();
    var reference =
        await _instance.loginWithUsernameOrMobileNumberAndConsentHandle(
            "$mobile@finvu", mobile, consentHandleId);
    // otpReference = reference.reference;
    // logger.i("FINVU REFERENCE: $otpReference");
    return reference.reference;
  }

  static Future<String> loginWithFinvu(String mobile, String consentHandleId) =>
      _loginWithFinvu(mobile, consentHandleId);

  /// ====================================================================

  static void _verifyOTPFromFinvu(String otp, otpReference) {
    _instance.verifyLoginOtp(otp, otpReference);
  }

  static void verifyOTPFromFinvu(String otp, otpReference) =>
      _verifyOTPFromFinvu(otp, otpReference);

  /// ====================================================================

  static Future<List<FinvuDiscoveredAccountInfo>> _discoverAccountsFinvu(
      String mobile, String fipId) async {
    var discoveredAccounts = await _instance.discoverAccounts(
        FinvuFIPDetails(fipId: fipId, typeIdentifiers: [
          FinvuFIPFiTypeIdentifier(fiType: "DEPOSIT", identifiers: [
            FinvuTypeIdentifier(category: "STRONG", type: "MOBILE")
          ]),
        ]),
        [
          "DEPOSIT",
          "RECURRING_DEPOSIT",
          "TERM-DEPOSIT"
        ],
        [
          FinvuTypeIdentifierInfo(
              category: "STRONG", type: "MOBILE", value: mobile)
        ]);
    return discoveredAccounts;
  }

  static Future<List<FinvuDiscoveredAccountInfo>> discoverAccountsFinvu(
          String mobile, String fipId) =>
      _discoverAccountsFinvu(mobile, fipId);

  /// ====================================================================

  static Future<List<FinvuLinkedAccountDetailsInfo>>
      _fetchLinkedAccountsFinvu() async {
    var accResponse = await _instance.fetchLinkedAccounts();
    return accResponse;
  }

  static Future<List<FinvuLinkedAccountDetailsInfo>>
      fetchLinkedAccountsFinvu() => _fetchLinkedAccountsFinvu();

  /// ====================================================================

  static Future<FinvuAccountLinkingRequestReference> _linkAccounts(
      String fipId, String fiType, FinvuDiscoveredAccountInfo account) async {
    var response = await _instance.linkAccounts(
        FinvuFIPDetails(fipId: fipId, typeIdentifiers: [
          FinvuFIPFiTypeIdentifier(fiType: fiType, identifiers: [
            FinvuTypeIdentifier(
              category: "STRONG",
              type: "MOBILE",
            )
          ])
        ]),
        [account]);
    return response;
  }

  static Future<FinvuAccountLinkingRequestReference> linkAccounts(
          String fipId, String fiType, FinvuDiscoveredAccountInfo account) =>
      _linkAccounts(fipId, fiType, account);

  /// ====================================================================

  static Future<FinvuConfirmAccountLinkingInfo> _confirmAccountLinking(
    String referenceNumber,
    String otp,
  ) async {
    var response = await _instance.confirmAccountLinking(
        FinvuAccountLinkingRequestReference(referenceNumber: referenceNumber),
        otp);
    return response;
  }

  static Future<FinvuConfirmAccountLinkingInfo> confirmAccountLinking(
    String referenceNumber,
    String otp,
  ) =>
      _confirmAccountLinking(referenceNumber, otp);

  /// ====================================================================

  static Future<FinvuConsentRequestDetailInfo> _getConsentRequestDetails(
    String handleId,
  ) async {
    var response = await _instance.getConsentRequestDetails(handleId);
    return response;
  }

  static Future<FinvuConsentRequestDetailInfo> getConsentRequestDetails(
          String handleId) =>
      _getConsentRequestDetails(handleId);

  /// ====================================================================

  static Future<FinvuProcessConsentRequestResponse> _approveConsentRequest(
    FinvuConsentRequestDetailInfo consentInfo,
    List<FinvuLinkedAccountDetailsInfo> linkedAccounts,
  ) async {
    var response = _instance.approveConsentRequest(consentInfo, linkedAccounts);
    return response;
  }

  static Future<FinvuProcessConsentRequestResponse> approveConsentRequest(
    FinvuConsentRequestDetailInfo consentInfo,
    List<FinvuLinkedAccountDetailsInfo> linkedAccounts,
  ) =>
      _approveConsentRequest(consentInfo, linkedAccounts);

  /// ====================================================================

  static Future<FinvuProcessConsentRequestResponse> _denyConsentRequest(
    FinvuConsentRequestDetailInfo consentInfo,
  ) async {
    var response = await _instance.denyConsentRequest(consentInfo);
    return response;
  }

  static Future<FinvuProcessConsentRequestResponse> denyConsentRequest(
          FinvuConsentRequestDetailInfo consentInfo) =>
      _denyConsentRequest(consentInfo);

  /// ====================================================================

  static void _logoutWithFinvu() {
    _instance.logout();
  }

  static void logoutWithFinvu() => _logoutWithFinvu();

  /// ====================================================================

  static void _disconnectConnectionFinvu() {
    _instance.disconnect();
  }

  static void disconnectConnectionFinvu() => _disconnectConnectionFinvu();

  /// ====================================================================
}
