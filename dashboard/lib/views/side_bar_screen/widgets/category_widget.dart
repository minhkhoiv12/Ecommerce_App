import 'package:dashboard_ecomerce/controllers/category_controller.dart';
import 'package:dashboard_ecomerce/models/category.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
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
    return FutureBuilder(
        future: futureCategories, 
        builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(),
                );
            }
            else if (snapshot.hasError){
                return Center(
                    child: Text('Lỗi ${snapshot.error}'),
                );
            }
            else if(!snapshot.hasData|| snapshot.data!.isEmpty) {
                return Center(
                    child: Text('Không có loại sản phẩm nào'),
                );
            }
            else{
                final categories = snapshot.data!;
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount:  categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8
                    ), 
                    itemBuilder: (context, index) {
                        final category = categories[index];
                        return Column(
                            children: [
                                Image.network(category.image, height: 100, width:  100,),
                                Text(category.name),
                            ],
                        );
                    });
            }

        }
    );
  }
}