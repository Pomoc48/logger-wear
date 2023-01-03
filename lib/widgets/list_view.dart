import 'package:flutter/material.dart';
import 'package:log_app_wear/functions.dart';
import 'package:log_app_wear/models/list.dart';
import 'package:log_app_wear/widgets/button.dart';
import 'package:log_app_wear/widgets/chart.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomeList extends StatelessWidget {
  const HomeList({required this.lists, super.key});

  final List<ListOfItems> lists;

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
      itemBuilder: (context, index) {
        return SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: 120,
                child: LineChart(data: lists[index].chartData),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Text(
                          lists[index].name,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitleCount(lists[index].count),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  WatchButton(
                    onTap: () {},
                    title: "Add",
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ],
          ),
        );
      },
      scrollDirection: Axis.vertical,
      itemCount: lists.length,
      itemSize: 200,
      onItemFocus: (p0) {},
    );
  }
}
