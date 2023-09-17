enum LanguageType {ENGLISH,ARABIC}

const String ARABIC = "ar";
const String ENGLISH = "en";
const String ASSET_PATH_LOCALISATIONS = "assets/translations";


extension LanguageTypeExtension on LanguageType {
  String getValue(){
    switch (this){
      case LanguageType.ARABIC:
        return ARABIC;
      case LanguageType.ENGLISH:
        return ENGLISH;
    }
  }
}
