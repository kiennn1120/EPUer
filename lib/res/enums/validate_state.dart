enum ValidateEmailState {
  none,
  invalid,
  notCorrect,
}

enum ValidatePasswordState {
  none,
  invalid,
  notCorrect,
  short,
  noEmpty,
  inEmpty,
  notMatched,
  notNewPassword,
}

enum ValidateOTPState {
  none,
  invalid,
  notCorrect,
}

enum ValidatePhoneState {
  none,
  invalid,
  notCorrect,
}

enum ValidateBloodState { none, invalid }

enum ValidateState { none, invalid }

enum CompareTimeState { none, invalid }

enum ValidateCitizenIdState {
  none,
  invalid,
}
