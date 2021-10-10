import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitCubit extends Cubit<String> {
  SubmitCubit() : super("");

  void onTextChange(String query) {
    emit(query);
  }
}
