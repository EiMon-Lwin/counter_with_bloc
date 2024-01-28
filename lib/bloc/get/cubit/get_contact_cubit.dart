import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/contact_repository.dart';
import '../../../data/model/contact.dart';

part 'get_contact_state.dart';

class GetContactCubit extends Cubit<GetContactState> {
  final ContactRepository _contactRepository;
  GetContactCubit(this._contactRepository )
      :
        super(GetContactInitial()){
    getContact();
  }

  void getContact(){
    emit(GetContactInitial());
    _contactRepository.getContact().
    then((value) => emit(GetContactSuccess(value))
    ).catchError(
        (error)=> emit(GetContactFail(error.toString()))
    );
  }
}
