import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:walpapper_task_app/feature/view/widgets/bottom_nav.dart';
import 'package:walpapper_task_app/feature/view/widgets/product_card.dart';
import 'package:walpapper_task_app/feature/view_model/photo_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tabName = [
    'Activity',
    'Community',
    'Shop',
  ];

  int currentIndex = 0;

  void _onBottomNavTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    final photoViewModel = Provider.of<PhotoViewModel>(context, listen: false);
    photoViewModel.fetchPhotos(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          actions: [
            const CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                'https://via.placeholder.com/150',
              ),
            ),
            SizedBox(width: scrWidth * 0.03),
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
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(width: scrWidth * 0.04),
          ],
          bottom: TabBar(
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.center,
            indicator: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            tabs: List.generate(
              tabName.length,
              (index) => Tab(
                child: currentIndex == index
                    ? Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            tabName[index],
                          ),
                        ),
                      )
                    : Text(
                        tabName[index],
                      ),
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: TabBarView(
            children: [
              const Center(
                child: Text(
                  'Activity Tab',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Center(
                child: Text(
                  'Community Tab',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Consumer<PhotoViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading && viewModel.photos.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await viewModel.fetchPhotos(reset: true);
                    },
                    child: MasonryGridView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      itemCount: viewModel.photos.length,
                      itemBuilder: (context, index) {
                        final photo = viewModel.photos[index];
                        return ProductCard(
                          imageUrl: photo.urls?.regular ?? '',
                          title: photo.user?.username ?? 'Unknown User',
                          likes: photo.likes ?? 0,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}

