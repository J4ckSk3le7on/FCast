import 'package:f_cast/src/data/model/database/user.dart';
import 'package:f_cast/src/domain/repositories/local/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  Future<void> saveUser(User user) => _userRepository.saveUser(user);
  Future<User> getUser() => _userRepository.getUser();
}
