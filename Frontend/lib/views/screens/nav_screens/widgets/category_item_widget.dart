
import 'package:bai1/controllers/category_controller.dart';
import 'package:bai1/models/category.dart';
import 'package:bai1/views/screens/nav_screens/widgets/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
    // A future that will hold the list of categories once loaded from API
    late Future<List<Category>> futureCategories;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(title: 'Categories', subtitle: 'View all'),
        FutureBuilder(
            future: futureCategories, 
            builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(),
                    );
                }
                else if (snapshot.hasError){
                    return Center(
                        child: Text('Lỗi ${snapshot.error}'),
                    );
                }
                else if(!snapshot.hasData|| snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Không có loại sản phẩm nào'),
                    );
                }
                else{
                    final categories = snapshot.data!;
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:  categories.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8
                        ), 
                        itemBuilder: (context, index) {
                            final category = categories[index];
                            return Column(
                                children: [
                                    Image.network(category.image, height: 47, width:  47,),
                                    Text(category.name,
                                      style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.bold, fontSize: 16,
                                        ),
                            
                                    ),
                                ],
                            );
                        });
                }
        
            }
        ),
      ],
    );
  }
}