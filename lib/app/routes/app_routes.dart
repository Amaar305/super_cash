class AppRoutes {
  static const String dashboard = '/';
  static const String auth = '/auth';
  static const String splash = '/splash';
  static const String enableBiometric = '/enable-biometric';
  static const String profile = '/profile';
  static const String profileDetails = '$profile/profile-details';
  static const String manageTransactionPin = '$profile/manage-transaction-pin';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String notFound = '/404';
  static const String changePassword = '/change-password';

  static const String airtime = '/airtime';
  static const String airtimeConfirm = '/airtime-confirm';

  static const String data = '/data';
  static const String dataConfirm = '/data-confirm';
  static const String cable = '/cable';
  static const String electricity = '/electricity';
  static const String addFunds = '/add-funds';
  static const String virtualCard = '/virtual-card';
  static const String virtualCardCreate = '$virtualCard/create';
  static const String upgradeTier = '/upgrade-tier';
  static const String virtualCardFund = '$virtualCard/fund';
  static const String virtualCardDetail = '$virtualCard/detail';
  static const String virtualCardWithdraw = '$virtualCard/card-withdraw';
  static const String virtualCardTransactions =
      '$virtualCard/card-transactions';
  static const String virtualCardChangePin = '$virtualCardDetail/change-pin';

  static const String history = '/history';
  static const String transacttionDetail = '/transaction-details';
  static const String confirmationDialog = '/confirmation-dialog';
  static const String referFriend = '/refer-friend';
  static const String examPin = '/exam-pin';
  static const String smile = '/smile';
  static const String smileProceed = '$smile/smile-proceed';
  static const String manageBeneficiary = '/manage-beneficiary';

  static const String saveBeneficiary = '$manageBeneficiary/save';
  static const String transfer = '/transfer';
  static const String generateAccount = '/generate-account';
}
