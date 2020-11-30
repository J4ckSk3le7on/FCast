import 'package:f_cast/src/extensions/string_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("isEmail extension", () {
    test("test@test.test returns true", () {
      //arrange

      //act
      var result = "test@test.test".isEmail();

      //assert
      expect(result, true);
    });

    test("test@test returns false", () {
      //arrange

      //act
      var result = "test@test".isEmail();

      //assert
      expect(result, false);
    });

    test("test.test returns false", () {
      //arrange

      //act
      var result = "test.test".isEmail();

      //assert
      expect(result, false);
    });

    test("test returns false", () {
      //arrange

      //act
      var result = "test".isEmail();

      //assert
      expect(result, false);
    });
  });
}
