import 'package:UncleJons/app_config.dart';
import 'package:shared_value/shared_value.dart';

final SharedValue<bool> is_logged_in = SharedValue(
  value: false, // initial value
  key: "is_logged_in",
);

final SharedValue<String?> access_token = SharedValue(
  value: "", // initial value
  key: "access_token",
);

final SharedValue<int?> user_id = SharedValue(
  value: 0, // initial value
  key: "user_id",
);

final SharedValue<String?> avatar_original = SharedValue(
  value: "", // initial value
  key: "avatar_original",
);

final SharedValue<String?> user_name = SharedValue(
  value: "", // initial value
  key: "user_name",
);

final SharedValue<String> user_email = SharedValue(
  value: "", // initial value
  key: "user_email", //
);

final SharedValue<String> user_phone = SharedValue(
  value: "", // initial value
  key: "user_phone",
);
final SharedValue<String?> app_language = SharedValue(
  value: AppConfig.default_language, // initial value
  key: "app_language",
);

final SharedValue<String?> app_mobile_language = SharedValue(
  value: AppConfig.mobile_app_code, // initial value
  key: "app_mobile_language",
);
final SharedValue<int?> system_currency = SharedValue(
  key: "system_currency", value: 0,
);

final SharedValue<bool?> app_language_rtl = SharedValue(
  value: AppConfig.app_language_rtl, // initial value
  key: "app_language_rtl",
);

// addons start

final SharedValue<bool> club_point_addon_installed = SharedValue(
  value: false, // initial value
  key: "club_point_addon_installed",
);

final SharedValue<bool> whole_sale_addon_installed = SharedValue(
  value: false, // initial value
  key: "whole_sale_addon_installed",
);

final SharedValue<bool> refund_addon_installed = SharedValue(
  value: false, // initial value
  key: "refund_addon_installed",
);

final SharedValue<bool> otp_addon_installed = SharedValue(
  value: false, // initial value
  key: "otp_addon_installed",
);
final SharedValue<bool> auction_addon_installed = SharedValue(
  value: false, // initial value
  key: "auction_addon_installed",
);
// addon end

// social login start
final SharedValue<bool> allow_google_login = SharedValue(
  value: true, // initial value
  key: "allow_google_login",
);

final SharedValue<bool> allow_facebook_login = SharedValue(
  value: true, // initial value
  key: "allow_facebook_login",
);

final SharedValue<bool> allow_twitter_login = SharedValue(
  value: true, // initial value
  key: "allow_twitter_login",
);
final SharedValue<bool> allow_apple_login = SharedValue(
  value: true, // initial value
  key: "allow_apple_login",
);
// social login end

// business setting
final SharedValue<bool> pick_up_status = SharedValue(
  value: false, // initial value
  key: "pick_up_status",
);
// business setting
final SharedValue<bool> carrier_base_shipping = SharedValue(
  value: false, // initial value
  key: "carrier_base_shipping",
);
// business setting
final SharedValue<bool> google_recaptcha = SharedValue(
  value: false, // initial value
  key: "google_recaptcha",
);

final SharedValue<bool> wallet_system_status = SharedValue(
  value: false, // initial value
  key: "wallet_system_status",
);

final SharedValue<bool> mail_verification_status = SharedValue(
  value: false, // initial value
  key: "mail_verification_status",
);

final SharedValue<bool> conversation_system_status = SharedValue(
  value: false, // initial value
  key: "conversation_system",
);
final SharedValue<bool> vendor_system = SharedValue(
  value: false, // initial value
  key: "vendor_system",
);

final SharedValue<bool> classified_product_status = SharedValue(
  value: false, // initial value
  key: "classified_product",
);
