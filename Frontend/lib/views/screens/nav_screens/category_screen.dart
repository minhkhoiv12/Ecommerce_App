import 'package:bai1/controllers/category_controller.dart';
import 'package:bai1/controllers/subcategory_controller.dart';
import 'package:bai1/models/category.dart';
import 'package:bai1/provider/category_provider.dart';
import 'package:bai1/provider/subcategory_provider.dart';
import 'package:bai1/views/screens/detail/screens/widgets/subcategory_title_widget.dart';
import 'package:bai1/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  // A future that will hold the list of categories once loaded from API
  Category? _selectedCategory;
  @override
  void initState() {
    super.initState();
    //load Categories initially
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await CategoryController().loadCategories();
    ref.read(categoryProvider.notifier).setCategories(categories);
    //set the default selected category (e.g) : "fashion"
    for (var category in categories) {
      if (category.name == "Áo") {
        setState(() {
          _selectedCategory = category;
        });
        //load subcategories for the default category
        _fetchSubcategories(category.name);
      }
    }
  }

  Future<void> _fetchSubcategories(String categoryName) async {
    final subcategories = await SubcategoryController()
        .getSubCategoriesByCategoryName(categoryName);
    ref.read(subcategoryProvider.notifier).setSubcategories(subcategories);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final subcategories = ref.watch(subcategoryProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: HeaderWidget(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //left side - display categories
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  //Xây dựng từng item theo index
                  final category =
                      categories[index]; //Lấy ra một phần tử trong danh sách categories tại vị trí index, và gán nó vào biến category
                  return ListTile(
                    //Tạo 1 dòng hiển thị danh mục
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                      _fetchSubcategories(category.name);
                    },
                    title: Text(
                      category.name,
                      style: GoogleFonts.quicksand(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _selectedCategory == category
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          //Right side - Display selected category details
          Expanded(
            flex: 5,
            child: _selectedCategory != null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _selectedCategory!.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.7,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(_selectedCategory!.banner),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        subcategories.isNotEmpty
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap:
                                    true, // tự động điều chỉnh kích thước của GridView để phù hợp với nội dung bên trong
                                itemCount: subcategories.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 3 / 4,
                                    ),
                                itemBuilder: (context, index) {
                                  final subcategory = subcategories[index];
                                  return SubcategoryTitleWidget(
                                    image: subcategory.image,
                                    title: subcategory.subCategoryName,
                                  );
                                },
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Không có danh mục con nào",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.7,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
