import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log_app_wear/home/bloc/home_bloc.dart';
import 'package:log_app_wear/widgets/error.dart';
import 'package:log_app_wear/widgets/list_view.dart';
import 'package:log_app_wear/widgets/loading.dart';
import 'package:log_app_wear/widgets/pin_generated.dart';
import 'package:log_app_wear/widgets/pin_view.dart';
import 'package:wear/wear.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AmbientMode(
      builder: (context, mode, child) {
        if (mode == WearMode.active) {
          return Scaffold(
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return HomeList(lists: state.lists);
                }

                if (state is HomePinRequired) {
                  return const PinView();
                }

                if (state is HomePinGenerated) {
                  return PinGenerated(pin: state.pin, id: state.id);
                }

                if (state is HomeError) {
                  return const PageError();
                }

                return const PageLoading();
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
