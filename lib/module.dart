import 'package:counter_with_bloc/bloc/get/cubit/get_contact_cubit.dart';
import 'package:counter_with_bloc/data/api/apiservice.dart';
import 'package:counter_with_bloc/data/contact_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
var getIt = GetIt.I;
void locator(){
  Dio dio = Dio();
  getIt.registerLazySingleton(() => dio);

  ApiService apiService = ApiService(getIt.call());
  getIt.registerLazySingleton(() => apiService);

  ContactRepository contactRepository = ContactRepository(getIt.call());
  getIt.registerLazySingleton(() => contactRepository);

  GetContactCubit getContactCubit = GetContactCubit(getIt.call());
  getIt.registerLazySingleton(() => getContactCubit);


}