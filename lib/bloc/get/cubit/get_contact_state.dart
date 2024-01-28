part of 'get_contact_cubit.dart';

abstract class GetContactState extends Equatable{
  const GetContactState();

  @override
  List<Object?> get props => [];

}

class GetContactInitial extends GetContactState {}

class GetContactSuccess extends GetContactInitial{
  final List<Contact> contacts;
   GetContactSuccess(this.contacts);

   @override
  List<Object?> get props => [contacts];
}

class GetContactFail extends GetContactInitial{
  final String error;
  GetContactFail(this.error);

  @override
  List<Object?> get props => [error];
}