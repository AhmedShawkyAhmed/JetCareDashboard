import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/features/support/data/models/support_model.dart';
import 'package:jetboard/src/features/support/data/repo/support_repo.dart';
import 'package:jetboard/src/features/support/data/requests/support_comment_request.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit(this.repo) : super(SupportInitial());
  final SupportRepo repo;

  List<SupportModel>? supports;

  Future getSupport({
    String? keyword,
  }) async {
    emit(GetSupportLoading());
    var response = await repo.getSupport(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        supports = response.data;
        emit(GetSupportSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetSupportFailure());
        error.showError();
      },
    );
  }

  Future supportComment({
    required SupportCommentRequest request,
  }) async {
    emit(SupportCommentLoading());
    var response = await repo.supportComment(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (supports != null) {
          supports!
              .where((item) => item.id == request.id)
              .toList()
              .first
              .adminComment = request.comment;
        }
        emit(SupportCommentSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(SupportCommentFailure());
        error.showError();
      },
    );
  }

  Future deleteSupport({
    required int id,
  }) async {
    emit(DeleteSupportLoading());
    var response = await repo.deleteSupport(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (supports != null) {
          supports!.removeWhere((item) => item.id == id);
        }
        emit(DeleteSupportSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteSupportFailure());
        error.showError();
      },
    );
  }
}
