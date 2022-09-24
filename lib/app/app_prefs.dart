
import 'package:clean_architecture_app/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


const String prefsKeyLanguage = "prefsKeyLanguage";

class AppPreferences {

  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLanguage);
    if(language != null && language.isNotEmpty){
      return language;
    }else{
      return LanguageType.english.getValue();
    }
  }

}