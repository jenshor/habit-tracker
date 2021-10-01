part of 'edit_user_cubit.dart';

class EditUserState extends Equatable {
  final NonEmptyText name;
  final FormzStatus status;
  const EditUserState({
    this.name = const NonEmptyText.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [
        name,
        status,
      ];
}

class EditUserInitial extends EditUserState {}
