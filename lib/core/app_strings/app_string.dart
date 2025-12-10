class AppStrings {
  AppStrings._();

  static const String appName = 'Super Cash';
  static const String appTagline = 'Secure payments made simple.';
  static const String createAccount = 'Create an Account';
  static const String verifyAccount = 'Verification';
  static const String verifyAccountInstruction =
      'Please enter the code sent to {maskemail} or spam folder';

  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String emailAddress = 'Email Address';
  static const String phoneNumber = 'Phone Number';
  static const String password = 'Password';
  static const String newPassword = 'New Password';
  static const String passwordConfirmation = 'Confirm Password';

  static const String login = 'Login';
  static const String signUp = 'Create Account';
  static const String authenticate = 'Authenticate';
  static const String forgotPassword = 'Forgot Password?';
  static const String alreadyHaveAnAccount =
      'Already have an existing account? ';
  static const String dontHaveAnAccount = 'Don\'t have an account? ';
  static const String resetPassword = 'Reset Password';
  static const String resetPasswordInstructions =
      'Enter your email address and we will send you a link to reset your password';
  static const String resetPasswordSuccess =
      'Password reset email sent. Check your email for further instructions.';
  static const String resetPasswordFailed =
      'Failed to send password reset email. Please try again later.';
  static const String passwordReset = 'Password Reset';
  static const String passwordResetSuccess =
      'Your Password has been reset successfully!';

  static const String nameInstruction =
      'Input Your first name as in your Government ID';

  static const String lastnameInstruction =
      'Input Your last name as in your Government ID';

  static const String termsAndPrivacy =
      'By continuing I indicate that I have read and agreed to the ';
  static const String termsOfService = ' Terms of Service';
  static const String privacyPolicy = 'Privacy Policy ';
  static const String and = 'and';

  static const String invalidEmail = 'Invalid email address';
  static const String invalidPhoneNumber = 'Invalid phone number';
  static const String invalidPassword =
      'Password must be at least 6 characters';
  static const String invalidPasswordConfirmation = 'Passwords do not match';
  static const String invalidFirstName = 'First name is required';
  static const String invalidLastName = 'Last name is required';

  static const String loginFailed = 'Login failed. Please try again';
  static const String loginSuccess = 'Login successful';
  static const String signUpFailed = 'Sign up failed. Please try again';
  static const String signUpSuccess = 'Sign up successful';
  static const String logoutSuccess = 'Logout successful';
  static const String logoutFailed = 'Logout failed. Please try again';

  static const String emailVerificationSuccess =
      'Your Email Address as been verified sucessfully. Continue to login your $appName.';

  static const String emailVerificationFailed =
      'Email verification failed. Please try again';
  static const String emailVerificationInstructions =
      'A verification email has been sent to your email address. Please verify your email address to continue';

  static const authHelp = 'Need any Assistance. ';
  static const authHelpText = 'Chat Us';

  static const succesTile = 'Successful!';

  static const String send = 'Send';

  static const String submit = 'Submit';

  static const String code = 'Code';

  static const String buyAirtime = 'Buy Airtime';
  static const String enterAmount = 'Enter Amount';

  static const String proceed = 'Proceed';

  static const String selectNetworkProvider = 'Select Network Provider';

  static const String enterBeneficiaryPhoneNumber =
      'Enter Beneficiary Phone Number';

  static const String fundWallet = 'Fund Wallet';
  static String transfer = 'Transfer';
  static String virtualCard = 'Virtual Card';

  static const String homeNavBarItemLabel = 'Home';

  static const String history = 'History';

  static const String liveChatNavBarItemLabel = 'Live Chat';

  static const String profileNavBarItemLabel = 'Account';

  static const String enterPin = 'Enter Pin';
  static const String purchaseInstructions =
      'Kindly verify your purchase before proceeding with payment';

  static const String goBackTitle = 'Are you sure you want to go back?';

  static const String goBackDescrption =
      'If you go back now, you\'ll loose all the edits you\'v made.';
  static const String cancel = 'Cancel';
  static const String goBack = 'Go back';

  static const String buyData = 'Buy Data';

  static const String selectDataType = 'Select Data Type';
  static const String selectPlan = 'Select a plan';

  static const String beneficiary = 'Beneficiary';
  static const String forMySelf = 'For Myself';
  static const String contact = 'Contact';

  static const String createNewVirtualCard = 'Create new Virtual Card';
  static const String createVirtualCard = 'Create Virtual Card';

  static const String upgradeYourAccount = 'Upgrade Your Account';

  static const String upgradeAccountInstrucions =
      'Kindly verify and complete your KYC before proceeding to create your virtual card.';

  static const String cardType = 'Card Type';
  static const String cardBrand = 'Card Brand';
  static const String cardFeatures = 'Card Features';
  static const List<String> cardFeaturesList = [
    'Globally Acceptable',
    'All Platforms',
    'Fast and Reliable',
    'International Transactions',
  ];
  static const String cardTermsOfUsage = 'Card Terms of Usage';
  static const List<String> cardTermsOfUsagesList = [
    'A card would be deleted after 15 consecutive declines due to insufficient balance on the 15th decline.',
    'Card must have a minimum available balance of \$1.',
    'A card without a transaction for three (3) months will eventually get deleted.',
    'The card will be deactivated if the monthly maintenance charge is not paid.',
    '1% Transaction fee applies with a minimum of \$1 and maximum of \$5.',
    'The monthly spending limit for this card is \$5,000',
  ];

  static const String enterAmountToFundCard =
      'Enter Amount to fund card in \$ USD? (minimum of \$1)';

  static const String setCardPin = 'Setup Card Pin';
  static const String confirmCardPin = 'Confirm Card Pin';

  static const String setYourCardPin = 'Set up your Card';

  static const String costAndCharges = 'Cost & Charges';

  static const String createCard = 'Create Card';

  static const String cardSupports = 'Card Support';

  static const String cardPaymentValidation = 'Payment Verification';

  static const String fundCard = 'Fund Card';

  static const String transactionFee = 'Transaction Fee';

  static const String cardDetails = 'Card Details';

  static const String billingAddress = 'Billing Address';

  static const String yesContinue = 'Yes, Continue';

  static const String freezCardDescription =
      'Are you sure you want to freeze your Card? By freezing your card you cannot be able to make payments with the card.';
  static const String unfreezeCardDescription =
      'Are you sure you want to unfreeze your Card? By unfreezing your card you will be able to make payments with it again.';

  static const String freezCard = 'Freeze Card';
  static const String unFreezCard = 'Unfreeze Card';

  static const String done = 'Done';

  static const String cardFreezed = 'Card Frozen Successfully!';

  static const String appleProduct = 'Apple Payment';

  static const String appleProductDescription =
      'Due to Apple’s Policy on regional payment, you need to change your card billing country.';
  static const String appleProductRevertDescription =
      'Are you sure you want to change the billing address for Apple payment to default payment address?.';

  static const String yesChangeBillingAddress =
      'Yes, Change the Billing Country';

  static const String appleProductBillingDescription =
      'The Billing Country as been changed successfuly!';

  static const String iwantPayForAppleProduct =
      'I want to pay for Apple product';

  static const String changeCardPin = 'Change Card PIN';

  static const String calculateTransactionFee = 'Calculate Transaction Charges';

  static const String transactionCalculator = 'Transaction Calculator';

  static const String withdraw = 'Withdraw';

  static const String transaction = 'Transaction';

  static const String search = 'Search Reference ID, phone, etc.';
  static const String filter = 'Filter';

  static const String clear = 'Clear';

  static const String period = 'Period';

  static const String showResults = 'Show results';

  static const String selectPeriod = 'Select period';

  static const String profile = 'Profile';

  static const String accountSettings = 'Account Settings';

  static String profileDetails = 'Profile Details';

  static const String accountVerification = 'Account Verification';
  static const String changePassword = 'Change Password';
  static const String manageTransactionPin = 'Manage Transaction Pin';
  static const String legalAndOthers = 'Legal and Others';

  static const String myReferrals = 'My Referrals';
  static const String logout = 'Logout';
  static const String deleteAccount = 'Delete Account';

  static const String joinedDate = 'Joined Date';
  static const String referralCode = 'Referral Code';
  static const String kycStatus = 'KYC Status';
  static const String accountStatus = 'Account Status';
  static const String referralCount = 'Referals Count';

  static const String changeTransactionPin = 'Change Transaction Pin';
  static const String changeTransactionPinSubtitle =
      'Edit your Transaction pin';
  static const String resetTransactionPin = 'Reset Transaction Pin';
  static const String resetTransactionPinSubtitle =
      'Reset your Transaction pin';

  static const String change = 'Change';

  static const String availableTvCable = 'Available Tv Cable';

  static const String cableSubscription = 'Cable Subscription';

  static const String cableProvider = 'Cable Provider';

  static const String cableNumber = 'Enter Decoder Number';

  static const String electricity = 'Electricity';

  static const String prepaid = 'Prepaid';

  static const String postpaid = 'Postpaid';

  static const String electricityProvider = 'Electricity Provider';

  static const String meterNumber = 'Meter Number';

  static const String referFriend = 'Refer a Friend';

  static const String totalNumberOfReferal = 'Total Number of Referral';
  static const String totalNumberOfRegistered = 'Total Register';

  static const String yourUniqueReferalLink = 'Your Unique Referral link';

  static const String copyLink = 'Copy Link';

  static const String examPin = 'Exam Pin';

  static const String paymentItem = 'Payment Item';

  static const String enterQuantity = 'Total Quantity';
  static const String totalAmount = 'Total Amount';

  static const String buy = 'Buy';

  static const String confirmation = 'Confirmation';

  static const String rateUs = 'Rate Us';

  static const String smile = 'Smile Voice';
  static const String smileVoiceAndDataBundles = 'Voice and Data Bundles';

  static const String accountNumber = 'Account Number';

  static const String enterAccountNumber = 'Enter Account Number';

  static const String purchaseSuccessfull = 'Purchase Successful!';

  static const String saveAsBeneficiary = 'Save as Beneficiary';
  static const String updateAsBeneficiary = 'Update as Beneficiary';

  static const String userName = 'User Name';

  static const String enterName = 'Enter Name';

  static const String save = 'Save';
  static const String update = 'Update';

  static const String manageBeneficiary = 'Manage Beneficiary';

  static const String edit = 'Edit';
  static const String delete = 'Delete';

  static const String warning = 'Warning!';
  static const String deleteBeneficiaryInfo =
      'Are you sure you want to delete beneficiary?!';

  static const String selectAvailableBank = 'Select Available Bank';

  static const String select = 'Select';

  static const String validate = 'Validate';

  static const String enterAmountToTransfer = 'Enter Amount to transfer';

  static String transferInstruction =
      'Kindly confirm if the details above is correct.';

  static const String upgradeTierTwo = 'Upgrade to Tier 2 (Two)';

  static const String verifyRegisteredDetails = 'Verify Registered Details';

  static const String next = 'Next';

  static const String addressVerification = 'Address Verification';

  static const String submitKycDocument = 'Submit KYC Document';

  static const String country = 'Country';

  static const String state = 'State';

  static const String city = 'City';
  static const String houseNo = 'House No.';
  static const String houseAddress = 'House Address.';
  static const String postalCode = 'Postal Code.';

  static const String submitForReview = 'Submit for Review';

  static const String selectIDType = 'Select ID Type';
  static const String bvnNumber = 'BVN Number';
  static const String selectImage = 'Selfie Image';

  static String addFunds = 'Add Funds';

  static const String proceedToPayment = 'Proceed to Payment.';

  static const String iveSentTheAmount = 'I’ve sent the money';

  static String availableBalance = 'Available Balance';

  static String rememberMe = 'Remember Me';

  static String createTransactionPin = 'Create Transaction Pin';

  static const String paste = 'Paste';

  static const String selectDurationType = 'Filter by Duration';

  static const String filterNotImplemented =
      'Filter feature is not yet implemented';

  static const String appCardName = 'Cool Card';

  static const String accountTier = 'User Tier';

  static const String otp = 'OTP';

  static String reLogin = 'Re-login';
}
