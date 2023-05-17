import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit< bool> {
  ThemeCubit() : super(true);

void toggleTheme({required bool value }) {
  emit(value);
}
  @override
  fromJson(Map<String, dynamic> json) {
  return json['isDark'];
  }

  @override
  Map<String, dynamic>? toJson(state) {
  return { 'isDark' : state };
  }

}