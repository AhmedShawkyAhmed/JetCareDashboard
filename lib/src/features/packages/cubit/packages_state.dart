part of 'packages_cubit.dart';

@immutable
sealed class PackagesState {}

final class PackagesInitial extends PackagesState {}

class PickedSwitchState extends PackagesState {}

class PackagePickedImageLoading extends PackagesState {}
class PackagePickedImageSuccess extends PackagesState {}

class GetPackagesLoading extends PackagesState {}
class GetPackagesSuccess extends PackagesState {}
class GetPackagesFailure extends PackagesState {}

class GetPackageDetailsLoading extends PackagesState {}
class GetPackageDetailsSuccess extends PackagesState {}
class GetPackageDetailsFailure extends PackagesState {}

class AddPackageLoading extends PackagesState {}
class AddPackageSuccess extends PackagesState {}
class AddPackageFailure extends PackagesState {}

class UpdatePackageLoading extends PackagesState {}
class UpdatePackageSuccess extends PackagesState {}
class UpdatePackageFailure extends PackagesState {}

class ChangePackageStatusLoading extends PackagesState {}
class ChangePackageStatusSuccess extends PackagesState {}
class ChangePackageStatusFailure extends PackagesState {}

class DeletePackageLoading extends PackagesState {}
class DeletePackageSuccess extends PackagesState {}
class DeletePackageFailure extends PackagesState {}

class AddPackageItemsLoading extends PackagesState {}
class AddPackageItemsSuccess extends PackagesState {}
class AddPackageItemsFailure extends PackagesState {}

class DeletePackageItemLoading extends PackagesState {}
class DeletePackageItemSuccess extends PackagesState {}
class DeletePackageItemFailure extends PackagesState {}
