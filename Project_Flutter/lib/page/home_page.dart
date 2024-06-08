import 'dart:io';

import 'package:final_app_flutter/components/app_bar.dart';
import 'package:final_app_flutter/components/arrival_item_row.dart';
import 'package:final_app_flutter/components/category_cell.dart';
import 'package:final_app_flutter/components/search.dart';
import 'package:final_app_flutter/components/selection_text_view.dart';
import 'package:final_app_flutter/components/shoes_item_cell.dart';
import 'package:final_app_flutter/model/list_product.dart';
import 'package:final_app_flutter/model/shoes_model.dart';
import 'package:final_app_flutter/page/main_tab_page.dart';
import 'package:final_app_flutter/page/search_result_page.dart';
import 'package:final_app_flutter/page/shoes_detail_page.dart';
import 'package:final_app_flutter/resources/app_color.dart';
import 'package:final_app_flutter/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tab_controller_provider.dart'; // Import TabControllerProvider

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController txtSearch = TextEditingController();
  final SharedPrefs _prefs = SharedPrefs();
  File? _image;

  @override
  void initState() {
    super.initState();
    loadSavedImage();
  }

  Future<void> loadSavedImage() async {
    final imagePath = await _prefs.getImagePath();

    if (imagePath != null && imagePath.isNotEmpty) {
      final imageFile =
          File(imagePath); // đường dẫn tập tin trong hệ thống của bạn
      setState(() {
        _image = imageFile;
      });
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // Sau khi hình ảnh được chọn hoặc chụp, hàm saveFilePermanently()
      // được gọi để lưu trữ hình ảnh một cách vĩnh viễn.
      final imagePermanent = await saveFilePermanently(image.path);
      final imagePath = imagePermanent.path;

      setState(() {
        _image = imagePermanent;
      });
      // lưu trữ vào hàm setImagePath
      await _prefs.setImagePath(imagePath);
    } on PlatformException catch (e) {
      print('Failed to pick: $e');
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    // lấy thư mục của ứng dụng lưu trữ hình ảnh
    final directory = await getApplicationDocumentsDirectory();
    // p.basename(imagePath) để trích xuất phần cuối cùng của đường dẫn
    final name = p.basename(imagePath);
    final permanentPath = '${directory.path}/$name';

    final imageFile = File(imagePath);
    final permanentFile = await imageFile.copy(permanentPath);
    // để sao chép tệp hình ảnh từ đường dẫn ban đầu vào đường dẫn lưu trữ vĩnh viễn.

    return permanentFile;
  }

  @override
  Widget build(BuildContext context) {
    Widget _divider() {
      return const Divider(
        height: 1.2,
        thickness: 1.2,
        indent: 20.0,
        endIndent: 20.0,
        color: AppColor.grey,
      );
    }

    var media = MediaQuery.of(context).size;
    final TabController? tabController =
        TabControllerProvider.of(context)?.controller;

    return Scaffold(
      appBar: TdAppBar(
        showAvatar: true,
        title: 'OXY BOOTS',
        imageFile: _image,
        onAvatar: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo),
                    title: const Text('Choose from Gallery'),
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera),
                    title: const Text('Take a Photo'),
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(top: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (tabController != null) {
                    tabController.index = 1; // Chuyển đến tab "Search"
                  }
                },
                child: TdSearchBox(),
              ),
            ),
            const SizedBox(height: 16.0),
            _divider(),
            const SizedBox(height: 16.0),
            SizedBox(
              height: media.width * 0.27,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                itemCount: catArr.length,
                itemBuilder: (context, index) {
                  var cObj = catArr[index] as Map? ?? {};

                  return CategoryCell(
                    cObj: cObj,
                  );
                },
              ),
            ),
            SelectionTextView(
              title: "Popular Shoes",
              onSeeAllTap: () {},
            ),
            SizedBox(
              height: media.width * 0.54,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: shoes.length,
                itemBuilder: (context, index) {
                  var sObj = shoes[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShoesDetailPage(shoe: sObj)),
                      );
                    },
                    child: ShoesItemCell(
                      shoe: sObj,
                    ),
                  );
                },
              ),
            ),
            SelectionTextView(
              title: "New Arrival",
              onSeeAllTap: () {},
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: shoes.length,
              itemBuilder: (context, index) {
                var aObj = shoes[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoesDetailPage(shoe: aObj)),
                    );
                  },
                  child: ArrivalItemRow(
                    shoe: aObj,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
