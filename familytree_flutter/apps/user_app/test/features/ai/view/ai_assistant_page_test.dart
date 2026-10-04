import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_package/data/grpc/generated/proto/ai/v1/ai.pbgrpc.dart'
    as ai_proto;
import 'package:shared_package/data/grpc/generated/proto/family/v1/family.pb.dart'
    as family_proto;
import 'package:shared_package/shared_package.dart';
import 'package:user_app/features/ai/view/ai_assistant_page.dart';
import 'package:user_app/l10n/app_localizations.dart';
import 'package:user_app/l10n/app_localizations_en.dart';

final l10n = AppLocalizationsEn();

class MockAIClient extends Mock implements ai_proto.AIServiceClient {}

class FakeResponseFuture<T> implements ResponseFuture<T> {
  final Future<T> _future;

  FakeResponseFuture.value(T value) : _future = Future.value(value);

  @override
  Future<void> cancel() async {}

  @override
  Future<Map<String, String>> get headers => Future.value({});

  @override
  Future<Map<String, String>> get trailers => Future.value({});

  @override
  Stream<T> asStream() => _future.asStream();

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      _future.catchError(onError, test: test);

  @override
  Future<S> then<S>(
    FutureOr<S> Function(T value) onValue, {
    Function? onError,
  }) => _future.then(onValue, onError: onError);

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      _future.timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) =>
      _future.whenComplete(action);
}

void main() {
  const familyId = 'family-1';
  late MockAIClient aiClient;

  setUpAll(() {
    registerFallbackValue(ai_proto.AskRequest());
  });

  setUp(() {
    clearAIChat();
    aiClient = MockAIClient();
    mockAIClientSignal.value = aiClient;
  });

  tearDown(() {
    mockAIClientSignal.value = null;
    clearAIChat();
  });

  testWidgets('asks @family and renders the response', (tester) async {
    when(() => aiClient.ask(any())).thenAnswer(
      (_) => FakeResponseFuture.value(
        ai_proto.AskResponse(answer: 'The reunion is Sunday.', final_3: true),
      ),
    );

    await pumpAssistant(tester);

    await tester.tap(find.text(l10n.actingAs));
    await tester.pumpAndSettle();
    await tester.tap(find.text('An Nguyen').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'When is the reunion?');
    await tester.tap(find.byTooltip(l10n.ask));
    await tester.pumpAndSettle();

    expect(find.text('When is the reunion?'), findsOneWidget);
    expect(find.text('The reunion is Sunday.'), findsOneWidget);
    final request =
        verify(() => aiClient.ask(captureAny())).captured.single
            as ai_proto.AskRequest;
    expect(request.familyId, familyId);
    expect(request.actingMemberId, 'member-1');
    expect(request.groupChat, isFalse);
  });

  testWidgets('shows validation feedback for an empty question', (
    tester,
  ) async {
    await pumpAssistant(tester);

    await tester.tap(find.text(l10n.actingAs));
    await tester.pumpAndSettle();
    await tester.tap(find.text('An Nguyen').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip(l10n.ask));
    await tester.pump();

    expect(find.text(l10n.enterFamilyQuestion), findsOneWidget);
    verifyNever(() => aiClient.ask(any()));
  });
}

Future<void> pumpAssistant(WidgetTester tester) async {
  const familyId = 'family-1';
  await tester.pumpWidget(
    const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: AIAssistantPage(
        initialFamilyId: familyId,
        initialFamilyName: 'Nguyen Family',
      ),
    ),
  );
  await tester.pump();

  myFamiliesSignal.value = AsyncState.data([
    family_proto.Family(id: familyId, name: 'Nguyen Family'),
  ]);
  familyMembersSignal(familyId).value = AsyncState.data([
    family_proto.Member(
      id: 'member-1',
      familyId: familyId,
      displayName: 'An Nguyen',
    ),
  ]);
  await tester.pumpAndSettle();
}
