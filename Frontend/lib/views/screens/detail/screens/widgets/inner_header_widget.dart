import 'package:flutter/material.dart';

class InnerHeaderWidget extends StatelessWidget {
  const InnerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
       width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height *0.20,
        height: 130,
        child: Stack(
          children: [
            Image.asset('assets/icons/searchBanner.jpeg',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            ),
            Positioned(
              left: 16,
              top: 68,
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pop(); // Navigate back to the previous screen
                }, 
                icon: Icon(Icons.arrow_back,
                color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 64,
              top: 68,
              child: SizedBox(
                width: 250,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Nhập nội dung tìm kiếm',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7F7F7F),// màu của text
                    
                    ),
                    contentPadding: const EdgeInsets.symmetric(// Thêm khoảng trống bên trong TextField
                      horizontal: 12, //cách lề trái/phải 12px.
                      vertical: 16, //cách lề trên/dưới 16px.
                    ),
                    prefixIcon: Image.asset(
                      'assets/icons/searc1.png',
                      
                    ),
                    suffixIcon: Image.asset('assets/icons/cam.png'),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    //focusColor: Colors.black, chưa hiểu
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 311,
              top: 78,
              child: Material(
                type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    child: Ink(
                    width: 31,
                    height: 31,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/bell.png'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 354,
              top: 78,
              child: Material(
                type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    child: Ink(
                    width: 31,
                    height: 31,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/message.png'),
                      ),
                    ),
                  ),

                ),
              ),
            ),
          ],
        ),
    );
  }
}