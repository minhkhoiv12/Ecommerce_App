import 'package:bai1/controllers/category_controller.dart';
import 'package:bai1/controllers/subcategory_controller.dart';
import 'package:bai1/models/category.dart';
import 'package:bai1/models/subcategory.dart';
import 'package:bai1/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
   // A future that will hold the list of categories once loaded from API
    late Future<List<Category>> futureCategories;
    Category? _selectedCategory;
    List<Subcategory> _subcategories = [];
    final SubcategoryController _subcategoryController = SubcategoryController(); 

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategories();// để bắt đầu tải danh sách category từ API.
    // once the categories are loaded process then
    futureCategories.then((categories) {
      //iterate the categories are loaded process then
      for(var category in categories) {
        if(category.name == 'Baby') {
          setState(() {
            _selectedCategory = category; // set the selected category to 'Baby'
          });
          _loadSubcategories(category.name); // load subcategories for 'Baby'
        }
      }

    });
  }
  @override
  // this will load subcategories base on the categoryName
  Future<void> _loadSubcategories(String categoryName) async{
    final subcategories = await _subcategoryController.getSubCategoriesByCategoryName(categoryName);
    setState(() {
      _subcategories = subcategories;
    });
  }
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130), 
        child: HeaderWidget()),
      body: Row(
        children: [
          //left side - display categories
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: FutureBuilder(future: futureCategories, builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(
                        child: CircularProgressIndicator(),
                  );
                }
                else if(snapshot.hasError){
                  return Center(child: Text("Lỗi: ${snapshot.error}"),
                  );
                }
                else {
                  final categories = snapshot.data!;
                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index){//Xây dựng từng item theo index
                        final category = categories[index];//Lấy ra một phần tử trong danh sách categories tại vị trí index, và gán nó vào biến category
                        return ListTile(//Tạo 1 dòng hiển thị danh mục
                          onTap: (){
                            setState(() {
                              _selectedCategory = category;
                            });
                            _loadSubcategories(category.name);
                          },
                          title: Text(category.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _selectedCategory==category?Colors.blue:Colors.black,
                            )
                          ),
                        );
                    });
                }
              }),
            ),
          ),
          //Right side - Display selected category details
          Expanded(
            flex: 5,
            child: _selectedCategory !=null
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_selectedCategory!.name,
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
                      image: DecorationImage(image: NetworkImage(_selectedCategory!.banner),
                      fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                _subcategories.isNotEmpty? GridView.builder(
                  shrinkWrap: true,
                  itemCount: _subcategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 8), 
                  itemBuilder: (context, index){
                    final subcategory = _subcategories[index];
                    return Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: Image.network(
                              subcategory.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(child: Text(
                          subcategory.subCategoryName,
                          style: GoogleFonts.quicksand(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),),
                        )
                      ],
                    );
                  })
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(
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
            ):Container(

            ),
          ),
        ],
      )
    );
  }
}