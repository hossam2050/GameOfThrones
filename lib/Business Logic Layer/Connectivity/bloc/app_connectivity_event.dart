part of 'app_connectivity_bloc.dart';

@immutable
abstract class AppConnectivityEvent {}

class ConnectedEvent extends AppConnectivityEvent {}
class NotConnectedEvent extends AppConnectivityEvent {}