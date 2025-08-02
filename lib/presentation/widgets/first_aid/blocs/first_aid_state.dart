part of 'first_aid_cubit.dart';

@immutable
sealed class FirstAidState {}

final class FirstAidInitial extends FirstAidState {}

final class FirstAidLoading extends FirstAidState {}

final class FirstAidAllCategoriesLoaded extends FirstAidState {
  final List<FirstAidListing> categories;

  FirstAidAllCategoriesLoaded(this.categories);

  List<FirstAidListing> get allCategories => categories;
}

final class FirstAidError extends FirstAidState {
  final String errorMessage;
  
  FirstAidError(this.errorMessage);
}
