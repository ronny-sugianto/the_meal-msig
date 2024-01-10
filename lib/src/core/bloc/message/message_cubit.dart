import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msig_food/src/src.dart';

class MessageCubit extends Cubit<Message?> {
  MessageCubit() : super(null);

  void showSnackBar({
    bool isError = false,
    required String message,
    EdgeInsets? margin,
    DateTime? timestamp,
  }) =>
      emit(Message(
        isError: isError,
        message: message,
        margin: margin,
        timestamp: timestamp,
      ));
}
