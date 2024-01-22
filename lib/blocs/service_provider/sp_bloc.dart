import 'package:beasy/blocs/service_provider/sp_event.dart';
import 'package:beasy/blocs/service_provider/sp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SPBloc extends Bloc<SPEvent, SPState> {
  SPBloc() : super(SPStateUninitialize()) {
    on<SPEventInitialize>((event, emit) => emit(SPStateInitialize()));
  }
}
