part of 'packages_cubit.dart';

@immutable
abstract class PackagesState {}

class PackagesInitial extends PackagesState {}

class PackagesLodingState extends PackagesState {}

class PackagesSuccessState extends PackagesState {}

class PackagesErrorState extends PackagesState {}

class PackagesAddLodingState extends PackagesState {}

class PackagesAddSuccessState extends PackagesState {}

class PackagesAddErrorState extends PackagesState {}

class PackagesItemsAddLodingState extends PackagesState {}

class PackagesItemsAddSuccessState extends PackagesState {}

class PackagesItemsAddErrorState extends PackagesState {}

class PackagesDeleteLodingState extends PackagesState {}

class PackagesDeleteSuccessState extends PackagesState {}

class PackagesDeleteErrorState extends PackagesState {}

class PackagesItemsDeleteLodingState extends PackagesState {}

class PackagesItemsDeleteSuccessState extends PackagesState {}

class PackagesItemsDeleteErrorState extends PackagesState {}

class PackagesUpdateLodingState extends PackagesState {}

class PackagesUpdateSuccessState extends PackagesState {}

class PackagesUpdateErrorState extends PackagesState {}

class ChangePackagesLodingState extends PackagesState {}

class ChangePackagesSuccessState extends PackagesState {}

class ChangePackagesErrorState extends PackagesState {}

class PickedImageLodindState extends PackagesState {}

class PickedImageSuccessState extends PackagesState {}

class CategoryTypeLodingState extends PackagesState {}

class CategoryTypeSuccessState extends PackagesState {}

class CategoryTypeErrorState extends PackagesState {}

class PickedSwitchState extends PackagesState {}

class CheckedState extends PackagesState {}



class PackageLoadingState extends PackagesState {}
class PackageSuccessState extends PackagesState {}
class PackageErrorState extends PackagesState {}

