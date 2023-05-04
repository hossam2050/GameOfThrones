part of 'app_connectivity_bloc.dart';

@immutable
abstract class AppConnectivityState {}

class AppConnectivityInitial extends AppConnectivityState {}

class InternetConnected extends AppConnectivityState {
  final String? internetMessage;

  InternetConnected({this.internetMessage});

}
class InternetNotConnected extends AppConnectivityState {
  final String? internetMessage;

  InternetNotConnected({this.internetMessage});
}