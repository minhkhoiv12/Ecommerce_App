
import 'package:bai1/provider/user_provider.dart';
import 'package:bai1/views/screens/authentication_screens/login_screen.dart';
import 'package:bai1/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //run the flutter app wrapped in a ProviderScopefor managing state
  runApp(ProviderScope(child: const MyApp()));
}
// Root widget of the application, a cosummerWidget to consume state change
class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // Method to check the token and set the user data if available
  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    //obtain an instace of sharedPreferences for local data storage
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Retrive the authentication token and user data stored locally 
    //Lấy dữ liệu token và user (dạng JSON) từ SharedPreferences.
    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');
    //if both token and user data are avaible, update the user state
    //Kiểm tra nếu cả token và userJson đều tồn tại, chứng tỏ người dùng đã đăng nhập trước đó
    if(token !=null && userJson !=null){
      ref.read(userProvider.notifier).setUser(userJson);
    }
    else {
      ref.read(userProvider.notifier).signOut();
    }
  }
  // Hàm _checkTokenAndSetUser được gọi khi khởi chạy app
  // Kiểm tra xem người dùng có đăng nhập trước không.
  // Nếu có, thì cập nhật lại userProvider với dữ liệu người dùng đã lưu → giúp ứng dụng không yêu cầu đăng nhập lại sau khi mở app.
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: FutureBuilder(future: _checkTokenAndSetUser(ref), builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //Sau khi kiểm tra xong, lấy user từ userProvider.
        //Nếu có user (đăng nhập rồi), chuyển đến MainScreen.
        //Nếu không, chuyển đến LoginScreen.
        final user = ref.watch(userProvider);
        return user != null ? MainScreen() : LoginScreen();


      }), // Change to MainScreen() to show the main screen
    );
  }
}
