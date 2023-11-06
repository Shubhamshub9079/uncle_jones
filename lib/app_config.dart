var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text =
      "@ ActiveItZone " + this_year; //this shows in the splash screen
  static String app_name = "Active eCommerce"; //this shows in the splash screen
  static String purchase_code = "41c70d06-ab4b-415e-8eb0-176e06295cb4"; //enter your purchase code for the app from codecanyon
  //static String purchase_code = ""; //enter your purchase code for the app from codecanyon

  //Default language config
  static String default_language = "en";
  static String mobile_app_code = "en";
  static bool app_language_rtl = false;

  //configure this
  static const bool HTTPS = true;

  static const DOMAIN_PATH = "192.168.8.17/ecommerce"; //localhost

  //do not configure these below
  static const String API_ENDPATH = "mate.net.in/api/v2";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "https://mate.net.in/";
  static const String BASE_URL = "https://mate.net.in/api/v2";


  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
