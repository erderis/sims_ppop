class AppApi {
  //base url
  static const baseurl = "https://take-home-test-api.nutech-integrasi.app";

  //header
  static const header = {"Accept": "application/json"};
  static const headerFile = {"Accept": "multipart/form-data"};

  // Module Membership
  static const registration = "$baseurl/registration";
  static const login = "$baseurl/login";
  static const profile = "$baseurl/profile";
  static const profileUpdate = "$profile/update";
  static const profileImage = "$profile/image";

  // Module Information
  static const banner = "$baseurl/banner";
  static const services = "$baseurl/services";

  // Module Transaction
  static const balance = "$baseurl/balance";
  static const topup = "$baseurl/topup";
  static const transaction = "$baseurl/transaction";
  static const transactionHistory = "$transaction/history";
}
