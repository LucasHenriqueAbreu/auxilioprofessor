abstract class UsecaseBase<Input, Output> {
  Future<Output> execute(Input input);
}