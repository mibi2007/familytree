// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(familyChatStream)
final familyChatStreamProvider = FamilyChatStreamFamily._();

final class FamilyChatStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<chat_proto.Message>,
          chat_proto.Message,
          Stream<chat_proto.Message>
        >
    with
        $FutureModifier<chat_proto.Message>,
        $StreamProvider<chat_proto.Message> {
  FamilyChatStreamProvider._({
    required FamilyChatStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'familyChatStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$familyChatStreamHash();

  @override
  String toString() {
    return r'familyChatStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<chat_proto.Message> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<chat_proto.Message> create(Ref ref) {
    final argument = this.argument as String;
    return familyChatStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FamilyChatStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$familyChatStreamHash() => r'e20a9e536604440973c90d0e5f20e01329645081';

final class FamilyChatStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<chat_proto.Message>, String> {
  FamilyChatStreamFamily._()
    : super(
        retry: null,
        name: r'familyChatStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FamilyChatStreamProvider call(String familyId) =>
      FamilyChatStreamProvider._(argument: familyId, from: this);

  @override
  String toString() => r'familyChatStreamProvider';
}

@ProviderFor(chatHistory)
final chatHistoryProvider = ChatHistoryFamily._();

final class ChatHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<chat_proto.Message>>,
          List<chat_proto.Message>,
          FutureOr<List<chat_proto.Message>>
        >
    with
        $FutureModifier<List<chat_proto.Message>>,
        $FutureProvider<List<chat_proto.Message>> {
  ChatHistoryProvider._({
    required ChatHistoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatHistoryHash();

  @override
  String toString() {
    return r'chatHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<chat_proto.Message>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<chat_proto.Message>> create(Ref ref) {
    final argument = this.argument as String;
    return chatHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatHistoryHash() => r'7aba7ff409182448a73a68555aa5223d940d5ebb';

final class ChatHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<chat_proto.Message>>, String> {
  ChatHistoryFamily._()
    : super(
        retry: null,
        name: r'chatHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatHistoryProvider call(String familyId) =>
      ChatHistoryProvider._(argument: familyId, from: this);

  @override
  String toString() => r'chatHistoryProvider';
}

@ProviderFor(MergedChatMessages)
final mergedChatMessagesProvider = MergedChatMessagesFamily._();

final class MergedChatMessagesProvider
    extends
        $AsyncNotifierProvider<MergedChatMessages, List<chat_proto.Message>> {
  MergedChatMessagesProvider._({
    required MergedChatMessagesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'mergedChatMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mergedChatMessagesHash();

  @override
  String toString() {
    return r'mergedChatMessagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MergedChatMessages create() => MergedChatMessages();

  @override
  bool operator ==(Object other) {
    return other is MergedChatMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mergedChatMessagesHash() =>
    r'f345cad3b03231350bed31a813f7d134761b6d75';

final class MergedChatMessagesFamily extends $Family
    with
        $ClassFamilyOverride<
          MergedChatMessages,
          AsyncValue<List<chat_proto.Message>>,
          List<chat_proto.Message>,
          FutureOr<List<chat_proto.Message>>,
          String
        > {
  MergedChatMessagesFamily._()
    : super(
        retry: null,
        name: r'mergedChatMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MergedChatMessagesProvider call(String familyId) =>
      MergedChatMessagesProvider._(argument: familyId, from: this);

  @override
  String toString() => r'mergedChatMessagesProvider';
}

abstract class _$MergedChatMessages
    extends $AsyncNotifier<List<chat_proto.Message>> {
  late final _$args = ref.$arg as String;
  String get familyId => _$args;

  FutureOr<List<chat_proto.Message>> build(String familyId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<chat_proto.Message>>,
              List<chat_proto.Message>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<chat_proto.Message>>,
                List<chat_proto.Message>
              >,
              AsyncValue<List<chat_proto.Message>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(ChatController)
final chatControllerProvider = ChatControllerProvider._();

final class ChatControllerProvider
    extends $AsyncNotifierProvider<ChatController, void> {
  ChatControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatControllerHash();

  @$internal
  @override
  ChatController create() => ChatController();
}

String _$chatControllerHash() => r'8d628020d09450005e9f6ddfdd72afba304baed0';

abstract class _$ChatController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
