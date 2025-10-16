import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'NSTA Athlete'**
  String get appTitle;

  /// Main tagline on login screen
  ///
  /// In en, this message translates to:
  /// **'Discover Your Potential'**
  String get discoverYourPotential;

  /// English language label
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get english;

  /// Hindi language label
  ///
  /// In en, this message translates to:
  /// **'हिंदी'**
  String get hindi;

  /// Phone authentication mode
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Email authentication mode
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Phone number input hint
  ///
  /// In en, this message translates to:
  /// **'Phone (+91...)'**
  String get phoneHint;

  /// Email input hint
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// Password input hint
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// Loading state for sending OTP
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// Send OTP button text
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// Loading state text
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get pleaseWait;

  /// Sign in/register button text
  ///
  /// In en, this message translates to:
  /// **'Sign In / Register'**
  String get signInRegister;

  /// Link to sign up screen
  ///
  /// In en, this message translates to:
  /// **'New here? Create Account'**
  String get newHereCreateAccount;

  /// Signup screen title
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// Full name field in delete account form
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Phone number field in delete account form
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Phone number input hint
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumberHint;

  /// Email address field label
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Create account button text
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Verify OTP screen title
  ///
  /// In en, this message translates to:
  /// **'Verify {phoneNumber}'**
  String verifyPhone(String phoneNumber);

  /// OTP input hint
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// Loading state for verifying OTP
  ///
  /// In en, this message translates to:
  /// **'Verifying...'**
  String get verifying;

  /// Verify OTP button text
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// Create profile screen title
  ///
  /// In en, this message translates to:
  /// **'Create Athlete Profile'**
  String get createAthleteProfile;

  /// Age field label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// Full name input hint
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// Age input hint
  ///
  /// In en, this message translates to:
  /// **'Enter your age'**
  String get enterYourAge;

  /// Gender field label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Gender dropdown hint
  ///
  /// In en, this message translates to:
  /// **'Select your gender'**
  String get selectYourGender;

  /// Male gender option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Female gender option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Other gender option
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// Location field label
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Location detection loading state
  ///
  /// In en, this message translates to:
  /// **'Detecting city...'**
  String get detectingCity;

  /// Location input hint
  ///
  /// In en, this message translates to:
  /// **'Enter your city'**
  String get enterYourCity;

  /// Continue button text
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Account section title
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Change password option
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// Logout option
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// App preferences section title
  ///
  /// In en, this message translates to:
  /// **'App Preferences'**
  String get appPreferences;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Notifications setting
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Theme setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Data section title
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// Sync status option
  ///
  /// In en, this message translates to:
  /// **'Sync status'**
  String get syncStatus;

  /// Sync status text
  ///
  /// In en, this message translates to:
  /// **'Up to date'**
  String get upToDate;

  /// Storage used option
  ///
  /// In en, this message translates to:
  /// **'Storage used'**
  String get storageUsed;

  /// Clear cache option
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get clearCache;

  /// Info snackbar title
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// Error snackbar title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success snackbar title
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Failed snackbar title
  ///
  /// In en, this message translates to:
  /// **'Failed Due to'**
  String get failedDueTo;

  /// Validation error message
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get pleaseFillAllFields;

  /// Phone validation error
  ///
  /// In en, this message translates to:
  /// **'Enter phone + country code'**
  String get enterPhoneCountryCode;

  /// Email/password validation error
  ///
  /// In en, this message translates to:
  /// **'Enter email & password'**
  String get enterEmailPassword;

  /// User data retrieval error
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve user data'**
  String get failedToRetrieveUserData;

  /// OTP validation error
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtpError;

  /// Required fields validation error
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get pleaseFillAllRequiredFields;

  /// Success message when profile is updated
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// Location permission denied message
  ///
  /// In en, this message translates to:
  /// **'Permission Denied'**
  String get permissionDenied;

  /// Unknown location message
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Location fetch error message
  ///
  /// In en, this message translates to:
  /// **'Error fetching location'**
  String get errorFetchingLocation;

  /// No description provided for @newTest.
  ///
  /// In en, this message translates to:
  /// **'New Test'**
  String get newTest;

  /// No description provided for @verticalJump.
  ///
  /// In en, this message translates to:
  /// **'Vertical Jump'**
  String get verticalJump;

  /// No description provided for @recordJump.
  ///
  /// In en, this message translates to:
  /// **'Record Jump'**
  String get recordJump;

  /// No description provided for @startRecording.
  ///
  /// In en, this message translates to:
  /// **'Start Recording'**
  String get startRecording;

  /// No description provided for @stopAndProcess.
  ///
  /// In en, this message translates to:
  /// **'Stop & Process'**
  String get stopAndProcess;

  /// No description provided for @verticalJumpTest.
  ///
  /// In en, this message translates to:
  /// **'Vertical Jump test'**
  String get verticalJumpTest;

  /// No description provided for @positionInstruction.
  ///
  /// In en, this message translates to:
  /// **'Position yourself to match the silhouette, then start recording.'**
  String get positionInstruction;

  /// No description provided for @jump.
  ///
  /// In en, this message translates to:
  /// **'Jump: {value} cm'**
  String jump(String value);

  /// No description provided for @cm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get cm;

  /// No description provided for @jumpResult.
  ///
  /// In en, this message translates to:
  /// **'Jump Result'**
  String get jumpResult;

  /// No description provided for @measuredJump.
  ///
  /// In en, this message translates to:
  /// **'Measured jump: {value} cm'**
  String measuredJump(num value);

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @showResult.
  ///
  /// In en, this message translates to:
  /// **'Show Result'**
  String get showResult;

  /// No description provided for @shuttleRun.
  ///
  /// In en, this message translates to:
  /// **'Shuttle Run'**
  String get shuttleRun;

  /// No description provided for @enduranceRun.
  ///
  /// In en, this message translates to:
  /// **'Endurance Run'**
  String get enduranceRun;

  /// No description provided for @sitUps.
  ///
  /// In en, this message translates to:
  /// **'Sit-ups'**
  String get sitUps;

  /// No description provided for @heightWeight.
  ///
  /// In en, this message translates to:
  /// **'Height / Weight'**
  String get heightWeight;

  /// No description provided for @noUserLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'No user logged in'**
  String get noUserLoggedIn;

  /// No description provided for @userDataNotFound.
  ///
  /// In en, this message translates to:
  /// **'User data not found'**
  String get userDataNotFound;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score: {value}'**
  String score(String value);

  /// Height input hint with unit
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get heightCm;

  /// Weight input hint with unit
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightKg;

  /// Sport preference field label
  ///
  /// In en, this message translates to:
  /// **'Sport Preference (Optional)'**
  String get sportPreferenceOptional;

  /// Football sport option
  ///
  /// In en, this message translates to:
  /// **'Football'**
  String get football;

  /// Basketball sport option
  ///
  /// In en, this message translates to:
  /// **'Basketball'**
  String get basketball;

  /// Cricket sport option
  ///
  /// In en, this message translates to:
  /// **'Cricket'**
  String get cricket;

  /// No description provided for @yourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get yourProgress;

  /// No description provided for @lineChart.
  ///
  /// In en, this message translates to:
  /// **'Line Chart'**
  String get lineChart;

  /// No description provided for @testResults.
  ///
  /// In en, this message translates to:
  /// **'Test Results'**
  String get testResults;

  /// No description provided for @chartPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Chart Placeholder'**
  String get chartPlaceholder;

  /// No description provided for @searchAthletes.
  ///
  /// In en, this message translates to:
  /// **'Search athletes'**
  String get searchAthletes;

  /// No description provided for @yourHeightCm.
  ///
  /// In en, this message translates to:
  /// **'Your height (cm)'**
  String get yourHeightCm;

  /// Validation error message for missing height and weight
  ///
  /// In en, this message translates to:
  /// **'Please enter height and weight'**
  String get pleaseEnterHeightWeight;

  /// Error message when profile update fails
  ///
  /// In en, this message translates to:
  /// **'Profile update failed'**
  String get profileUpdateFailed;

  /// Height field label
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// Weight field label
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @sitAndReach.
  ///
  /// In en, this message translates to:
  /// **'Sit and Reach'**
  String get sitAndReach;

  /// No description provided for @standingVerticalJump.
  ///
  /// In en, this message translates to:
  /// **'Standing Vertical Jump'**
  String get standingVerticalJump;

  /// No description provided for @standingBroadJump.
  ///
  /// In en, this message translates to:
  /// **'Standing Broad Jump'**
  String get standingBroadJump;

  /// No description provided for @medicineBallThrow.
  ///
  /// In en, this message translates to:
  /// **'Medicine Ball Throw'**
  String get medicineBallThrow;

  /// No description provided for @thirtyMeterSprint.
  ///
  /// In en, this message translates to:
  /// **'30m Standing Start'**
  String get thirtyMeterSprint;

  /// No description provided for @fourByTenShuttleRun.
  ///
  /// In en, this message translates to:
  /// **'4 x 10m Shuttle Run'**
  String get fourByTenShuttleRun;

  /// No description provided for @moreTests.
  ///
  /// In en, this message translates to:
  /// **'More Tests'**
  String get moreTests;

  /// No description provided for @startTest.
  ///
  /// In en, this message translates to:
  /// **'Start Test'**
  String get startTest;

  /// No description provided for @watchDemo.
  ///
  /// In en, this message translates to:
  /// **'Watch Demo'**
  String get watchDemo;

  /// No description provided for @flexibility.
  ///
  /// In en, this message translates to:
  /// **'Flexibility'**
  String get flexibility;

  /// No description provided for @lowerBodyExplosiveStrength.
  ///
  /// In en, this message translates to:
  /// **'Lower Body Explosive Strength'**
  String get lowerBodyExplosiveStrength;

  /// No description provided for @upperBodyStrength.
  ///
  /// In en, this message translates to:
  /// **'Upper Body Strength'**
  String get upperBodyStrength;

  /// No description provided for @speed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// No description provided for @agility.
  ///
  /// In en, this message translates to:
  /// **'Agility'**
  String get agility;

  /// No description provided for @coreStrength.
  ///
  /// In en, this message translates to:
  /// **'Core Strength'**
  String get coreStrength;

  /// No description provided for @endurance.
  ///
  /// In en, this message translates to:
  /// **'Endurance'**
  String get endurance;

  /// No description provided for @standStraightJumpHigh.
  ///
  /// In en, this message translates to:
  /// **'Stand straight, jump as high as possible. Ensure camera captures full body.'**
  String get standStraightJumpHigh;

  /// No description provided for @sitReachInstruction.
  ///
  /// In en, this message translates to:
  /// **'Sit with legs straight, reach forward as far as possible. Hold for 3 seconds.'**
  String get sitReachInstruction;

  /// No description provided for @broadJumpInstruction.
  ///
  /// In en, this message translates to:
  /// **'Stand behind line, jump forward as far as possible with both feet together.'**
  String get broadJumpInstruction;

  /// No description provided for @medicineBallInstruction.
  ///
  /// In en, this message translates to:
  /// **'Sit with back against wall, throw medicine ball as far as possible.'**
  String get medicineBallInstruction;

  /// No description provided for @sprintInstruction.
  ///
  /// In en, this message translates to:
  /// **'Sprint 30 meters from standing start. Run in straight line.'**
  String get sprintInstruction;

  /// No description provided for @shuttleRunInstruction.
  ///
  /// In en, this message translates to:
  /// **'Run back and forth between two lines 10 meters apart, 4 times total.'**
  String get shuttleRunInstruction;

  /// No description provided for @sitUpsInstruction.
  ///
  /// In en, this message translates to:
  /// **'Lie on back, knees bent, perform sit-ups for 1 minute. Count repetitions.'**
  String get sitUpsInstruction;

  /// No description provided for @enduranceRunInstruction.
  ///
  /// In en, this message translates to:
  /// **'Run continuously for 800m (U-12) or 1.6km (12+ years). Maintain steady pace.'**
  String get enduranceRunInstruction;

  /// No description provided for @heightWeightInstruction.
  ///
  /// In en, this message translates to:
  /// **'Stand straight against wall for height. Step on scale for weight measurement.'**
  String get heightWeightInstruction;

  /// No description provided for @testDescription.
  ///
  /// In en, this message translates to:
  /// **'Test Description'**
  String get testDescription;

  /// No description provided for @qualityTested.
  ///
  /// In en, this message translates to:
  /// **'Quality Tested'**
  String get qualityTested;

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get hi;

  /// No description provided for @enduranceTest.
  ///
  /// In en, this message translates to:
  /// **'Endurance Test'**
  String get enduranceTest;

  /// No description provided for @sitUpsTest.
  ///
  /// In en, this message translates to:
  /// **'Sit-Ups Test'**
  String get sitUpsTest;

  /// No description provided for @heightWeightTest.
  ///
  /// In en, this message translates to:
  /// **'Height & Weight'**
  String get heightWeightTest;

  /// No description provided for @shuttleRunTest.
  ///
  /// In en, this message translates to:
  /// **'Shuttle Run'**
  String get shuttleRunTest;

  /// No description provided for @testScreenComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Test screen coming soon!'**
  String get testScreenComingSoon;

  /// No description provided for @demoVideoComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Demo video coming soon!'**
  String get demoVideoComingSoon;

  /// No description provided for @enterData.
  ///
  /// In en, this message translates to:
  /// **'Enter Data'**
  String get enterData;

  /// No description provided for @howToMeasure.
  ///
  /// In en, this message translates to:
  /// **'How to Measure'**
  String get howToMeasure;

  /// No description provided for @runSetDistance.
  ///
  /// In en, this message translates to:
  /// **'Run a set distance or for a specified duration to test your cardiovascular fitness. Keep the runner in frame.'**
  String get runSetDistance;

  /// No description provided for @lieDownKneesBent.
  ///
  /// In en, this message translates to:
  /// **'Lie down with your knees bent and perform as many sit-ups as you can. Keep your full body in the frame.'**
  String get lieDownKneesBent;

  /// No description provided for @enterHeightWeightAccurately.
  ///
  /// In en, this message translates to:
  /// **'Enter your height and weight accurately. This information is crucial for your athletic profile.'**
  String get enterHeightWeightAccurately;

  /// No description provided for @runBetweenMarkedPoints.
  ///
  /// In en, this message translates to:
  /// **'Run between two marked points as fast as possible. Ensure the camera captures the entire running path.'**
  String get runBetweenMarkedPoints;

  /// No description provided for @pressStartToRecord.
  ///
  /// In en, this message translates to:
  /// **'Press start to record jump'**
  String get pressStartToRecord;

  /// No description provided for @recording.
  ///
  /// In en, this message translates to:
  /// **'Recording...'**
  String get recording;

  /// No description provided for @processingVideo.
  ///
  /// In en, this message translates to:
  /// **'Processing video...'**
  String get processingVideo;

  /// No description provided for @videoProcessed.
  ///
  /// In en, this message translates to:
  /// **'Video processed!'**
  String get videoProcessed;

  /// No description provided for @maxJumpHeight.
  ///
  /// In en, this message translates to:
  /// **'Max Jump Height: {value} cm'**
  String maxJumpHeight(num value);

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @myTests.
  ///
  /// In en, this message translates to:
  /// **'My Tests'**
  String get myTests;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @sprint.
  ///
  /// In en, this message translates to:
  /// **'Sprint'**
  String get sprint;

  /// No description provided for @inches.
  ///
  /// In en, this message translates to:
  /// **'inches'**
  String get inches;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// No description provided for @global.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get global;

  /// No description provided for @ageGroup.
  ///
  /// In en, this message translates to:
  /// **'Age Group'**
  String get ageGroup;

  /// No description provided for @localCenter.
  ///
  /// In en, this message translates to:
  /// **'Local Center'**
  String get localCenter;

  /// No description provided for @athlete.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get athlete;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Edit details screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Details'**
  String get editDetails;

  /// Name field label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Name validation error message
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get nameCannotBeEmpty;

  /// Email validation error message
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// Phone number validation error message
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhoneNumber;

  /// Success message when details are updated
  ///
  /// In en, this message translates to:
  /// **'Details updated successfully!'**
  String get detailsUpdatedSuccessfully;

  /// Sport field label
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// Sports field label
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sports;

  /// Phone number validation error
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get enterValidPhoneNumber;

  /// Age validation error message
  ///
  /// In en, this message translates to:
  /// **'Enter a valid age'**
  String get enterValidAge;

  /// Height validation error message
  ///
  /// In en, this message translates to:
  /// **'Enter a valid height'**
  String get enterValidHeight;

  /// Weight validation error message
  ///
  /// In en, this message translates to:
  /// **'Enter a valid weight'**
  String get enterValidWeight;

  /// Sports validation error message
  ///
  /// In en, this message translates to:
  /// **'Sports cannot be empty'**
  String get sportsCannotBeEmpty;

  /// Error message when loading user data fails
  ///
  /// In en, this message translates to:
  /// **'Failed to load data: {error}'**
  String failedToLoadData(String error);

  /// Error message when saving user data fails
  ///
  /// In en, this message translates to:
  /// **'Failed to save data: {error}'**
  String failedToSaveData(String error);

  /// Gender selection validation error message
  ///
  /// In en, this message translates to:
  /// **'Please select gender'**
  String get pleaseSelectGender;

  /// Profile setup screen title
  ///
  /// In en, this message translates to:
  /// **'Profile Setup'**
  String get profileSetup;

  /// Sport dropdown hint text
  ///
  /// In en, this message translates to:
  /// **'Select a sport'**
  String get selectASport;

  /// Save profile button label
  ///
  /// In en, this message translates to:
  /// **'Save & Go To Dashboard'**
  String get saveAndGoToDashboard;

  /// User Id
  ///
  /// In en, this message translates to:
  /// **'User Id'**
  String get userId;

  /// Delete account option
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// Old password field label
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Update password button text
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// Old password validation error
  ///
  /// In en, this message translates to:
  /// **'Enter old password'**
  String get enterOldPassword;

  /// Password length validation error
  ///
  /// In en, this message translates to:
  /// **'Password too short'**
  String get passwordTooShort;

  /// Password confirmation validation error
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Password update success message
  ///
  /// In en, this message translates to:
  /// **'Password updated'**
  String get passwordUpdated;

  /// Delete account dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Account Request'**
  String get deleteAccountRequest;

  /// Reason field in delete account form
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Submit button text
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Name validation error in delete account form
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// Email validation error in delete account form
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// Phone number validation error in delete account form
  ///
  /// In en, this message translates to:
  /// **'Enter your number'**
  String get enterYourNumber;

  /// Reason validation error in delete account form
  ///
  /// In en, this message translates to:
  /// **'Enter reason'**
  String get enterReason;

  /// Delete request success message
  ///
  /// In en, this message translates to:
  /// **'Delete request submitted'**
  String get deleteRequestSubmitted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
