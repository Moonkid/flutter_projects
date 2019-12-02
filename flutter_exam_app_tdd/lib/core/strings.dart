library string;

import 'error/failure.dart';

String get serverFailureMessage => 'Failed fetching user';

String get permissionFailureMessage => 'Permission denied';

String get positionFailureMessage => 'Failed retrieving position';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case PermissionFailure:
      return permissionFailureMessage;
    case PositionFailure:
      return positionFailureMessage;
    case ServerFailure:
      return serverFailureMessage;
    default:
      return 'Unexpected Error';
  }
}
