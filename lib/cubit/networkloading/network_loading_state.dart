part of 'network_loading_cubit.dart';

@immutable
abstract class NetworkLoadingState {}

class NetworkLoadingInitial extends NetworkLoadingState {}
class NetworkSuccess extends NetworkLoadingState{
  NetworkSuccess(this.fetchingData);
  final List<String> fetchingData ;


}
class NetworkFailure extends NetworkLoadingState{
   final String error;
   NetworkFailure(this.error);
}
