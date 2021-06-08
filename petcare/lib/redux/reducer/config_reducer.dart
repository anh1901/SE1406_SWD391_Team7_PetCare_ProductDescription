import 'package:redux/redux.dart';

final welcomeReducer = combineReducers<bool>([
  TypedReducer<bool, RefreshShowWelcomeAction>(_refreshWelcome),
]);
bool _refreshWelcome(bool showWelcome, action) {
  showWelcome = action.showWelcome;
  return showWelcome;
}

class RefreshShowWelcomeAction {
  final bool showWelcome;

  RefreshShowWelcomeAction(this.showWelcome);
}

final showLoginReducer = combineReducers<bool>([
  TypedReducer<bool, RefreshShowLoginAction>(_refreshShowLogin),
]);
bool _refreshShowLogin(bool showWelcome, action) {
  showWelcome = action.showWelcome;
  return showWelcome;
}

class RefreshShowLoginAction {
  final bool showLogin;

  RefreshShowLoginAction(this.showLogin);
}
