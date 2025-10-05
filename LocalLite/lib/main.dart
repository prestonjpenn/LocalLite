import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async{
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

final String googleMapsApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';    // THIS IS OUR VAIRABLE FOR THE API KEY

final fm.MapController mapController = fm.MapController();

// void main() {
//   runApp(MyApp());
// }

// COLOR PALETTE
const Color green = Color(0xFF60A561);
const Color white = Color(0xFFFEFFFE);
const Color darkGreen = Color(0xFF053225);
const Color orange = Color(0xFFFF8552);
const Color pink = Color(0xFFBA274A);
const Color blue = Color(0xFF1982C4);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locator App',
      theme: ThemeData(fontFamily: 'Roboto'),
      home: HomeScreen(),
    );
  }
}

// ------------------- HOME SCREEN -------------------
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [green, white],
          ),
        ),
        child: Column(
          children: [
            // Top row with profile + fullscreen icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person_outline,
                        size: 32, color: darkGreen),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Transform.rotate(
                      angle: 0.785, // 45 degrees in radians
                      child: const Icon(Icons.open_in_full,
                          size: 28, color: blue),
                    ),
                    onPressed: () {
                      // fullscreen map action
                    },
                  ),
                ],
              ),
            ),

            // Real Google Map
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Platform-specific map
                    Positioned.fill(
                      child: kIsWeb
                          ? fm.FlutterMap(
                              options: fm.MapOptions(
                                initialCenter: LatLng(26.6845, -80.6676),
                                initialZoom: 12.0,
                              ),
                              children: [
                                fm.TileLayer(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: const ['a', 'b', 'c'],
                                  userAgentPackageName: 'com.example.flutter_application_1',
                                ),
                                fm.MarkerLayer(
                                  markers: [
                                    fm.Marker(
                                      point: LatLng(26.687, -80.670),
                                      width: 40,
                                      height: 40,
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 32,
                                      ),
                                    ),
                                    fm.Marker(
                                      point: LatLng(26.682, -80.665),
                                      width: 40,
                                      height: 40,
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 32,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : gmaps.GoogleMap(
                              initialCameraPosition: const gmaps.CameraPosition(
                                target: gmaps.LatLng(26.6845, -80.6676),
                                zoom: 12,
                              ),
                              markers: {
                                gmaps.Marker(
                                  markerId: const gmaps.MarkerId("biz1"),
                                  position: const gmaps.LatLng(26.687, -80.670),
                                  infoWindow:
                                      const gmaps.InfoWindow(title: "Local Coffee Shop"),
                                ),
                                gmaps.Marker(
                                  markerId: const gmaps.MarkerId("biz2"),
                                  position: const gmaps.LatLng(26.682, -80.665),
                                  infoWindow:
                                      const gmaps.InfoWindow(title: "Small Bakery"),
                                ),
                              },
                            ),
                    ),

                    // Search bar overlay
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 48,
                        decoration: BoxDecoration(
                          color: green.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.search, color: darkGreen, size: 24),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search...",
                                  hintStyle: TextStyle(color: white),
                                ),
                                style: TextStyle(color: white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Listings (stationary, screen scrolls instead)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Icon(Icons.filter_list, color: darkGreen),
                        SizedBox(width: 8),
                        Text(
                          "Nearby Results",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(6, (index) {
                    return BusinessListing(index: index);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Business listing widget
class BusinessListing extends StatefulWidget {
  final int index;
  const BusinessListing({Key? key, required this.index}) : super(key: key);

  @override
  State<BusinessListing> createState() => _BusinessListingState();
}

class _BusinessListingState extends State<BusinessListing> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                    "https://via.placeholder.com/90x90.png?text=Biz"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ratings, map icon, distance, favorite
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (i) => const Icon(Icons.star,
                            size: 16, color: orange),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.location_on,
                        size: 18, color: blue.withOpacity(0.5)),
                    const SizedBox(width: 4),
                    const Text("1.2 mi"),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite ? pink : darkGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "This is a short description of the small business. "
                  "It offers great services in the community.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- PROFILE SCREEN -------------------
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [green, white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: darkGreen, size: 28),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Profile picture
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://via.placeholder.com/100.png?text=Profile"),
              ),
              const SizedBox(height: 12),

              // Name
              const Text(
                "Guest",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 24),

              // Columns
              Column(
                children: [
                  ProfileColumn(icon: Icons.settings, text: "Settings"),
                  ProfileColumn(icon: Icons.favorite_border, text: "Favorites"),
                  ProfileColumn(icon: Icons.map_outlined, text: "Pinned"),
                  ProfileColumn(icon: Icons.person_outline, text: "Account"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable profile column widget
class ProfileColumn extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileColumn({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: darkGreen, size: 28),
          const Spacer(),
          Text(
            text,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
