import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spotify_app/core/configs/assets/app_images.dart';
import 'package:spotify_app/presention/homepage/pages/add_album.dart';
import 'package:spotify_app/presention/homepage/widgets/buntton.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildGridSection(),
                  SizedBox(height: 40),
                  _buildArtistInfo(),
                  SizedBox(height: 40),
                  _buildDiscoverSection(size),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3B13B0),
              Color(0xFF271363),
              Color(0xFF1B1235),
              Color(0xFF121212),
            ],
            stops: [0.0, 0.3, 0.6, 1.0],
          ),
        ),
      ),
    );
  }

 Widget _buildHeader() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(
          getGreetingMessage(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            // Xử lý notification
          },
          icon: const Icon(Icons.notifications, color: Colors.white, size: 30),
        ),
        IconButton(
          onPressed: () {
            // Xử lý time_to_leave
          },
          icon: const Icon(Icons.time_to_leave, color: Colors.white, size: 30),
        ),
        PopupMenuButton<String>(
          onSelected: (value){
            if(value == 'profile'){

            }else if(value == 'logout'){

            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddAlbumScreen()));
            }
          },
          offset: const Offset(0, 40), // Dịch xuống dưới icon
          shape: RoundedRectangleBorder( // Bo góc khung
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.black, // Màu nền popup
          elevation: 4, // Đổ bóng
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'profile',
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Icon(Icons.person, size: 20),
                  SizedBox(width: 8),
                  Text("Tài khoản"),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'logout',
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Icon(Icons.logout, size: 20),
                  SizedBox(width: 8),
                  Text("Đăng xuất"),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'add',
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: const [
                  Icon(Icons.add, size: 20),
                  SizedBox(width: 8),
                  Text("Thêm nhạc"),
                ],))
          ],
          icon: const Icon(Icons.settings), // Icon hiển thị
        ),
      ],
    ),
  );
}


  Widget _buildGridSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('albums').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "No albums found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        final albums = snapshot.data!.docs;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GridView.builder(
            itemCount: albums.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
            ),
            itemBuilder: (_, index) {
              final albumData = albums[index].data() as Map<String, dynamic>;
              final albumName = albumData['name'] ?? 'Unknown';
              final List<String> imageUrls = List<String>.from(albumData['images']);
              final String thumbnailUrl = imageUrls.isNotEmpty
                ? imageUrls.first
                : AppImages.list; // Ảnh mặc định

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                // padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    ClipRRect(
                      // borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        File(thumbnailUrl),
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(AppImages.list); // ảnh mặc định khi lỗi
                        },
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        albumName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildArtistInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(AppImages.logo),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NEW RELEASES FROM',
                    style: TextStyle(color: Colors.grey[300], fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Dean Lewis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(15),
                  ),
                  child: Image.asset(
                    AppImages.imageDean,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hurtless (Acoustic)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Single    Dean Lewis',
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [LoveButton(), Spacer(), PlayButton()],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverSection(Size size) {
    final images = [AppImages.image1, AppImages.image2, AppImages.image3];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Discover something new',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: images
                  .map(
                    (img) => Container(
                      // width: size.width * 0.4,
                      // height: size.width * 0.4,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        // borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Image.asset(
                          img,
                          fit: BoxFit.cover,
                          width: 167,
                          height: 167,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) return 'Good Morning';
    if (hour >= 12 && hour < 18) return 'Good Afternoon';
    return 'Good Evening';
  }
}
