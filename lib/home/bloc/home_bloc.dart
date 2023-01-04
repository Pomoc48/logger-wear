import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:log_app_wear/home/bloc/functions.dart';
import 'package:log_app_wear/models/list.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<AutoLogin>((event, emit) async {
      Map response = await getToken();

      if (response["success"]) {
        String token = response["token"];
        try {
          Map map = await getLists(token: token);
          List<ListOfItems> list = List<ListOfItems>.from(map["data"]);
          list.sort((a, b) => a.name.compareTo(b.name));

          emit(HomeLoaded(
            lists: list,
            token: map["token"],
          ));
        } catch (e) {
          emit(HomeError());
        }
      } else {
        emit(HomePinRequired());
      }
    });

    on<RequestPin>((event, emit) async {
      Map response = await createConnection();

      if (response["success"]) {
        emit(HomePinGenerated(id: response["id"], pin: response["pin"]));
      } else {
        emit(HomeError());
      }
    });

    on<QuickInsertHome>((event, emit) async {
      try {
        Map response = await addItem(
          listId: event.list.id,
          timestamp: event.timestamp,
          token: event.token,
        );

        if (response["success"]) {
          Map map = await getLists(token: response["token"]);
          List<ListOfItems> list = List<ListOfItems>.from(map["data"]);
          list.sort((a, b) => a.name.compareTo(b.name));

          emit(HomeLoaded(
            lists: list,
            token: map["token"],
          ));
        } else {
          emit(HomeError());
        }
      } catch (e) {
        emit(HomeError());
      }
    });

    on<ReportHomeError>((event, emit) {
      emit(HomeError());
    });
  }
}
