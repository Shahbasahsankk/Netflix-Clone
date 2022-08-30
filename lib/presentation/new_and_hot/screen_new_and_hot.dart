import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/core/strings.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/everyones_watching_widget.dart';

import '../../application/hot_and_new/hot_and_new_bloc.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              'New & Hot',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: [
              const Icon(
                Icons.cast,
                size: 30,
                color: Colors.white,
              ),
              kWidth10,
              Image.network(
                avatarImageUrl,
                width: 30,
                height: 30,
              ),
              kWidth10,
            ],
            bottom: TabBar(
              labelColor: kBlackColor,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: kWhiteColor,
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              isScrollable: true,
              tabs: const [
                Tab(
                  text: '🍿 Coming Soon',
                ),
                Tab(
                  text: '👀 Everyone\'s Watching',
                ),
              ],
              indicator: BoxDecoration(
                  color: kWhiteColor, borderRadius: kBorderRadius30),
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              const ComingSoonList(
                key: Key('Coming soon'),
              ),
              _buildEveryOneWatching(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEveryOneWatching() {
    return ListView.builder(
      itemBuilder: (context, index) =>
          // const EveryOnesWatchingWidget(),
          const SizedBox(),
      itemCount: 5,
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(
        const LoadDataInComingSoon(),
      );
    });
    return BlocBuilder<HotAndNewBloc, HotAndNewState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        } else if (state.isError) {
          return const Center(
            child: Text('Error Occured'),
          );
        } else if (state.comingSoonList.isEmpty) {
          return const Center(
            child: Text('No Data'),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movie = state.comingSoonList[index];
              final url = "$imageAppendURL${movie.posterPath}";
              if (movie.id == null) {
                return const SizedBox();
              }
              final  _date=DateTime.parse(movie.releaseDate!);
             final formatedDate= DateFormat.yMMMMd('en_US').format(_date);
              return ComingSoonWidget(
                id: movie.id.toString(),
                month: formatedDate.split(' ').first.substring(0,3).toUpperCase(),
                day: movie.releaseDate!.split('-')[1],
                posterPath: url == '${imageAppendURL}null'
                    ? nullImage
                    : '$imageAppendURL${movie.posterPath}',
                movieName: movie.originalTitle ?? 'No Title',
                description: movie.overview ?? 'No Description',
              );
            },
            itemCount: state.comingSoonList.length,
          );
        }
      },
    );
  }
}
