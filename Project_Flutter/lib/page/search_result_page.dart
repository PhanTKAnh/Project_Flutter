import 'dart:io';
import 'package:final_app_flutter/components/app_bar.dart';
import 'package:final_app_flutter/components/arrival_item_row.dart';
import 'package:final_app_flutter/components/search.dart';
import 'package:final_app_flutter/components/selection_text_view.dart';
import 'package:final_app_flutter/model/shoes_model.dart';
import 'package:final_app_flutter/page/main_tab_page.dart';
import 'package:final_app_flutter/page/shoes_detail_page.dart';
import 'package:final_app_flutter/resources/app_color.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController txtSearch = TextEditingController();
  List<ShoesModel> searchList = [];
  List<ShoesModel> searchValue =
      []; // This should be populated with data initially
  File? _image;

  @override
  void initState() {
    super.initState();
    // Populate searchValue with data initially (assuming `shoes` is a list of ShoesModel)
    searchValue = shoes;
    searchList = searchValue;
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

    return Scaffold(
      appBar: TdAppBar(
        showAvatar: false,
        title: 'Search',
        leftPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainTabPage()),
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
              child: TdSearchBox(
                controller: txtSearch,
                onchange: (value) {
                  value = value.toLowerCase();
                  setState(() {
                    searchList = searchValue
                        .where((e) => e.name!.toLowerCase().contains(value))
                        .toList();
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            _divider(),
            const SizedBox(height: 16.0),
            SelectionTextView(
              title: "New Arrival",
              onSeeAllTap: () {},
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: searchList.length, // use searchList instead of shoes
              itemBuilder: (context, index) {
                var aObj = searchList[index]; // use searchList instead of shoes

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
