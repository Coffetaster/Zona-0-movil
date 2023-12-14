import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // static String baseUrl = "https://zona0.onrender.com/";
  static String baseUrl = dotenv.env["URL_BASE"] ?? "";
}