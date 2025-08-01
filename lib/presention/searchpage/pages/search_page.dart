import 'package:flutter/material.dart';
import 'package:spotify_app/core/configs/assets/app_images.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Search',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                _searchField(),
                SizedBox(height: 20),
                _searchRecomment('Your top genres', 4),
                SizedBox(height: 20),
                _searchRecomment('Browse all', 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.black,
        hintText: 'Search for artists, songs, or albums',
        hintStyle: TextStyle(
          color: Color(0xff121212).withOpacity(0.7),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: BorderSide.none,
        ),

        prefixIcon: Icon(Icons.search, color: Colors.black, size: 40),
      ),
    );
  }

  Widget _searchRecomment(String hint, int item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        // Dùng Column để chứa các hàng (Row)
        Column(
          children: List.generate((item / 2).ceil(), (rowIndex) {
            // Tạo các item theo từng hàng
            final int firstIndex = rowIndex * 2;
            final int secondIndex = firstIndex + 1;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Item thứ 1 trong hàng
                _buildImageCard(firstIndex),
                // const SizedBox(width: 5),
                // Kiểm tra nếu còn item thứ 2
                if (secondIndex < item) _buildImageCard(secondIndex),
              ],
            );
          }),
        ),
      ],
    );
  }

  // Widget dựng item ảnh
  Widget _buildImageCard(int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        AppImages.pop,
        width: 200,
        height: 104,
        fit: BoxFit.cover,
      ),
    );
  }
}
