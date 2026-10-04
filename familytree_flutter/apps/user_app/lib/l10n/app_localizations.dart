import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

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
    Locale('vi'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Family Tree'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @systemMode.
  ///
  /// In en, this message translates to:
  /// **'System Mode'**
  String get systemMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @vietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUpPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get signUpPrompt;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @authenticationError.
  ///
  /// In en, this message translates to:
  /// **'Authentication error: {error}'**
  String authenticationError(String error);

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @defaultUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get defaultUser;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcomeUser(String name);

  /// No description provided for @noFamilyDescription.
  ///
  /// In en, this message translates to:
  /// **'You are not part of any family tree yet. Start by creating your own family or join one via an invite link.'**
  String get noFamilyDescription;

  /// No description provided for @createMyFamily.
  ///
  /// In en, this message translates to:
  /// **'Create My Family'**
  String get createMyFamily;

  /// No description provided for @joinViaInviteToken.
  ///
  /// In en, this message translates to:
  /// **'Join via Invite Token'**
  String get joinViaInviteToken;

  /// No description provided for @createFamily.
  ///
  /// In en, this message translates to:
  /// **'Create family'**
  String get createFamily;

  /// No description provided for @familyId.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String familyId(String id);

  /// No description provided for @createNewFamily.
  ///
  /// In en, this message translates to:
  /// **'Create New Family'**
  String get createNewFamily;

  /// No description provided for @familyName.
  ///
  /// In en, this message translates to:
  /// **'Family Name'**
  String get familyName;

  /// No description provided for @familyNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. The Smith Family'**
  String get familyNameHint;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @joinFamily.
  ///
  /// In en, this message translates to:
  /// **'Join Family'**
  String get joinFamily;

  /// No description provided for @inviteToken.
  ///
  /// In en, this message translates to:
  /// **'Invite Token'**
  String get inviteToken;

  /// No description provided for @inviteTokenHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the invite token'**
  String get inviteTokenHint;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @successfullyJoinedFamily.
  ///
  /// In en, this message translates to:
  /// **'Successfully joined family!'**
  String get successfullyJoinedFamily;

  /// No description provided for @failedToJoin.
  ///
  /// In en, this message translates to:
  /// **'Failed to join: {error}'**
  String failedToJoin(String error);

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorMessage(String error);

  /// No description provided for @inviteMember.
  ///
  /// In en, this message translates to:
  /// **'Invite Member'**
  String get inviteMember;

  /// No description provided for @familyAssistant.
  ///
  /// In en, this message translates to:
  /// **'@family Assistant'**
  String get familyAssistant;

  /// No description provided for @familyChat.
  ///
  /// In en, this message translates to:
  /// **'Family Chat'**
  String get familyChat;

  /// No description provided for @switchToList.
  ///
  /// In en, this message translates to:
  /// **'Switch to List'**
  String get switchToList;

  /// No description provided for @switchToTree.
  ///
  /// In en, this message translates to:
  /// **'Switch to Tree'**
  String get switchToTree;

  /// No description provided for @refreshFamilyMembers.
  ///
  /// In en, this message translates to:
  /// **'Refresh family members'**
  String get refreshFamilyMembers;

  /// No description provided for @noMembersFound.
  ///
  /// In en, this message translates to:
  /// **'No members found in this family.'**
  String get noMembersFound;

  /// No description provided for @addFirstMember.
  ///
  /// In en, this message translates to:
  /// **'Add First Member'**
  String get addFirstMember;

  /// No description provided for @showTitlesAs.
  ///
  /// In en, this message translates to:
  /// **'Show titles as'**
  String get showTitlesAs;

  /// No description provided for @addFamilyMember.
  ///
  /// In en, this message translates to:
  /// **'Add family member'**
  String get addFamilyMember;

  /// No description provided for @levelValue.
  ///
  /// In en, this message translates to:
  /// **'Level: {level}'**
  String levelValue(int level);

  /// No description provided for @parentValue.
  ///
  /// In en, this message translates to:
  /// **'Parent: {parentId}'**
  String parentValue(String parentId);

  /// No description provided for @selectShowTitles.
  ///
  /// In en, this message translates to:
  /// **'Select \'Show titles as\' to see kinship titles'**
  String get selectShowTitles;

  /// No description provided for @calculatingKinship.
  ///
  /// In en, this message translates to:
  /// **'Calculating kinship title...'**
  String get calculatingKinship;

  /// No description provided for @kinshipUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Kinship title unavailable'**
  String get kinshipUnavailable;

  /// No description provided for @kinshipResult.
  ///
  /// In en, this message translates to:
  /// **'Kinship: {title}, {details}'**
  String kinshipResult(String title, String details);

  /// No description provided for @viaSpouse.
  ///
  /// In en, this message translates to:
  /// **'via spouse'**
  String get viaSpouse;

  /// No description provided for @needsConfirmation.
  ///
  /// In en, this message translates to:
  /// **'needs confirmation'**
  String get needsConfirmation;

  /// No description provided for @addChild.
  ///
  /// In en, this message translates to:
  /// **'Add Child'**
  String get addChild;

  /// No description provided for @addMember.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get addMember;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @parentId.
  ///
  /// In en, this message translates to:
  /// **'Parent ID: {id}'**
  String parentId(String id);

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @shareInviteToken.
  ///
  /// In en, this message translates to:
  /// **'Share this token with your family member:'**
  String get shareInviteToken;

  /// No description provided for @inviteTokenValue.
  ///
  /// In en, this message translates to:
  /// **'Invite token: {token}'**
  String inviteTokenValue(String token);

  /// No description provided for @tokenCopied.
  ///
  /// In en, this message translates to:
  /// **'Token copied!'**
  String get tokenCopied;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat: {familyName}'**
  String chatTitle(String familyName);

  /// No description provided for @actingAsFamily.
  ///
  /// In en, this message translates to:
  /// **'Acting as for @family'**
  String get actingAsFamily;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessage;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get sendMessage;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet.'**
  String get noMessagesYet;

  /// No description provided for @chatMessage.
  ///
  /// In en, this message translates to:
  /// **'Chat message: {content}'**
  String chatMessage(String content);

  /// No description provided for @selectActingMember.
  ///
  /// In en, this message translates to:
  /// **'Select an acting member for @family.'**
  String get selectActingMember;

  /// No description provided for @unknownUser.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownUser;

  /// No description provided for @newChat.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get newChat;

  /// No description provided for @familyContext.
  ///
  /// In en, this message translates to:
  /// **'Family context'**
  String get familyContext;

  /// No description provided for @couldNotLoadFamilies.
  ///
  /// In en, this message translates to:
  /// **'Could not load families: {error}'**
  String couldNotLoadFamilies(String error);

  /// No description provided for @actingAs.
  ///
  /// In en, this message translates to:
  /// **'Acting as'**
  String get actingAs;

  /// No description provided for @couldNotLoadMembers.
  ///
  /// In en, this message translates to:
  /// **'Could not load members: {error}'**
  String couldNotLoadMembers(String error);

  /// No description provided for @selectFamilyAndMember.
  ///
  /// In en, this message translates to:
  /// **'Select a family and acting member.'**
  String get selectFamilyAndMember;

  /// No description provided for @enterFamilyQuestion.
  ///
  /// In en, this message translates to:
  /// **'Enter a question for @family.'**
  String get enterFamilyQuestion;

  /// No description provided for @aiEmptyPrompt.
  ///
  /// In en, this message translates to:
  /// **'Ask about your selected family history or relationships.'**
  String get aiEmptyPrompt;

  /// No description provided for @familyThinking.
  ///
  /// In en, this message translates to:
  /// **'@family is thinking…'**
  String get familyThinking;

  /// No description provided for @askFamilyHint.
  ///
  /// In en, this message translates to:
  /// **'Ask @family…'**
  String get askFamilyHint;

  /// No description provided for @ask.
  ///
  /// In en, this message translates to:
  /// **'Ask'**
  String get ask;
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
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
