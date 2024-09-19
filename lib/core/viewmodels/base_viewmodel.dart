
import 'package:flutter/material.dart';

import '../../consts/enums.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;

  set viewState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }

  ViewState get viewState => _viewState;
}
