import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'app_connectivity_event.dart';
part 'app_connectivity_state.dart';

class AppConnectivityBloc extends Bloc<AppConnectivityEvent, AppConnectivityState> {
  StreamSubscription? subscription;
  AppConnectivityBloc() : super(AppConnectivityInitial()) {
    on<AppConnectivityEvent>((event, emit) {
      if(event is ConnectedEvent){
        emit(InternetConnected(internetMessage: "Internet Connected"));
      }
      else if(event is NotConnectedEvent){
        emit(InternetNotConnected(internetMessage: "Internet Not Connected"));
      }
    });

    subscription= Connectivity().onConnectivityChanged.listen((value) {
      if(value == ConnectivityResult.wifi || value == ConnectivityResult.mobile){
        add(ConnectedEvent());
      }
      else{
        add(NotConnectedEvent());
      }
    });
  }

  @override
  Future<void> close() {
    subscription!.cancel();
    return super.close();
  }

}
