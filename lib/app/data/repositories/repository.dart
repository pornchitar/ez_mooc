abstract class IRepository<T> {
  Future<List<T>> getAll();
  Future<T?> getOne(int id);
  Future<void> insert(T t);
  Future<void> update(T t);
  Future<void> delete(T t);
}
