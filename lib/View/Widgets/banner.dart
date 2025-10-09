import 'package:flutter/material.dart';
import '../../Core/Common/Utils/colors.dart';
class MyBanner extends StatelessWidget {
  const MyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Container(
      height: size.height *0.23,
      width: size.width,
      color: bannerColor,
      child: Padding(
        padding: const EdgeInsets.only(left:27 ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:MainAxisAlignment.center ,
              children: [
                const Text(
                    'New collections',
                  style: TextStyle(
                    fontWeight:FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: -2,
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      '20',
                       style: TextStyle(
                         fontSize: 40,
                         height: 0,
                         fontWeight: FontWeight.bold,
                         letterSpacing: -3,
                       ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '%',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'OFF',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: -1.5,
                            height: 0.6,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                MaterialButton(
                  onPressed: (){},
                  color: Colors.black26,
                  child: const Text(
                    "Shop Now",
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Align(alignment: Alignment.bottomRight,
              child:Image.asset(
                'assets/Auth/login.png',
                height: size.height*0.18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}