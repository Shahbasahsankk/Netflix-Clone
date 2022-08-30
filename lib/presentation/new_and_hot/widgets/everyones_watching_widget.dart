import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_clone/presentation/widgets/video_widget.dart';

class EveryOnesWatchingWidget extends StatelessWidget {
  const EveryOnesWatchingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight10,
        const VideoWidget(),
        kHeight20,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CustomButtonWidget(
              icon: Icons.share,
              iconSize: 16,
              title: 'Share',
              textSize: 13,
            ),
            kWidth10,
            CustomButtonWidget(
              icon: Icons.add,
              iconSize: 16,
              title: 'My List',
              textSize: 13,
            ),
            kWidth10,
            CustomButtonWidget(
              icon: Icons.play_arrow,
              iconSize: 16,
              title: 'Play',
              textSize: 13,
            ),
            kWidth10,
          ],
        ),
        Row(
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvqzzaddvtgMnkygige0xD04ts4LMBbBLcPQ&usqp=CAU',
              width: 20,
              height: 30,
            ),
            const Text(
              'SERIES',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        const Text(
          'Friends',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight10,
        const Text(
          'This hit sitcome follows the merry disadventures of six 20-something pals as they navigate the pitfalls of work, life and love in 1980s Manhattan.',
          style: TextStyle(
            color: kGreyColor,
          ),
        ),
        kHeight50,
      ],
    );
  }
}
