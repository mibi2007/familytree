// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Gia Phả';

  @override
  String get settings => 'Cài đặt';

  @override
  String get theme => 'Giao diện';

  @override
  String get lightMode => 'Chế độ Sáng';

  @override
  String get darkMode => 'Chế độ Tối';

  @override
  String get systemMode => 'Tự động theo hệ thống';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get english => 'Tiếng Anh';

  @override
  String get notifications => 'Thông báo';

  @override
  String get emailNotifications => 'Thông báo qua Email';

  @override
  String get pushNotifications => 'Thông báo đẩy';

  @override
  String get general => 'Chung';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mật khẩu';

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get signUpPrompt => 'Chưa có tài khoản? Đăng ký';

  @override
  String get signInWithGoogle => 'Đăng nhập bằng Google';

  @override
  String authenticationError(String error) {
    return 'Lỗi xác thực: $error';
  }

  @override
  String get signOut => 'Đăng xuất';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get defaultUser => 'Người dùng';

  @override
  String welcomeUser(String name) {
    return 'Chào mừng, $name!';
  }

  @override
  String get noFamilyDescription =>
      'Bạn chưa tham gia cây gia phả nào. Hãy tạo gia đình của riêng bạn hoặc tham gia bằng liên kết mời.';

  @override
  String get createMyFamily => 'Tạo gia đình của tôi';

  @override
  String get joinViaInviteToken => 'Tham gia bằng mã mời';

  @override
  String get createFamily => 'Tạo gia đình';

  @override
  String familyId(String id) {
    return 'ID: $id';
  }

  @override
  String get createNewFamily => 'Tạo gia đình mới';

  @override
  String get familyName => 'Tên gia đình';

  @override
  String get familyNameHint => 'ví dụ: Gia đình Nguyễn';

  @override
  String get cancel => 'Hủy';

  @override
  String get create => 'Tạo';

  @override
  String get joinFamily => 'Tham gia gia đình';

  @override
  String get inviteToken => 'Mã mời';

  @override
  String get inviteTokenHint => 'Nhập mã mời';

  @override
  String get join => 'Tham gia';

  @override
  String get successfullyJoinedFamily => 'Đã tham gia gia đình thành công!';

  @override
  String failedToJoin(String error) {
    return 'Không thể tham gia: $error';
  }

  @override
  String errorMessage(String error) {
    return 'Lỗi: $error';
  }

  @override
  String get inviteMember => 'Mời thành viên';

  @override
  String get familyAssistant => 'Trợ lý @family';

  @override
  String get familyChat => 'Trò chuyện gia đình';

  @override
  String get switchToList => 'Chuyển sang danh sách';

  @override
  String get switchToTree => 'Chuyển sang cây';

  @override
  String get refreshFamilyMembers => 'Làm mới thành viên gia đình';

  @override
  String get noMembersFound => 'Không tìm thấy thành viên trong gia đình này.';

  @override
  String get addFirstMember => 'Thêm thành viên đầu tiên';

  @override
  String get showTitlesAs => 'Hiển thị cách xưng hô theo';

  @override
  String get addFamilyMember => 'Thêm thành viên gia đình';

  @override
  String levelValue(int level) {
    return 'Cấp: $level';
  }

  @override
  String parentValue(String parentId) {
    return 'Cha/mẹ: $parentId';
  }

  @override
  String get selectShowTitles =>
      'Chọn \'Hiển thị cách xưng hô theo\' để xem cách xưng hô';

  @override
  String get calculatingKinship => 'Đang tính cách xưng hô...';

  @override
  String get kinshipUnavailable => 'Không có cách xưng hô';

  @override
  String kinshipResult(String title, String details) {
    return 'Quan hệ: $title, $details';
  }

  @override
  String get viaSpouse => 'qua hôn nhân';

  @override
  String get needsConfirmation => 'cần xác nhận';

  @override
  String get addChild => 'Thêm con';

  @override
  String get addMember => 'Thêm thành viên';

  @override
  String get displayName => 'Tên hiển thị';

  @override
  String parentId(String id) {
    return 'ID cha/mẹ: $id';
  }

  @override
  String get add => 'Thêm';

  @override
  String get shareInviteToken => 'Chia sẻ mã này với thành viên gia đình:';

  @override
  String inviteTokenValue(String token) {
    return 'Mã mời: $token';
  }

  @override
  String get tokenCopied => 'Đã sao chép mã!';

  @override
  String get copy => 'Sao chép';

  @override
  String get close => 'Đóng';

  @override
  String chatTitle(String familyName) {
    return 'Trò chuyện: $familyName';
  }

  @override
  String get actingAsFamily => 'Đại diện cho @family';

  @override
  String get typeMessage => 'Nhập tin nhắn...';

  @override
  String get sendMessage => 'Gửi tin nhắn';

  @override
  String get noMessagesYet => 'Chưa có tin nhắn.';

  @override
  String chatMessage(String content) {
    return 'Tin nhắn: $content';
  }

  @override
  String get selectActingMember =>
      'Chọn thành viên đại diện trước khi dùng @family.';

  @override
  String get unknownUser => 'Không rõ';

  @override
  String get newChat => 'Cuộc trò chuyện mới';

  @override
  String get familyContext => 'Ngữ cảnh gia đình';

  @override
  String couldNotLoadFamilies(String error) {
    return 'Không thể tải danh sách gia đình: $error';
  }

  @override
  String get actingAs => 'Đại diện cho';

  @override
  String couldNotLoadMembers(String error) {
    return 'Không thể tải danh sách thành viên: $error';
  }

  @override
  String get selectFamilyAndMember => 'Chọn gia đình và thành viên đại diện.';

  @override
  String get enterFamilyQuestion => 'Nhập câu hỏi cho @family.';

  @override
  String get aiEmptyPrompt =>
      'Hỏi về lịch sử hoặc mối quan hệ trong gia đình đã chọn.';

  @override
  String get familyThinking => '@family đang suy nghĩ…';

  @override
  String get askFamilyHint => 'Hỏi @family…';

  @override
  String get ask => 'Hỏi';
}
