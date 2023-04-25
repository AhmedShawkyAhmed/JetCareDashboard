part of 'ads_cubit.dart';

@immutable
abstract class AdsState {}

class AdsCubitInitial extends AdsState {}

class AdsSwitchState extends AdsState {}

class AdsPickedImageLodindState extends AdsState {}

class AdsPickedImageSuccessState extends AdsState {}

class AdsLodingState extends AdsState {}

class AdsSuccessState extends AdsState {}

class AdsErrorState extends AdsState {}

class ChangeAdsLodingState extends AdsState {}

class ChangeAdsSuccessState extends AdsState {}

class ChangeAdsErrorState extends AdsState {}

class DeleteAdsLodingState extends AdsState {}

class DeleteAdsSuccessState extends AdsState {}

class DeleteAdsErrorState extends AdsState {}

class AddAdsLodingState extends AdsState {}

class AddAdsSuccessState extends AdsState {}

class AddAdsErrorState extends AdsState {}

class UpdateAdsLodingState extends AdsState {}

class UpdateAdsSuccessState extends AdsState {}

class UpdateAdsErrorState extends AdsState {}
