class ElectricityValidationResult {
  final String? message;
  final ElectricityValidationContent? content;
  final Map<String, dynamic> raw;
  final double? charges;

  ElectricityValidationResult({
    this.message,
    this.content,
    required this.raw,
    required this.charges,
  });

  factory ElectricityValidationResult.fromJson(Map<String, dynamic> json) {
    final contentJson = json['content'];
    final charges = ElectricityValidationContent._toDouble(json['charges']);

    return ElectricityValidationResult(
      message: json['message']?.toString(),
      content: contentJson is Map<String, dynamic>
          ? ElectricityValidationContent.fromJson(
              Map<String, dynamic>.from(contentJson),
            )
          : null,
      raw: Map<String, dynamic>.from(json),
      charges: charges,
    );
  }
}

class ElectricityValidationContent {
  final String? customerName;
  final String? address;
  final String? customerArrears;
  final double? minPurchaseAmount;
  final String? meterNumber;
  final String? serviceBand;
  final String? canVend;
  final String? customerAccountType;
  final String? meterType;
  final bool? wrongBillersCode;
  final ElectricityCommissionDetails? commissionDetails;

  const ElectricityValidationContent({
    this.customerName,
    this.address,
    this.customerArrears,
    this.minPurchaseAmount,
    this.meterNumber,
    this.serviceBand,
    this.canVend,
    this.customerAccountType,
    this.meterType,
    this.wrongBillersCode,
    this.commissionDetails,
  });

  factory ElectricityValidationContent.fromJson(Map<String, dynamic> json) {
    return ElectricityValidationContent(
      customerName: json['Customer_Name']?.toString(),
      address: json['Address']?.toString(),
      customerArrears: json['Customer_Arrears']?.toString(),
      minPurchaseAmount: _toDouble(json['Min_Purchase_Amount']),
      meterNumber:
          json['MeterNumber']?.toString() ?? json['Meter_Number']?.toString(),
      serviceBand: json['Service_Band']?.toString(),
      canVend: json['Can_Vend']?.toString(),
      customerAccountType: json['Customer_Account_Type']?.toString(),
      meterType: json['Meter_Type']?.toString(),
      wrongBillersCode: _toBool(json['WrongBillersCode']),
      commissionDetails: json['commission_details'] is Map<String, dynamic>
          ? ElectricityCommissionDetails.fromJson(
              Map<String, dynamic>.from(json['commission_details']),
            )
          : null,
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static bool? _toBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    final text = value.toString().toLowerCase();
    return text == 'true' || text == 'yes' || text == '1';
  }
}

class ElectricityCommissionDetails {
  final double? amount;
  final double? rate;
  final String? rateType;
  final String? computationType;

  const ElectricityCommissionDetails({
    this.amount,
    this.rate,
    this.rateType,
    this.computationType,
  });

  factory ElectricityCommissionDetails.fromJson(Map<String, dynamic> json) {
    return ElectricityCommissionDetails(
      amount: ElectricityValidationContent._toDouble(json['amount']),
      rate: ElectricityValidationContent._toDouble(json['rate']),
      rateType: json['rate_type']?.toString(),
      computationType: json['computation_type']?.toString(),
    );
  }
}
