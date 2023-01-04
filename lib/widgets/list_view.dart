import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log_app_wear/functions.dart';
import 'package:log_app_wear/home/bloc/home_bloc.dart';
import 'package:log_app_wear/widgets/button.dart';
import 'package:log_app_wear/widgets/chart.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wearable_rotary/wearable_rotary.dart';

class HomeList extends StatelessWidget {
  const HomeList({required this.state, super.key});

  final HomeLoaded state;

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
      listController: RotaryScrollController(),
      itemBuilder: (context, index) {
        return SizedBox(
          height: 200,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 16),
                    child: Column(
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
                        
                        const SizedBox(height: 2),
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
                  const SizedBox(height: 12),
                ],
              ),
            ],
          ),
        );
      },
      scrollDirection: Axis.vertical,
      itemCount: state.lists.length,
      itemSize: 200,
      onItemFocus: (p0) {},
    );
  }
}
