part of 'corporate_cubit.dart';

@immutable
sealed class CorporateState {}

final class CorporateInitial extends CorporateState {}

class GetCorporateOrdersLoading extends CorporateState {}
class GetCorporateOrdersSuccess extends CorporateState {}
class GetCorporateOrdersFailure extends CorporateState {}

class AddCorporateOrderLoading extends CorporateState {}
class AddCorporateOrderSuccess extends CorporateState {}
class AddCorporateOrderFailure extends CorporateState {}

class AdminCommentLoading extends CorporateState {}
class AdminCommentSuccess extends CorporateState {}
class AdminCommentFailure extends CorporateState {}

class ContactCorporateLoading extends CorporateState {}
class ContactCorporateSuccess extends CorporateState {}
class ContactCorporateFailure extends CorporateState {}
