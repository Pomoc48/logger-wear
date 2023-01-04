import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log_app_wear/functions.dart';
import 'package:log_app_wear/home/bloc/home_bloc.dart';
import 'package:log_app_wear/widgets/button.dart';
import 'package:log_app_wear/widgets/chart.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:vibration/vibration.dart';
import 'package:wearable_rotary/wearable_rotary.dart';

class HomeList extends StatelessWidget {
  const HomeList({required this.state, super.key});

  final HomeLoaded state;

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();

    rotaryEvents.listen((RotaryEvent event) {
      if (event.direction == RotaryDirection.clockwise) {
        Vibration.vibrate(duration: 20, amplitude: 128);

        carouselController.nextPage(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOutSine,
        );
      } else if (event.direction == RotaryDirection.counterClockwise) {
        Vibration.vibrate(duration: 20, amplitude: 128);

        carouselController.previousPage(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOutSine,
        );
      }
    });

    return CarouselSlider.builder(
      carouselController: carouselController,
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 1/1,
        scrollDirection: Axis.vertical,
        viewportFraction: 1,
        enlargeCenterPage: true,
        enlargeFactor: 0.5,
      ),

      itemBuilder: (context, index, pageIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: 120,
                child: LineChart(data: state.lists[index].chartData),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Marquee(
                              backDuration: const Duration(milliseconds: 500),
                              backwardAnimation: Curves.easeOutCirc,
                              child: Text(
                                state.lists[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        const Shadow(
                                          color: Colors.black,
                                          blurRadius: 20,
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ),
                          Text(
                            subtitleCount(state.lists[index].count),
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  shadows: [
                                    const Shadow(
                                      color: Colors.black,
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  WatchButton(
                    onTap: () {
                      BlocProvider.of<HomeBloc>(context).add(
                        QuickInsertHome(
                          timestamp: dateToTimestamp(DateTime.now()),
                          list: state.lists[index],
                          token: state.token,
                        ),
                      );
                    },
                    title: "Quick Add",
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: state.lists.length,
    );
  }
}
