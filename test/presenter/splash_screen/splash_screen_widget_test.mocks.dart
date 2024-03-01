// Mocks generated by Mockito 5.4.4 from annotations
// in auxilioprofessor/test/presenter/splash_screen/splash_screen_widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:auxilioprofessor/application/user/get_logged_in_user_usecase.dart'
    as _i4;
import 'package:auxilioprofessor/domain/entities/user_entity.dart' as _i3;
import 'package:auxilioprofessor/domain/repositories/user_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserRepository_0 extends _i1.SmartFake
    implements _i2.UserRepository {
  _FakeUserRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUser_1 extends _i1.SmartFake implements _i3.User {
  _FakeUser_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetLoggedInUserUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetLoggedInUserUsecase extends _i1.Mock
    implements _i4.GetLoggedInUserUsecase {
  MockGetLoggedInUserUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get userRepository => (super.noSuchMethod(
        Invocation.getter(#userRepository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#userRepository),
        ),
      ) as _i2.UserRepository);

  @override
  _i5.Future<_i3.User> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i5.Future<_i3.User>.value(_FakeUser_1(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.User>);
}
