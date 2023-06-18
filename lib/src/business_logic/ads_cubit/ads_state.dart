part of 'ads_cubit.dart';

@immutable
abstract class AdsState {}

class AdsCubitInitial extends AdsState {}

class AdsSwitchState extends AdsState {}

class AdsPickedImageLodindState extends AdsState {}

class AdsPickedImageSuccessState extends AdsState {}

class AdsLoadingState extends AdsState {}

class AdsSuccessState extends AdsState {}

class AdsErrorState extends AdsState {}

class ChangeAdsLoadingState extends AdsState {}

class ChangeAdsSuccessState extends AdsState {}

class ChangeAdsErrorState extends AdsState {}

class DeleteAdsLoadingState extends AdsState {}

class DeleteAdsSuccessState extends AdsState {}

class DeleteAdsErrorState extends AdsState {}

class AddAdsLoadingState extends AdsState {}

class AddAdsSuccessState extends AdsState {}

class AddAdsErrorState extends AdsState {}

class UpdateAdsLoadingState extends AdsState {}

class UpdateAdsSuccessState extends AdsState {}

class UpdateAdsErrorState extends AdsState {}
