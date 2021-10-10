import 'package:flutter_bloc/flutter_bloc.dart';

class AnimationCubit extends Cubit<bool> {
  AnimationCubit() : super(false);

  void enabled() => emit(true);
  void disabled() => emit(false);
}
