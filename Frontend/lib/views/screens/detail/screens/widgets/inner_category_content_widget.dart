import 'package:bai1/controllers/subcategory_controller.dart';
import 'package:bai1/models/category.dart';
import 'package:bai1/models/subcategory.dart';
import 'package:bai1/views/screens/detail/screens/widgets/inner_banner_widget.dart';
import 'package:bai1/views/screens/detail/screens/widgets/inner_header_widget.dart';
import 'package:bai1/views/screens/detail/screens/widgets/subcategory_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;

  const InnerCategoryContentWidget({super.key, required this.category});
  //const InnerCategoryScreen({super.key});

  @override
  State<InnerCategoryContentWidget> createState() => _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState extends State<InnerCategoryContentWidget> {
  late Future<List<Subcategory>> _subcategories;
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subcategories = _subcategoryController.getSubCategoriesByCategoryName(widget.category.name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130), 
        child: InnerHeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Chọn theo danh mục sản phẩm',
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.7,
                  ),
                ),
              ),
            ),
            FutureBuilder(
            future: _subcategories, 
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
                        child: Text('Không có loại sản phẩm con nào'),
                    );
                }
                else{
                    final subcategories = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: List.generate((subcategories.length/7).ceil(), (setIndex){
                          //for each row, calculate the start and end index 
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;
                          // Create a padding widget to add spacing arround the row
                          return Padding(
                            padding: EdgeInsets.all(8.9),
                            child: Row(
                              // create a row of teh subcategory tile
                              children: subcategories.sublist(start, end > subcategories.length ? subcategories.length : end).map((subcategory) {
                                return SubcategoryTitleWidget(
                                  image: subcategory.image,
                                  title: subcategory.categoryName,
      
                                );
                              }).toList(),
                            )
                          );

                        })
                      )

                    );
                    // return GridView.builder(// 
                    //   physics: const NeverScrollableScrollPhysics(),// ko cho phép cuộn
                    //     shrinkWrap: true,// chỉ chiếm chiều cao đúng bằng nội dung của nó, không chiếm toàn bộ chiều cao màn hình.
                    //     itemCount:  subcategories.length,
                    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(// tuỳ chỉnh bố cục
                    //     crossAxisCount: 4,//Đây là số lượng cột trong một hàng.
                    //     mainAxisSpacing: 8,//Tức là khoảng cách giữa các hàng dọc là 8 pixels.
                    //     crossAxisSpacing: 8//Đây là khoảng cách giữa các cột (theo chiều ngang).
                    //     ), 
                    //     itemBuilder: (context, index) {
                    //         final subcategory = subcategories[index];// Lay thong tin danh muc hien tai
                    //         return SubcategoryTitleWidget(image: subcategory.image, title: subcategory.categoryName);
                    //     });
                }
        
            }
        ),
          ],
        ),
      )
    );
  }
}