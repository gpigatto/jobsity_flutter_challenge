import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<bool> {
  PageCubit() : super(false);

  void changePage() => emit(true);
  void reset() => emit(false);
}
