part of 'theme_cubit.dart';

 class ThemeState extends Equatable {
  final bool isDark;
  const ThemeState({required this.isDark});

  @override
  List<Object> get props => [isDark];

  Map<String, dynamic> toJson() => {'isDark': isDark};

  factory ThemeState.fromJson(Map<String, dynamic> json) =>
      ThemeState(isDark: json['isDark'] ?? false);
}

