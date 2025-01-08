import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:walpapper_task_app/feature/view_model/photo_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    final photoViewModel = Provider.of<PhotoViewModel>(context, listen: false);
    photoViewModel.fetchPhotos(reset: true); // Fetch initial data
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
                'https://via.placeholder.com/150', // Profile image URL
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
                      mainAxisSpacing: 12, // Vertical space
                      crossAxisSpacing: 12, // Horizontal space
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.likes,
  });

  final String imageUrl;
  final String title;
  final int likes;

  @override
  Widget build(BuildContext context) {
    final photoViewModel = Provider.of<PhotoViewModel>(context, listen: false);

    return GestureDetector(
       onTap: () => photoViewModel.downloadImage(context, imageUrl),
      child: Container(
        margin: const EdgeInsets.all(4), // Optional margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.black),
              ),
            ),
            const SizedBox(height: 8),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Icon(
                Icons.more_horiz,
              )
            ],
          ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
