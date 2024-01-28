part of 'post_contact_cubit.dart';

@immutable
abstract class PostContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostContactInitial extends PostContactState {}
class PostContactLoading extends PostContactState{}
class PostContactSuccess extends PostContactState{}
class PostContactError extends PostContactState{
  final String error;

  PostContactError(this.error);
  @override
  List<Object?> get props => [error];
}

