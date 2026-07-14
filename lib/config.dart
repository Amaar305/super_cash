class Config {
  const Config._();
  static const bool filled = false;
}

// Toggle to allow re-submission of already-completed KYC steps.
// Set to true for testing/dev; false for production.
class KycFlags {
  const KycFlags._();
  static const bool allowKycEdit = true;
}
