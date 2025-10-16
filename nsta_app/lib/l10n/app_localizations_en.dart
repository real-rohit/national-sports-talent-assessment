// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'NSTA Athlete';

  @override
  String get discoverYourPotential => 'Discover Your Potential';

  @override
  String get english => 'EN';

  @override
  String get hindi => 'हिंदी';

  @override
  String get phone => 'Phone';

  @override
  String get email => 'Email';

  @override
  String get phoneHint => 'Phone (+91...)';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get sending => 'Sending...';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String get signInRegister => 'Sign In / Register';

  @override
  String get newHereCreateAccount => 'New here? Create Account';

  @override
  String get signup => 'Signup';

  @override
  String get fullName => 'Full Name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get phoneNumberHint => 'Phone number';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get createAccount => 'Create Account';

  @override
  String verifyPhone(String phoneNumber) {
    return 'Verify $phoneNumber';
  }

  @override
  String get enterOtp => 'Enter OTP';

  @override
  String get verifying => 'Verifying...';

  @override
  String get verifyOtp => 'Verify OTP';

  @override
  String get createAthleteProfile => 'Create Athlete Profile';

  @override
  String get age => 'Age';

  @override
  String get enterYourFullName => 'Enter your full name';

  @override
  String get enterYourAge => 'Enter your age';

  @override
  String get gender => 'Gender';

  @override
  String get selectYourGender => 'Select your gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get other => 'Other';

  @override
  String get location => 'Location';

  @override
  String get detectingCity => 'Detecting city...';

  @override
  String get enterYourCity => 'Enter your city';

  @override
  String get continueButton => 'Continue';

  @override
  String get settings => 'Settings';

  @override
  String get account => 'Account';

  @override
  String get changePassword => 'Change password';

  @override
  String get logout => 'Logout';

  @override
  String get appPreferences => 'App Preferences';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Notifications';

  @override
  String get theme => 'Theme';

  @override
  String get data => 'Data';

  @override
  String get syncStatus => 'Sync status';

  @override
  String get upToDate => 'Up to date';

  @override
  String get storageUsed => 'Storage used';

  @override
  String get clearCache => 'Clear cache';

  @override
  String get info => 'Info';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get failedDueTo => 'Failed Due to';

  @override
  String get pleaseFillAllFields => 'Please fill all fields';

  @override
  String get enterPhoneCountryCode => 'Enter phone + country code';

  @override
  String get enterEmailPassword => 'Enter email & password';

  @override
  String get failedToRetrieveUserData => 'Failed to retrieve user data';

  @override
  String get enterOtpError => 'Enter OTP';

  @override
  String get pleaseFillAllRequiredFields => 'Please fill all required fields';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully';

  @override
  String get permissionDenied => 'Permission Denied';

  @override
  String get unknown => 'Unknown';

  @override
  String get errorFetchingLocation => 'Error fetching location';

  @override
  String get newTest => 'New Test';

  @override
  String get verticalJump => 'Vertical Jump';

  @override
  String get recordJump => 'Record Jump';

  @override
  String get startRecording => 'Start Recording';

  @override
  String get stopAndProcess => 'Stop & Process';

  @override
  String get verticalJumpTest => 'Vertical Jump test';

  @override
  String get positionInstruction =>
      'Position yourself to match the silhouette, then start recording.';

  @override
  String jump(String value) {
    return 'Jump: $value cm';
  }

  @override
  String get cm => 'cm';

  @override
  String get jumpResult => 'Jump Result';

  @override
  String measuredJump(num value) {
    return 'Measured jump: $value cm';
  }

  @override
  String get ok => 'OK';

  @override
  String get showResult => 'Show Result';

  @override
  String get shuttleRun => 'Shuttle Run';

  @override
  String get enduranceRun => 'Endurance Run';

  @override
  String get sitUps => 'Sit-ups';

  @override
  String get heightWeight => 'Height / Weight';

  @override
  String get noUserLoggedIn => 'No user logged in';

  @override
  String get userDataNotFound => 'User data not found';

  @override
  String score(String value) {
    return 'Score: $value';
  }

  @override
  String get heightCm => 'Height (cm)';

  @override
  String get weightKg => 'Weight (kg)';

  @override
  String get sportPreferenceOptional => 'Sport Preference (Optional)';

  @override
  String get football => 'Football';

  @override
  String get basketball => 'Basketball';

  @override
  String get cricket => 'Cricket';

  @override
  String get yourProgress => 'Your Progress';

  @override
  String get lineChart => 'Line Chart';

  @override
  String get testResults => 'Test Results';

  @override
  String get chartPlaceholder => 'Chart Placeholder';

  @override
  String get searchAthletes => 'Search athletes';

  @override
  String get yourHeightCm => 'Your height (cm)';

  @override
  String get pleaseEnterHeightWeight => 'Please enter height and weight';

  @override
  String get profileUpdateFailed => 'Profile update failed';

  @override
  String get height => 'Height';

  @override
  String get weight => 'Weight';

  @override
  String get sitAndReach => 'Sit and Reach';

  @override
  String get standingVerticalJump => 'Standing Vertical Jump';

  @override
  String get standingBroadJump => 'Standing Broad Jump';

  @override
  String get medicineBallThrow => 'Medicine Ball Throw';

  @override
  String get thirtyMeterSprint => '30m Standing Start';

  @override
  String get fourByTenShuttleRun => '4 x 10m Shuttle Run';

  @override
  String get moreTests => 'More Tests';

  @override
  String get startTest => 'Start Test';

  @override
  String get watchDemo => 'Watch Demo';

  @override
  String get flexibility => 'Flexibility';

  @override
  String get lowerBodyExplosiveStrength => 'Lower Body Explosive Strength';

  @override
  String get upperBodyStrength => 'Upper Body Strength';

  @override
  String get speed => 'Speed';

  @override
  String get agility => 'Agility';

  @override
  String get coreStrength => 'Core Strength';

  @override
  String get endurance => 'Endurance';

  @override
  String get standStraightJumpHigh =>
      'Stand straight, jump as high as possible. Ensure camera captures full body.';

  @override
  String get sitReachInstruction =>
      'Sit with legs straight, reach forward as far as possible. Hold for 3 seconds.';

  @override
  String get broadJumpInstruction =>
      'Stand behind line, jump forward as far as possible with both feet together.';

  @override
  String get medicineBallInstruction =>
      'Sit with back against wall, throw medicine ball as far as possible.';

  @override
  String get sprintInstruction =>
      'Sprint 30 meters from standing start. Run in straight line.';

  @override
  String get shuttleRunInstruction =>
      'Run back and forth between two lines 10 meters apart, 4 times total.';

  @override
  String get sitUpsInstruction =>
      'Lie on back, knees bent, perform sit-ups for 1 minute. Count repetitions.';

  @override
  String get enduranceRunInstruction =>
      'Run continuously for 800m (U-12) or 1.6km (12+ years). Maintain steady pace.';

  @override
  String get heightWeightInstruction =>
      'Stand straight against wall for height. Step on scale for weight measurement.';

  @override
  String get testDescription => 'Test Description';

  @override
  String get qualityTested => 'Quality Tested';

  @override
  String get hi => 'Hi';

  @override
  String get enduranceTest => 'Endurance Test';

  @override
  String get sitUpsTest => 'Sit-Ups Test';

  @override
  String get heightWeightTest => 'Height & Weight';

  @override
  String get shuttleRunTest => 'Shuttle Run';

  @override
  String get testScreenComingSoon => 'Test screen coming soon!';

  @override
  String get demoVideoComingSoon => 'Demo video coming soon!';

  @override
  String get enterData => 'Enter Data';

  @override
  String get howToMeasure => 'How to Measure';

  @override
  String get runSetDistance =>
      'Run a set distance or for a specified duration to test your cardiovascular fitness. Keep the runner in frame.';

  @override
  String get lieDownKneesBent =>
      'Lie down with your knees bent and perform as many sit-ups as you can. Keep your full body in the frame.';

  @override
  String get enterHeightWeightAccurately =>
      'Enter your height and weight accurately. This information is crucial for your athletic profile.';

  @override
  String get runBetweenMarkedPoints =>
      'Run between two marked points as fast as possible. Ensure the camera captures the entire running path.';

  @override
  String get pressStartToRecord => 'Press start to record jump';

  @override
  String get recording => 'Recording...';

  @override
  String get processingVideo => 'Processing video...';

  @override
  String get videoProcessed => 'Video processed!';

  @override
  String maxJumpHeight(num value) {
    return 'Max Jump Height: $value cm';
  }

  @override
  String get myProfile => 'My Profile';

  @override
  String get myTests => 'My Tests';

  @override
  String get achievements => 'Achievements';

  @override
  String get id => 'ID';

  @override
  String get sprint => 'Sprint';

  @override
  String get inches => 'inches';

  @override
  String get seconds => 'seconds';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get global => 'Global';

  @override
  String get ageGroup => 'Age Group';

  @override
  String get localCenter => 'Local Center';

  @override
  String get athlete => 'Athlete';

  @override
  String get home => 'Home';

  @override
  String get editDetails => 'Edit Details';

  @override
  String get name => 'Name';

  @override
  String get save => 'Save';

  @override
  String get nameCannotBeEmpty => 'Name cannot be empty';

  @override
  String get enterValidEmail => 'Enter a valid email';

  @override
  String get invalidPhoneNumber => 'Invalid phone number';

  @override
  String get detailsUpdatedSuccessfully => 'Details updated successfully!';

  @override
  String get sport => 'Sport';

  @override
  String get sports => 'Sports';

  @override
  String get enterValidPhoneNumber => 'Enter a valid phone number';

  @override
  String get enterValidAge => 'Enter a valid age';

  @override
  String get enterValidHeight => 'Enter a valid height';

  @override
  String get enterValidWeight => 'Enter a valid weight';

  @override
  String get sportsCannotBeEmpty => 'Sports cannot be empty';

  @override
  String failedToLoadData(String error) {
    return 'Failed to load data: $error';
  }

  @override
  String failedToSaveData(String error) {
    return 'Failed to save data: $error';
  }

  @override
  String get pleaseSelectGender => 'Please select gender';

  @override
  String get profileSetup => 'Profile Setup';

  @override
  String get selectASport => 'Select a sport';

  @override
  String get saveAndGoToDashboard => 'Save & Go To Dashboard';

  @override
  String get userId => 'User Id';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get oldPassword => 'Old Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get updatePassword => 'Update Password';

  @override
  String get enterOldPassword => 'Enter old password';

  @override
  String get passwordTooShort => 'Password too short';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordUpdated => 'Password updated';

  @override
  String get deleteAccountRequest => 'Delete Account Request';

  @override
  String get reason => 'Reason';

  @override
  String get cancel => 'Cancel';

  @override
  String get submit => 'Submit';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get enterYourNumber => 'Enter your number';

  @override
  String get enterReason => 'Enter reason';

  @override
  String get deleteRequestSubmitted => 'Delete request submitted';
}
