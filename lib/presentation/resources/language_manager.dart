
enum LanguageType { english, turkish }


const String english = "en";
const String turkish = "tr";


extension LanguageTypeExtension on LanguageType {
  String getValue(){
    switch(this){
      case LanguageType.english:
        return english;
      case LanguageType.turkish:
        return turkish;
    }
  }
}