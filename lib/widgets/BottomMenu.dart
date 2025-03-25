import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:book_luck_app_demo/providers/route_provider.dart';
import 'package:provider/provider.dart'; // Import the Provider package

class BottomMenu extends StatelessWidget {
  final double bodyHeight;
  final double bodyWidth;
  final String currentRoute;
  final ValueChanged<String> onRouteChange; // Callback for route change

  const BottomMenu({
    Key? key,
    required this.bodyHeight,
    required this.bodyWidth,
    required this.currentRoute,
    required this.onRouteChange, // Add the callback function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.0987 * bodyHeight, // 9.87% of screen height
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1, // Border width
        ),
        color: Colors.transparent, // Transparent background
      ),
      child: Center(
        child: Container(
          height: bodyHeight * 0.0705,
          width: bodyWidth * 0.8889,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMenuItem(
                iconPath: 'assets/images/home.svg',
                label: '홈',
                isActive: currentRoute == '/home',
                routeName: '/home',
                context: context,
              ),
              _buildMenuItem(
                iconPath: 'assets/images/bookshelf.svg',
                label: '책장',
                isActive: currentRoute == '/bookshelf',
                routeName: '/bookshelf',
                context: context,
              ),
              _buildMenuItem(
                iconPath: 'assets/images/feed.svg',
                label: '피드',
                isActive: currentRoute == '/feed',
                routeName: '/feed',
                context: context,
              ),
              _buildMenuItem(
                iconPath: 'assets/images/my-page.svg',
                label: '마이페이지',
                isActive: currentRoute == '/mypage',
                routeName: '/mypage',
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String label,
    required bool isActive,
    required String routeName,
    required BuildContext context,
  }) {
    final activeColor = Colors.black; // Full opacity for active items
    final inactiveColor =
        Colors.black.withOpacity(0.3); // Reduced opacity for inactive items

    final currentRoute = Provider.of<RouteProvider>(context).currentRoute;
    return GestureDetector(
      onTap: () {
        print('Current route: $currentRoute');
        print('Tapped on: $routeName'); // Debug log

        // Track the current route directly using your state variable
        final currentRouteName = ModalRoute.of(context)?.settings.name;

        print('ModalRoute.of(context)?.settings.name: $currentRouteName');

        // if (currentRouteName != routeName) {
        //   print('Route updated to: $routeName');
        //   onRouteChange(routeName); // Trigger route change callback
        // }

        if (currentRoute != routeName) {
          print('Route updated to: $routeName');
          Provider.of<RouteProvider>(context, listen: false)
              .updateRoute(routeName); // Update route in the provider
          // Navigator.pushNamed(
          //     context, routeName); // Perform the route navigation
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            iconPath,
            height: bodyHeight * 0.0339,
            color: isActive ? activeColor : inactiveColor,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
