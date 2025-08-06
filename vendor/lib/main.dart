import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/provider/vendor_provider.dart';
import 'package:vendor/views/screens/authentication/login_screen.dart';
import 'package:vendor/views/screens/main_vendor_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // Method to check the token and set the user data if available
  Future<void> checkTokenAndSetUser(WidgetRef ref) async {
    //obtain an instace of sharedPreferences for local data storage
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Retrive the authentication token and user data stored locally 
    //Lấy dữ liệu token và user (dạng JSON) từ SharedPreferences.
    String? token = preferences.getString('auth_token');
    String? vendorJson = preferences.getString('vendor');
    //if both token and user data are avaible, update the user state
    //Kiểm tra nếu cả token và userJson đều tồn tại, chứng tỏ người dùng đã đăng nhập trước đó
    if(token !=null && vendorJson !=null){
      ref.read(vendorProvider.notifier).setVendor(vendorJson);
    }
    else {
      ref.read(vendorProvider.notifier).signOut();
    }
  }
  // Hàm _checkTokenAndSetUser được gọi khi khởi chạy app
  // Kiểm tra xem người dùng có đăng nhập trước không.
  // Nếu có, thì cập nhật lại userProvider với dữ liệu người dùng đã lưu → giúp ứng dụng không yêu cầu đăng nhập lại sau khi mở app.
  // This widget is the root of your application.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder(future: checkTokenAndSetUser(ref), builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //Sau khi kiểm tra xong, lấy user từ userProvider.
        //Nếu có user (đăng nhập rồi), chuyển đến MainScreen.
        //Nếu không, chuyển đến LoginScreen.
        final vendor = ref.watch(vendorProvider);
        return vendor != null ? const MainVendorScreen() : const LoginScreen();


      }), // Change to MainScreen() to show the main screen
    );
  }
}

