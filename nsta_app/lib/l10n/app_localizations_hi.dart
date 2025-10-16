// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'एसआईएच एथलीट';

  @override
  String get discoverYourPotential => 'अपनी क्षमता की खोज करें';

  @override
  String get english => 'अंग्रेजी';

  @override
  String get hindi => 'हिंदी';

  @override
  String get phone => 'फोन';

  @override
  String get email => 'ईमेल';

  @override
  String get phoneHint => 'फोन (+91...)';

  @override
  String get emailHint => 'ईमेल';

  @override
  String get passwordHint => 'पासवर्ड';

  @override
  String get sending => 'भेजा जा रहा है...';

  @override
  String get sendOtp => 'OTP भेजें';

  @override
  String get pleaseWait => 'कृपया प्रतीक्षा करें...';

  @override
  String get signInRegister => 'साइन इन / रजिस्टर';

  @override
  String get newHereCreateAccount => 'नए हैं? खाता बनाएं';

  @override
  String get signup => 'साइन अप';

  @override
  String get fullName => 'पूरा नाम';

  @override
  String get phoneNumber => 'फोन नंबर';

  @override
  String get phoneNumberHint => 'फोन नंबर';

  @override
  String get emailAddress => 'ईमेल पता';

  @override
  String get password => 'पासवर्ड';

  @override
  String get createAccount => 'खाता बनाएं';

  @override
  String verifyPhone(String phoneNumber) {
    return '$phoneNumber को सत्यापित करें';
  }

  @override
  String get enterOtp => 'OTP दर्ज करें';

  @override
  String get verifying => 'सत्यापित किया जा रहा है...';

  @override
  String get verifyOtp => 'OTP सत्यापित करें';

  @override
  String get createAthleteProfile => 'एथलीट प्रोफाइल बनाएं';

  @override
  String get age => 'आयु';

  @override
  String get enterYourFullName => 'अपना पूरा नाम दर्ज करें';

  @override
  String get enterYourAge => 'अपनी आयु दर्ज करें';

  @override
  String get gender => 'लिंग';

  @override
  String get selectYourGender => 'अपना लिंग चुनें';

  @override
  String get male => 'पुरुष';

  @override
  String get female => 'महिला';

  @override
  String get other => 'अन्य';

  @override
  String get location => 'स्थान';

  @override
  String get detectingCity => 'शहर का पता लगाया जा रहा है...';

  @override
  String get enterYourCity => 'अपना शहर दर्ज करें';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get account => 'खाता';

  @override
  String get changePassword => 'पासवर्ड बदलें';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get appPreferences => 'ऐप प्राथमिकताएं';

  @override
  String get language => 'भाषा';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get theme => 'थीम';

  @override
  String get data => 'डेटा';

  @override
  String get syncStatus => 'सिंक स्थिति';

  @override
  String get upToDate => 'अद्यतित';

  @override
  String get storageUsed => 'उपयोग किया गया स्टोरेज';

  @override
  String get clearCache => 'कैश साफ़ करें';

  @override
  String get info => 'जानकारी';

  @override
  String get error => 'त्रुटि';

  @override
  String get success => 'सफलता';

  @override
  String get failedDueTo => 'असफल हुआ क्योंकि';

  @override
  String get pleaseFillAllFields => 'कृपया सभी फ़ील्ड भरें';

  @override
  String get enterPhoneCountryCode => 'फोन + देश कोड दर्ज करें';

  @override
  String get enterEmailPassword => 'ईमेल और पासवर्ड दर्ज करें';

  @override
  String get failedToRetrieveUserData =>
      'उपयोगकर्ता डेटा पुनर्प्राप्त करने में विफल';

  @override
  String get enterOtpError => 'OTP दर्ज करें';

  @override
  String get pleaseFillAllRequiredFields => 'कृपया सभी आवश्यक फ़ील्ड भरें';

  @override
  String get profileUpdatedSuccessfully => 'प्रोफाइल सफलतापूर्वक अपडेट हो गई';

  @override
  String get permissionDenied => 'अनुमति अस्वीकृत';

  @override
  String get unknown => 'अज्ञात';

  @override
  String get errorFetchingLocation => 'स्थान प्राप्त करने में त्रुटि';

  @override
  String get newTest => 'नया परीक्षण';

  @override
  String get verticalJump => 'वर्टिकल जंप';

  @override
  String get recordJump => 'जंप रिकॉर्ड करें';

  @override
  String get startRecording => 'रिकॉर्डिंग शुरू करें';

  @override
  String get stopAndProcess => 'रोकें और प्रोसेस करें';

  @override
  String get verticalJumpTest => 'वर्टिकल जंप परीक्षण';

  @override
  String get positionInstruction =>
      'सिल्हूट से मेल खाने के लिए खुद को स्थिति दें, फिर रिकॉर्डिंग शुरू करें।';

  @override
  String jump(String value) {
    return 'जंप: $value सेमी';
  }

  @override
  String get cm => 'सेमी';

  @override
  String get jumpResult => 'जंप परिणाम';

  @override
  String measuredJump(num value) {
    return 'मापा गया जंप: $value सेमी';
  }

  @override
  String get ok => 'ठीक है';

  @override
  String get showResult => 'परिणाम दिखाएं';

  @override
  String get shuttleRun => 'शटल रन';

  @override
  String get enduranceRun => 'एंड्योरेंस रन';

  @override
  String get sitUps => 'सिट-अप्स';

  @override
  String get heightWeight => 'लंबाई / वजन';

  @override
  String get noUserLoggedIn => 'कोई उपयोगकर्ता लॉग इन नहीं है';

  @override
  String get userDataNotFound => 'उपयोगकर्ता डेटा नहीं मिला';

  @override
  String score(String value) {
    return 'स्कोर: $value';
  }

  @override
  String get heightCm => 'लंबाई (सेमी)';

  @override
  String get weightKg => 'वजन (किग्रा)';

  @override
  String get sportPreferenceOptional => 'खेल वरीयता (वैकल्पिक)';

  @override
  String get football => 'फुटबॉल';

  @override
  String get basketball => 'बास्केटबॉल';

  @override
  String get cricket => 'क्रिकेट';

  @override
  String get yourProgress => 'आपकी प्रगति';

  @override
  String get lineChart => 'लाइन चार्ट';

  @override
  String get testResults => 'परीक्षण परिणाम';

  @override
  String get chartPlaceholder => 'चार्ट प्लेसहोल्डर';

  @override
  String get searchAthletes => 'एथलीट खोजें';

  @override
  String get yourHeightCm => 'आपकी लंबाई (सेमी)';

  @override
  String get pleaseEnterHeightWeight => 'कृपया लंबाई और वजन दर्ज करें';

  @override
  String get profileUpdateFailed => 'प्रोफाइल अपडेट असफल';

  @override
  String get height => 'लंबाई';

  @override
  String get weight => 'वजन';

  @override
  String get sitAndReach => 'सिट एंड रीच';

  @override
  String get standingVerticalJump => 'स्टैंडिंग वर्टिकल जंप';

  @override
  String get standingBroadJump => 'स्टैंडिंग ब्रॉड जंप';

  @override
  String get medicineBallThrow => 'मेडिसिन बॉल थ्रो';

  @override
  String get thirtyMeterSprint => '30 मीटर स्टैंडिंग स्टार्ट';

  @override
  String get fourByTenShuttleRun => '4 x 10 मीटर शटल रन';

  @override
  String get moreTests => 'अधिक परीक्षण';

  @override
  String get startTest => 'परीक्षण शुरू करें';

  @override
  String get watchDemo => 'डेमो देखें';

  @override
  String get flexibility => 'लचीलापन';

  @override
  String get lowerBodyExplosiveStrength => 'निचले शरीर की विस्फोटक शक्ति';

  @override
  String get upperBodyStrength => 'ऊपरी शरीर की शक्ति';

  @override
  String get speed => 'गति';

  @override
  String get agility => 'चपलता';

  @override
  String get coreStrength => 'कोर स्ट्रेंथ';

  @override
  String get endurance => 'सहनशीलता';

  @override
  String get standStraightJumpHigh =>
      'सीधे खड़े हों, जितना ऊंचा हो सके कूदें। कैमरा पूरे शरीर को कैप्चर करे।';

  @override
  String get sitReachInstruction =>
      'पैर सीधे करके बैठें, जितना आगे हो सके पहुंचें। 3 सेकंड तक रोकें।';

  @override
  String get broadJumpInstruction =>
      'लाइन के पीछे खड़े हों, दोनों पैरों को साथ रखकर जितना आगे हो सके कूदें।';

  @override
  String get medicineBallInstruction =>
      'दीवार के सहारे बैठें, मेडिसिन बॉल को जितना दूर हो सके फेंकें।';

  @override
  String get sprintInstruction =>
      'स्टैंडिंग स्टार्ट से 30 मीटर स्प्रिंट करें। सीधी रेखा में दौड़ें।';

  @override
  String get shuttleRunInstruction =>
      '10 मीटर की दूरी पर दो लाइनों के बीच आगे-पीछे दौड़ें, कुल 4 बार।';

  @override
  String get sitUpsInstruction =>
      'पीठ के बल लेटें, घुटने मोड़ें, 1 मिनट तक सिट-अप्स करें। दोहराव गिनें।';

  @override
  String get enduranceRunInstruction =>
      '800 मीटर (U-12) या 1.6 किमी (12+ वर्ष) तक लगातार दौड़ें। स्थिर गति बनाए रखें।';

  @override
  String get heightWeightInstruction =>
      'लंबाई के लिए दीवार के सहारे सीधे खड़े हों। वजन के लिए तराजू पर चढ़ें।';

  @override
  String get testDescription => 'परीक्षण विवरण';

  @override
  String get qualityTested => 'परीक्षित गुणवत्ता';

  @override
  String get hi => 'नमस्ते';

  @override
  String get enduranceTest => 'एंड्योरेंस टेस्ट';

  @override
  String get sitUpsTest => 'सिट-अप्स टेस्ट';

  @override
  String get heightWeightTest => 'लंबाई और वजन';

  @override
  String get shuttleRunTest => 'शटल रन';

  @override
  String get testScreenComingSoon => 'टेस्ट स्क्रीन जल्द आ रही है!';

  @override
  String get demoVideoComingSoon => 'डेमो वीडियो जल्द आ रहा है!';

  @override
  String get enterData => 'डेटा दर्ज करें';

  @override
  String get howToMeasure => 'कैसे मापें';

  @override
  String get runSetDistance =>
      'अपने हृदय संबंधी फिटनेस का परीक्षण करने के लिए निर्धारित दूरी या निर्दिष्ट अवधि तक दौड़ें। धावक को फ्रेम में रखें।';

  @override
  String get lieDownKneesBent =>
      'अपने घुटने मोड़कर लेटें और जितने सिट-अप्स कर सकें उतने करें। अपने पूरे शरीर को फ्रेम में रखें।';

  @override
  String get enterHeightWeightAccurately =>
      'अपनी लंबाई और वजन सटीक रूप से दर्ज करें। यह जानकारी आपके एथलेटिक प्रोफाइल के लिए महत्वपूर्ण है।';

  @override
  String get runBetweenMarkedPoints =>
      'जितनी तेजी से हो सके दो चिह्नित बिंदुओं के बीच दौड़ें। सुनिश्चित करें कि कैमरा पूरे दौड़ पथ को कैप्चर करे।';

  @override
  String get pressStartToRecord => 'जंप रिकॉर्ड करने के लिए स्टार्ट दबाएं';

  @override
  String get recording => 'रिकॉर्डिंग...';

  @override
  String get processingVideo => 'वीडियो प्रोसेस हो रहा है...';

  @override
  String get videoProcessed => 'वीडियो प्रोसेस हो गया!';

  @override
  String maxJumpHeight(num value) {
    return 'अधिकतम जंप ऊंचाई: $value सेमी';
  }

  @override
  String get myProfile => 'मेरा प्रोफाइल';

  @override
  String get myTests => 'मेरे परीक्षण';

  @override
  String get achievements => 'उपलब्धियां';

  @override
  String get id => 'आईडी';

  @override
  String get sprint => 'स्प्रिंट';

  @override
  String get inches => 'इंच';

  @override
  String get seconds => 'सेकंड';

  @override
  String get leaderboard => 'लीडरबोर्ड';

  @override
  String get global => 'वैश्विक';

  @override
  String get ageGroup => 'आयु समूह';

  @override
  String get localCenter => 'स्थानीय केंद्र';

  @override
  String get athlete => 'एथलीट';

  @override
  String get home => 'होम';

  @override
  String get editDetails => 'विवरण संपादित करें';

  @override
  String get name => 'नाम';

  @override
  String get save => 'सहेजें';

  @override
  String get nameCannotBeEmpty => 'नाम खाली नहीं हो सकता';

  @override
  String get enterValidEmail => 'एक वैध ईमेल दर्ज करें';

  @override
  String get invalidPhoneNumber => 'अमान्य फोन नंबर';

  @override
  String get detailsUpdatedSuccessfully => 'विवरण सफलतापूर्वक अपडेट हो गए!';

  @override
  String get sport => 'खेल';

  @override
  String get sports => 'खेल';

  @override
  String get enterValidPhoneNumber => 'एक वैध फोन नंबर दर्ज करें';

  @override
  String get enterValidAge => 'एक वैध आयु दर्ज करें';

  @override
  String get enterValidHeight => 'एक वैध लंबाई दर्ज करें';

  @override
  String get enterValidWeight => 'एक वैध वजन दर्ज करें';

  @override
  String get sportsCannotBeEmpty => 'खेल खाली नहीं हो सकता';

  @override
  String failedToLoadData(String error) {
    return 'डेटा लोड करने में विफल: $error';
  }

  @override
  String failedToSaveData(String error) {
    return 'डेटा सेव करने में विफल: $error';
  }

  @override
  String get pleaseSelectGender => 'कृपया लिंग चुनें';

  @override
  String get profileSetup => 'प्रोफाइल सेटअप';

  @override
  String get selectASport => 'एक खेल चुनें';

  @override
  String get saveAndGoToDashboard => 'सहेजें और डैशबोर्ड पर जाएं';

  @override
  String get userId => 'उपयोगकर्ता पहचान';

  @override
  String get deleteAccount => 'खाता हटाएं';

  @override
  String get oldPassword => 'पुराना पासवर्ड';

  @override
  String get newPassword => 'नया पासवर्ड';

  @override
  String get confirmPassword => 'पासवर्ड की पुष्टि करें';

  @override
  String get updatePassword => 'पासवर्ड अपडेट करें';

  @override
  String get enterOldPassword => 'पुराना पासवर्ड दर्ज करें';

  @override
  String get passwordTooShort => 'पासवर्ड बहुत छोटा है';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड मेल नहीं खाते';

  @override
  String get passwordUpdated => 'पासवर्ड अपडेट हो गया';

  @override
  String get deleteAccountRequest => 'खाता हटाने का अनुरोध';

  @override
  String get reason => 'कारण';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get submit => 'जमा करें';

  @override
  String get enterYourName => 'अपना नाम दर्ज करें';

  @override
  String get enterYourEmail => 'अपना ईमेल दर्ज करें';

  @override
  String get enterYourNumber => 'अपना नंबर दर्ज करें';

  @override
  String get enterReason => 'कारण दर्ज करें';

  @override
  String get deleteRequestSubmitted => 'हटाने का अनुरोध जमा हो गया';
}
