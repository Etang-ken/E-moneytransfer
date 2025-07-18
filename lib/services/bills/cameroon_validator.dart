class CameroonPhoneValidator {
  // Network provider constants
  static const String MTN = 'MTN';
  static const String ORANGE = 'Orange';
  static const String CAMTEL = 'Camtel';

  /// Validates a phone number for Cameroonian networks
  static bool isValidCameroonPhoneNumber(
      String phoneNumber,
      {String? provider}
      ) {
    print(provider);
    // Remove any non-digit characters
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Regex patterns for different providers
    final providerPatterns = {
      MTN: RegExp(r'^(237)?((650|651|652|653|654|680|681|682|683|684)[0-9]{6}|(67[0-9]{7}))$'),
      ORANGE: RegExp(r'^(237)?((655|656|657|658|659|686|687|688|689)[0-9]{6}|(69[0-9]{7}))$'),
      CAMTEL: RegExp(r'^(237)?(621[0-9]{6}|(24|62)[0-9]{7})$'),
    };
    // If a specific provider is specified, validate against that provider
    if (provider != null) {
      return providerPatterns[provider]!.hasMatch(cleanNumber);
    }

    // If no specific provider, check against all provider patterns
    return providerPatterns.values.any((pattern) => pattern.hasMatch(cleanNumber));
  }

  /// Get the network provider for a given phone number
  static String? getNetworkProvider(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    final providerPatterns = {
      MTN: RegExp(r'^(237)?((650|651|652|653|654|680|681|682|683|684)[0-9]{6}|(67[0-9]{7}))$'),
      ORANGE: RegExp(r'^(237)?((655|656|657|658|659|686|687|688|689)[0-9]{6}|(69[0-9]{7}))$'),
      CAMTEL: RegExp(r'^(237)?(621[0-9]{6}|(24|62)[0-9]{7})$'),
    };

    // Check each provider's pattern
    for (var entry in providerPatterns.entries) {
      if (entry.value.hasMatch(cleanNumber)) {
        return entry.key;
      }
    }

    return null;
  }

  /// Format the phone number to standard format
  static String formatPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return '+237${cleanNumber.substring(cleanNumber.length - 9)}';
  }
}
