// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapsStore on _MapsStore, Store {
  final _$isLocationServiceEnabledAtom =
      Atom(name: '_MapsStore.isLocationServiceEnabled');

  @override
  bool get isLocationServiceEnabled {
    _$isLocationServiceEnabledAtom.reportRead();
    return super.isLocationServiceEnabled;
  }

  @override
  set isLocationServiceEnabled(bool value) {
    _$isLocationServiceEnabledAtom
        .reportWrite(value, super.isLocationServiceEnabled, () {
      super.isLocationServiceEnabled = value;
    });
  }

  final _$positionCurrentAtom = Atom(name: '_MapsStore.positionCurrent');

  @override
  Position get positionCurrent {
    _$positionCurrentAtom.reportRead();
    return super.positionCurrent;
  }

  @override
  set positionCurrent(Position value) {
    _$positionCurrentAtom.reportWrite(value, super.positionCurrent, () {
      super.positionCurrent = value;
    });
  }

  final _$_cameraPositionCurrentAtom =
      Atom(name: '_MapsStore._cameraPositionCurrent');

  @override
  CameraPosition get _cameraPositionCurrent {
    _$_cameraPositionCurrentAtom.reportRead();
    return super._cameraPositionCurrent;
  }

  @override
  set _cameraPositionCurrent(CameraPosition value) {
    _$_cameraPositionCurrentAtom
        .reportWrite(value, super._cameraPositionCurrent, () {
      super._cameraPositionCurrent = value;
    });
  }

  @override
  String toString() {
    return '''
isLocationServiceEnabled: ${isLocationServiceEnabled},
positionCurrent: ${positionCurrent}
    ''';
  }
}
