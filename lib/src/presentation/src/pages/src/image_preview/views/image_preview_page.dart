import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImagePreviewPage extends StatefulWidget {
  const ImagePreviewPage({super.key, required this.images});

  final List<Widget> images;

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  final PageController controller = PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == widget.images.length - 1) {
        lastPage = true;
      } else {
        lastPage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Image ${currentPage + 1} of ${widget.images.length}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: _onPageChanged,
              children: widget.images,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          SizedBox(
            height: 10.h,
            width: 100.w,
            child: Stack(
              children: [
                SizedBox(
                  height: 10.h,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => controller.jumpToPage(index),
                        child: widget.images[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 4.w,
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                        padding: EdgeInsets.all(2.sp),
                        child: InkWell(
                          onTap: () => controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                        padding: EdgeInsets.all(2.sp),
                        child: InkWell(
                          onTap: () => controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          ),
                          child: Icon(
                            Icons.chevron_right,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}
