import 'package:mina_farid/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String appLanguage = "App Language";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language =  _sharedPreferences.getString(appLanguage);
    if (language != null) {
      return language;
    }
    return LanguageType.ENGLISH.getLanguage();
  }
}
