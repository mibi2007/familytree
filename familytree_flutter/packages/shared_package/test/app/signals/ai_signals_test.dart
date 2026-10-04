import 'package:flutter_test/flutter_test.dart';
import 'package:shared_package/shared_package.dart';

void main() {
  setUp(clearAIChat);

  test('detects @family mentions case-insensitively', () {
    expect(containsFamilyMention('@family help me'), isTrue);
    expect(containsFamilyMention('Hi @Family, help me'), isTrue);
    expect(containsFamilyMention('family help me'), isFalse);
  });

  test('rejects missing family context without invoking a client', () async {
    final result = await askFamilyAI(
      familyId: '',
      actingMemberId: 'member-1',
      question: 'question',
    );

    expect(result, isNull);
    expect(aiErrorSignal.value, contains('required'));
    expect(aiLoadingSignal.value, isFalse);
  });
}
