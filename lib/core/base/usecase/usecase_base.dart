abstract class UsecaseBase<Input, Output> {
  Future<Output> execute(Input input);
}

abstract class UsecaseBaseWithOutInput<Output> {
  Future<Output> execute();
}
