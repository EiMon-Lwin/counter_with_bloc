part of 'edit_contact_cubit.dart';

abstract class EditContactState extends Equatable{}

class EditContactInitial extends EditContactState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
class EditContactLoading extends EditContactState{
  @override
  List<Object?> get props => [];
}

class EditContactSuccess extends EditContactState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class EditContactFail extends EditContactState{
  final  String error;
  EditContactFail(this.error);
  @override
  List<Object?> get props => [error];
}

