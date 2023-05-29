import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_failures.freezed.dart';

@freezed
class ApiFailure<T> with _$ApiFailure<T> {
  const factory ApiFailure.clientError() = ClientError;
  const factory ApiFailure.serverError() = ApiServerError;
  const factory ApiFailure.unAuthenticated() = UnAuthenticated;
  const factory ApiFailure.subscriptionExpired() = SubscriptionExpired;
  const factory ApiFailure.ranOutMockTest() = RunOutMockTest;
}
