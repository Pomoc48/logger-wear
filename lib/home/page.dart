import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log_app_wear/home/bloc/home_bloc.dart';
import 'package:log_app_wear/widgets/loading.dart';
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
                  return const PageLoading();
                }

                if (state is HomePinRequired) {
                  return const PinView();
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
