import 'package:flutter_exam_app_tdd/location/bloc/location_bloc.dart';
import 'package:flutter_exam_app_tdd/location/usecases/location_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocationUsecase extends Mock implements LocationUsecase {}

void main() {
  LocationUsecase usecase;
  LocationBloc bloc;
  setUp(() {
    usecase = MockLocationUsecase();
    bloc = LocationBloc(usecase: usecase);
  });


}
