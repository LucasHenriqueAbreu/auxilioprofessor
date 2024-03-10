abstract class NewPointState {}

class NewPointSuccessState extends NewPointState {}
class NewPointLoadingState extends NewPointState {}
class NewPointErrorState extends NewPointState {
  final Exception _error;
  Exception get error => _error;

  NewPointErrorState(Exception error) : _error = error;
}