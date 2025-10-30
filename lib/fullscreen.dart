import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class Fullscreen extends StatefulWidget {
  final String imageurl;
  const Fullscreen({super.key,required this.imageurl});

  @override
  State<Fullscreen> createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {

  Future<void> setwallpaper(int locat) async{
    int location = locat;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    var result = await WallpaperManagerFlutter().setWallpaper(file,location);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallpaper"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.imageurl),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/3.5,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Set as wallpaper",style: TextStyle
                              (fontSize: 18,fontWeight: FontWeight.bold),),
                            GestureDetector(
                              onTap: (){
                                setwallpaper(WallpaperManagerFlutter.homeScreen);
                                Fluttertoast.showToast(msg: "Set on Home Screen");
                                Navigator.pop(context);
                              },
                                child: Text("Home Screen",style: TextStyle
                                  (fontSize: 16,),),
                            ),
                            GestureDetector(
                              onTap: (){
                                setwallpaper(WallpaperManagerFlutter.lockScreen);
                                Fluttertoast.showToast(msg: "Set on Lock "
                                    "Screen");
                                Navigator.pop(context);
                              },
                                child: Text("Lock Screen",style: TextStyle
                                  (fontSize: 16,),),
                            ),
                            GestureDetector(
                              onTap: (){
                                setwallpaper(WallpaperManagerFlutter.bothScreens);
                                Fluttertoast.showToast(msg: "Set on Lock "
                                    "and Home Screens");
                                Navigator.pop(context);
                              },
                              child: Text("Lock and Home Screens",style: TextStyle
                                (fontSize: 16,),),
                            ),
                          ],
                        ),
                      );
                    },
                );
              },
              child: Container(
                color: Colors.black,
                height: 60,
                width: double.infinity,
                child: Center(
                  child: Text('Set Wallpaper',style: TextStyle(fontSize: 20,
                      color:
                  Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
