import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmailFormat({
    @required T? failedValue,
    String? reason,
  }) = InvalidEmailFormat<T>;
  const factory ValueFailure.shortText({
    @required T? failedValue,
    @required int? minLength,
    String? reason,
  }) = ShortText<T>;
  const factory ValueFailure.emptyValue({@required T? failedValue, String? reason}) = EmptyValue<T>;
  const factory ValueFailure.multilines({
    @required T? failedValue,
    String? reason,
  }) = Multilines<T>;
  const factory ValueFailure.longText({
    @required T? failedValue,
    @required int? maxLength,
    String? reason,
  }) = LongText<T>;
  const factory ValueFailure.longList({
    @required T? failedValue,
    @required int? maxLength,
    String? reason,
  }) = LongList<T>;
  const factory ValueFailure.localStorage({
    @required T? failedValue,
    String? reason,
  }) = LocalStorage<T>;
  const factory ValueFailure.noDigit({
    @required T? failedValue,
    String? reason,
  }) = NoDigit<T>;
  const factory ValueFailure.noSpecial({
    @required T? failedValue,
    String? reason,
  }) = NoSpecial<T>;
  const factory ValueFailure.invalidLength({
    @required T? failedValue,
    String? reason,
  }) = InvalidLength<T>;
  const factory ValueFailure.noUpperCase({
    @required T? failedValue,
    String? reason,
  }) = NoUpperCase<T>;
}

@freezed
class ClientFailure<T> with _$ClientFailure<T> {
  const factory ClientFailure.storage() = Storage;
}
