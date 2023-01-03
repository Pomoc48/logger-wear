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

          emit(HomeLoaded(
            lists: list,
            token: map["token"],
          ));
        } catch (e) {
          emit(HomeError(token: token));
        }
      } else {
        emit(HomePinRequired());
      }
    });

    // on<RequestLogin>((event, emit) async {
    //   Map response = await manualLoginResult(
    //     username: event.username,
    //     password: event.password,
    //   );

    //   if (response["success"]) {
    //     String token = response["token"];
    //     try {
    //       Map map = await getLists(token: token);
    //       List<ListOfItems> list = List<ListOfItems>.from(map["data"]);
    //       sortList(list);

    //       emit(HomeLoaded(
    //         lists: list,
    //         token: map["token"],
    //         sort: getSortType(),
    //       ));
    //     } catch (e) {
    //       emit(HomeError(token: token));
    //     }
    //   } else {
    //     emit(HomeMessage(response["message"]));
    //   }
    // });

    on<UpdateHome>((event, emit) {
      emit(HomeLoaded(
        lists: event.lists,
        token: event.token,
      ));
    });

    // on<QuickInsertHome>((event, emit) async {
    //   try {
    //     Map response = await addItem(
    //       listId: event.list.id,
    //       timestamp: event.timestamp,
    //       token: event.token,
    //     );

    //     if (response["success"]) {
    //       Map map = await getLists(token: response["token"]);
    //       List<ListOfItems> list = List<ListOfItems>.from(map["data"]);

    //       emit(HomeLoaded(
    //         lists: list,
    //         token: map["token"],
    //       ));
    //     } else {
    //       emit(HomeMessage(response["message"]));
    //     }
    //   } catch (e) {
    //     emit(HomeError(token: event.token));
    //   }
    // });

    on<ReportHomeError>((event, emit) {
      emit(HomeError(token: event.token));
    });
  }
}
