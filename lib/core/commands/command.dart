abstract class Command<Type, Params> {
  Future<Type> call(Params params);
}
