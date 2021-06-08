import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class RefreshThemeDataAction {
  final ThemeData themeData;
  RefreshThemeDataAction(this.themeData);
}

ThemeData _refreshTheme(ThemeData themeData, action) {
  themeData = action.themeData;
  return themeData;
}

final ThemeDataReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, RefreshThemeDataAction>(_refreshTheme),
]);

class RefreshNightModalAction {
  final bool nightModal;
  RefreshNightModalAction(this.nightModal);
}

bool _refreshNight(bool nightModal, action) {
  nightModal = action.nightModal;
  return nightModal;
}

final NightModalReducer = combineReducers<bool>(
    [TypedReducer<bool, RefreshNightModalAction>(_refreshNight)]);
