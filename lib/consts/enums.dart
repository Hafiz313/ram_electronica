enum ApiStatus { loading, completed, error }

enum ViewState { idle, busy }

enum GameFeatures {
  ballSpeed,
  shotPrecision,
  runningSpeed,
  numberOfHits,
  runningAcceleration
}

enum AppConfigEnum { noInternet }

extension AppConfigEnumStatusExt on AppConfigEnum {
  static const Map<AppConfigEnum, String> keys = {
    AppConfigEnum.noInternet: 'no_internet',
  };

  static const Map<AppConfigEnum, String> values = {
    AppConfigEnum.noInternet: 'No Internet',
  };

  String? get key => keys[this];

  String? get value => values[this];

  // NEW
  static AppConfigEnum? fromRaw(String raw) =>
      keys.entries.firstWhere((e) => e.value == raw).key;
}
