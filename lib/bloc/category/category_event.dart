part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class GetCatetgory extends CategoryEvent {}

class SetDropdownCatetgory extends CategoryEvent {
  final String? valueData;
  SetDropdownCatetgory({this.valueData});
}
