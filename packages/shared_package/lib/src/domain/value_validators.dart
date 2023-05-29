import 'package:fpdart/fpdart.dart';

import 'failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex = r'''^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+''';
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmailFormat(failedValue: input, reason: 'Invalid Email'));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  const minLength = 8;
  if (input.length < minLength) {
    return left(ValueFailure.shortText(failedValue: input, minLength: minLength, reason: 'The text is too short'));
  } else if (!hasDigit(input)) {
    return left(ValueFailure.noDigit(failedValue: input, reason: 'The text doesn\'t have digit'));
  } else if (!hasSpecialCharacters(input)) {
    return left(ValueFailure.noSpecial(failedValue: input, reason: 'The text doesn\'t have special characters'));
  } else if (!hasUpperCase(input)) {
    return left(ValueFailure.noUpperCase(failedValue: input, reason: 'The text doesn\'t have upper case characters'));
  } else {
    return right(input);
  }
}

bool hasDigit(String input) {
  final regExp = RegExp(r'\d');
  return regExp.hasMatch(input);
}

bool hasSpecialCharacters(String input) {
  // Regex match these characters ~!@#$%^&*_-+=`|\(){}[]:;"'<>,.?/

  final regExp = RegExp(r'''(?=.*[!@#$%^&*()~=_+}{":;'?{}/>.<,`\-|[\]])''');
  return regExp.hasMatch(input);
  // final regExp = RegExp(r'''(?=.*[!@#$%^&*()~=_+}{":;'?{}/>.<,`\-|[\]])")''');
  // return regExp.hasMatch(input);
}

bool hasUpperCase(String input) {
  final regExp = RegExp(r'[A-Z]');
  return regExp.hasMatch(input);
}

Either<ValueFailure<String>, String> validateMaxLengthString(String input, int maxLength) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure.longText(failedValue: input, maxLength: maxLength));
  }
}

Either<ValueFailure<String>, String> validateEmptyString(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.emptyValue(failedValue: input, reason: 'Empty string'));
  }
}

Either<ValueFailure<String>, String> validateMultilinesString(String input) {
  if (!input.contains('\n')) {
    return right(input);
  } else {
    return left(ValueFailure.multilines(failedValue: input));
  }
}
