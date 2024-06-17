import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/features/home/data/models/home_statistics_model.dart';
import 'package:jetboard/src/features/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(HomeInitial());

  HomeRepo repo;

  HomeStatisticsModel homeStatisticsModel = HomeStatisticsModel();

  Future getStatistics({
    String? month,
    String? year,
  }) async {
    emit(StatisticsLoading());
    var response = await repo.getStatistics(
      month: month,
      year: year,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        homeStatisticsModel = response.data;
        emit(StatisticsSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(StatisticsFailure());
      },
    );
  }
}
