
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(isDark: false));

  void themeChanges(bool isDark) {
    emit(ThemeState(isDark: isDark));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    ThemeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    state.toJson();
  }

}
