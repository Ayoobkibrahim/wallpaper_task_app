import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:walpapper_task_app/configs/mixins/mediaquery_extension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    double scrWidth = context.mediaQueryWidth;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          actions: [
            CircleAvatar(
              child: Container(
                height: scrHeight * 0.04,
                width: scrWidth * 0.2,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            (scrWidth * 0.03).width,
            Container(
              height: scrHeight * 0.04,
              width: scrWidth * 0.2,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  'Follow',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            (scrWidth * 0.04).width,
          ],
          bottom: TabBar(
            indicatorColor: Colors.transparent, // Customize the indicator color
            labelColor: Colors.black, // Active tab text color
            unselectedLabelColor: Colors.grey,
            dividerColor: Colors.transparent,
            isScrollable: false,
            tabAlignment: TabAlignment.center,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            tabs: const [
              Tab(
                text: 'Activity 1',
              ),
              Tab(
                text: 'Activity 2',
              ),
              Tab(
                text: 'Activity 3',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(
              child: Text(
                'Content for Activity 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Center(
              child: Text(
                'Content for Activity 2',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Column(
              children: [
                const Text(
                  'All Products',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: scrHeight*0.5,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ImageContainer(
                        scrHeight: scrHeight * 0.4,
                        scrWidth: scrWidth * 0.5,
                        image: '',
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.scrHeight,
    required this.scrWidth,
    required this.image,
  });

  final double scrHeight;
  final double scrWidth;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            height: scrHeight,
            width: scrWidth,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: scrWidth * 0.06,
                  top: scrHeight * 0.03,
                  child: Container(
                    height: scrHeight * 0.04,
                    width: scrWidth * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        '62',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: image,
                  ),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'data',
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}
