// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Family Tree';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get systemMode => 'System Mode';

  @override
  String get language => 'Language';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get english => 'English';

  @override
  String get notifications => 'Notifications';

  @override
  String get emailNotifications => 'Email Notifications';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get general => 'General';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUpPrompt => 'Don\'t have an account? Sign Up';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String authenticationError(String error) {
    return 'Authentication error: $error';
  }

  @override
  String get signOut => 'Sign out';

  @override
  String get logout => 'Logout';

  @override
  String get defaultUser => 'User';

  @override
  String welcomeUser(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get noFamilyDescription =>
      'You are not part of any family tree yet. Start by creating your own family or join one via an invite link.';

  @override
  String get createMyFamily => 'Create My Family';

  @override
  String get joinViaInviteToken => 'Join via Invite Token';

  @override
  String get createFamily => 'Create family';

  @override
  String familyId(String id) {
    return 'ID: $id';
  }

  @override
  String get createNewFamily => 'Create New Family';

  @override
  String get familyName => 'Family Name';

  @override
  String get familyNameHint => 'e.g. The Smith Family';

  @override
  String get cancel => 'Cancel';

  @override
  String get create => 'Create';

  @override
  String get joinFamily => 'Join Family';

  @override
  String get inviteToken => 'Invite Token';

  @override
  String get inviteTokenHint => 'Enter the invite token';

  @override
  String get join => 'Join';

  @override
  String get successfullyJoinedFamily => 'Successfully joined family!';

  @override
  String failedToJoin(String error) {
    return 'Failed to join: $error';
  }

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get inviteMember => 'Invite Member';

  @override
  String get familyAssistant => '@family Assistant';

  @override
  String get familyChat => 'Family Chat';

  @override
  String get switchToList => 'Switch to List';

  @override
  String get switchToTree => 'Switch to Tree';

  @override
  String get refreshFamilyMembers => 'Refresh family members';

  @override
  String get noMembersFound => 'No members found in this family.';

  @override
  String get addFirstMember => 'Add First Member';

  @override
  String get showTitlesAs => 'Show titles as';

  @override
  String get addFamilyMember => 'Add family member';

  @override
  String levelValue(int level) {
    return 'Level: $level';
  }

  @override
  String parentValue(String parentId) {
    return 'Parent: $parentId';
  }

  @override
  String get selectShowTitles =>
      'Select \'Show titles as\' to see kinship titles';

  @override
  String get calculatingKinship => 'Calculating kinship title...';

  @override
  String get kinshipUnavailable => 'Kinship title unavailable';

  @override
  String kinshipResult(String title, String details) {
    return 'Kinship: $title, $details';
  }

  @override
  String get viaSpouse => 'via spouse';

  @override
  String get needsConfirmation => 'needs confirmation';

  @override
  String get addChild => 'Add Child';

  @override
  String get addMember => 'Add Member';

  @override
  String get displayName => 'Display Name';

  @override
  String parentId(String id) {
    return 'Parent ID: $id';
  }

  @override
  String get add => 'Add';

  @override
  String get shareInviteToken => 'Share this token with your family member:';

  @override
  String inviteTokenValue(String token) {
    return 'Invite token: $token';
  }

  @override
  String get tokenCopied => 'Token copied!';

  @override
  String get copy => 'Copy';

  @override
  String get close => 'Close';

  @override
  String chatTitle(String familyName) {
    return 'Chat: $familyName';
  }

  @override
  String get actingAsFamily => 'Acting as for @family';

  @override
  String get typeMessage => 'Type a message...';

  @override
  String get sendMessage => 'Send message';

  @override
  String get noMessagesYet => 'No messages yet.';

  @override
  String chatMessage(String content) {
    return 'Chat message: $content';
  }

  @override
  String get selectActingMember => 'Select an acting member for @family.';

  @override
  String get unknownUser => 'Unknown';

  @override
  String get newChat => 'New chat';

  @override
  String get familyContext => 'Family context';

  @override
  String couldNotLoadFamilies(String error) {
    return 'Could not load families: $error';
  }

  @override
  String get actingAs => 'Acting as';

  @override
  String couldNotLoadMembers(String error) {
    return 'Could not load members: $error';
  }

  @override
  String get selectFamilyAndMember => 'Select a family and acting member.';

  @override
  String get enterFamilyQuestion => 'Enter a question for @family.';

  @override
  String get aiEmptyPrompt =>
      'Ask about your selected family history or relationships.';

  @override
  String get familyThinking => '@family is thinking…';

  @override
  String get askFamilyHint => 'Ask @family…';

  @override
  String get ask => 'Ask';
}
