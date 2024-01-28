import 'package:bloc/bloc.dart';
import 'package:counter_with_bloc/data/data.dart';
import 'package:equatable/equatable.dart';
part 'edit_contact_state.dart';

class EditContactCubit extends Cubit<EditContactState> {
  final ContactRepository _contactRepository;
  EditContactCubit(this._contactRepository) : super(EditContactInitial());
  void editContact(String id, Contact contact){
    emit(EditContactLoading());
    _contactRepository.updateContact(id, contact).
    then((value) => emit(EditContactSuccess())).
    catchError((error)=> emit(EditContactFail(error.toString())));
  }
}
