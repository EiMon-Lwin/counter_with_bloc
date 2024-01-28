import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/data.dart';

part 'post_contact_state.dart';

class PostContactCubit extends Cubit<PostContactState> {
  final ContactRepository _contactRepository;
  PostContactCubit(this._contactRepository) : super(PostContactInitial());

  void addContact(Contact contact){
    emit(PostContactLoading());
    _contactRepository.addContact(contact).
    then((value) => emit(PostContactSuccess())).
    catchError((error) => emit(PostContactError(error)));
  }
}
