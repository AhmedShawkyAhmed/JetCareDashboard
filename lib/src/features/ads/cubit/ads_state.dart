part of 'ads_cubit.dart';

@immutable
sealed class AdsState {}

final class AdsInitial extends AdsState {}

class PickedSwitchState extends AdsState {}

class AdsPickedImageLoading extends AdsState {}
class AdsPickedImageSuccess extends AdsState {}

class GetAdsLoading extends AdsState {}
class GetAdsSuccess extends AdsState {}
class GetAdsFailure extends AdsState {}

class AddAdsLoading extends AdsState {}
class AddAdsSuccess extends AdsState {}
class AddAdsFailure extends AdsState {}

class UpdateAdsLoading extends AdsState {}
class UpdateAdsSuccess extends AdsState {}
class UpdateAdsFailure extends AdsState {}

class DeleteAdsLoading extends AdsState {}
class DeleteAdsSuccess extends AdsState {}
class DeleteAdsFailure extends AdsState {}

class ChangeStatusAdsLoading extends AdsState {}
class ChangeStatusAdsSuccess extends AdsState {}
class ChangeStatusAdsFailure extends AdsState {}
