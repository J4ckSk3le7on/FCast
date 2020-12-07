import 'package:f_cast/src/data/model/database/user.dart';
import 'package:f_cast/src/data/services/impl/user_service.dart';
import 'package:f_cast/src/domain/repositories/local/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  MockUserRepository mockUserRepository;
  UserService userService;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userService = UserService(mockUserRepository);
  });

  group("save user", () {
    test("When save user is called, it's passed to the repository", () async {
      //arrange
      var user = User("test", ["1"]);

      //act
      await userService.saveUser(user);

      //assert
      verify(mockUserRepository.saveUser(user)).called(1);
    });
  });

  group("get user", () {
    test("When get user is called, the result of the repository is passed",
        () async {
      //arrange
      var user = User("test", ["1"]);
      when(mockUserRepository.getUser())
          .thenAnswer((realInvocation) => Future.value(user));

      //act
      var result = await userService.getUser();

      //assert
      expect(result, user);
      verify(mockUserRepository.getUser()).called(1);
    });
  });
}
