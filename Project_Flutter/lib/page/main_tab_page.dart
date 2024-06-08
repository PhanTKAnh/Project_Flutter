import 'package:final_app_flutter/page/search_result_page.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'my_profile_page.dart';
import 'my_cart_page.dart';
import 'package:final_app_flutter/resources/app_color.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage>
    with TickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    controller?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabControllerProvider(
      controller: controller!,
      child: Scaffold(
        body: TabBarView(
          controller: controller,
          children: const [
            HomePage(),
            Search(),
            MyCartPage(),
            MyProfilePage(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            controller: controller,
            labelColor: AppColor.blue,
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: AppColor.grey,
            labelStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            unselectedLabelStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            indicatorColor: Colors.transparent,
            padding: EdgeInsets.zero,
            tabs: [
              Tab(
                icon: Image.asset(
                  "assets/images/home_tab.png",
                  width: 25,
                  height: 25,
                  fit: BoxFit.contain,
                  color: controller?.index == 0 ? AppColor.blue : AppColor.grey,
                ),
                text: "Home",
              ),
              Tab(
                icon: Image.asset(
                  "assets/images/search.png",
                  width: 25,
                  height: 25,
                  fit: BoxFit.contain,
                  color: controller?.index == 1 ? AppColor.blue : AppColor.grey,
                ),
                text: "Search",
              ),
              Tab(
                icon: Image.asset(
                  "assets/images/shopping_cart.png",
                  width: 25,
                  height: 25,
                  fit: BoxFit.fill,
                  color: controller?.index == 2 ? AppColor.blue : AppColor.grey,
                ),
                text: "My Cart",
              ),
              Tab(
                icon: Image.asset(
                  "assets/images/my_profile_tab.png",
                  width: 25,
                  height: 25,
                  fit: BoxFit.fill,
                  color: controller?.index == 3 ? AppColor.blue : AppColor.grey,
                ),
                text: "My Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabControllerProvider extends InheritedWidget {
  final TabController controller;

  const TabControllerProvider({
    required this.controller,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static TabControllerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TabControllerProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
