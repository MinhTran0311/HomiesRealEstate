// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authToken_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthTokenStore on _AuthTokenStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_AuthTokenStore.loading'))
      .value;

  final _$fetchTokenFutureAtom = Atom(name: '_AuthTokenStore.fetchTokenFuture');

  @override
  ObservableFuture<AuthToken> get fetchTokenFuture {
    _$fetchTokenFutureAtom.reportRead();
    return super.fetchTokenFuture;
  }

  @override
  set fetchTokenFuture(ObservableFuture<AuthToken> value) {
    _$fetchTokenFutureAtom.reportWrite(value, super.fetchTokenFuture, () {
      super.fetchTokenFuture = value;
    });
  }

  final _$authTokenAtom = Atom(name: '_AuthTokenStore.authToken');

  @override
  AuthToken get authToken {
    _$authTokenAtom.reportRead();
    return super.authToken;
  }

  @override
  set authToken(AuthToken value) {
    _$authTokenAtom.reportWrite(value, super.authToken, () {
      super.authToken = value;
    });
  }

  final _$loggedInAtom = Atom(name: '_AuthTokenStore.loggedIn');

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  final _$authLogInAsyncAction = AsyncAction('_AuthTokenStore.authLogIn');

  @override
  Future<dynamic> authLogIn(String username, String password) {
    return _$authLogInAsyncAction
        .run(() => super.authLogIn(username, password));
  }

  @override
  String toString() {
    return '''
fetchTokenFuture: ${fetchTokenFuture},
authToken: ${authToken},
loggedIn: ${loggedIn},
loading: ${loading}
    ''';
  }
}
