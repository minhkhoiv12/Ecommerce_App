import 'package:bai1/controllers/category_controller.dart';
import 'package:bai1/provider/category_provider.dart';
import 'package:bai1/views/screens/detail/screens/inner_category_screen.dart';
import 'package:bai1/views/screens/nav_screens/widgets/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItemWidget extends ConsumerStatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  ConsumerState<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends ConsumerState<CategoryItemWidget> {
  // A future that will hold the list of categories once loaded from API
  // late Future<List<Category>> futureCategories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategories();
    //futureCategories = CategoryController().loadCategories();
  }

  Future<void> _fetchCategories() async {
    final CategoryController categoryController = CategoryController();
    try {
      final categories = await categoryController.loadCategories();
      ref.read(categoryProvider.notifier).setCategories(categories);
    } catch (e) {
      print("$e");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(title: 'Loại sản phẩm', subtitle: 'Xem tất cả'),
        GridView.builder(
          //
          physics: const NeverScrollableScrollPhysics(), // ko cho phép cuộn
          shrinkWrap:
              true, // chỉ chiếm chiều cao đúng bằng nội dung của nó, không chiếm toàn bộ chiều cao màn hình.
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // tuỳ chỉnh bố cục
            crossAxisCount: 4, //Đây là số lượng cột trong một hàng.
            mainAxisSpacing:
                8, //Tức là khoảng cách giữa các hàng dọc là 8 pixels.
            crossAxisSpacing:
                8, //Đây là khoảng cách giữa các cột (theo chiều ngang).
          ),
          itemBuilder: (context, index) {
            final category =
                categories[index]; // Lay thong tin danh muc hien tai
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return InnerCategoryScreen(
                        category: category,
                      ); // Navigate to InnerCategoryScreen
                    },
                  ),
                );
              },
              child: Column(
                children: [
                  Image.network(category.image, height: 47, width: 47),
                  Text(
                    category.name,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
