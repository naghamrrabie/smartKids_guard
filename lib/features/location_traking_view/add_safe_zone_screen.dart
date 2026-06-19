import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartkids_gurad/features/location_traking_view/cubit/safe_zone_cubit_states.dart';
import 'package:smartkids_gurad/features/location_traking_view/data/models/safe_zone_model.dart';

class AddSafeZoneScreen extends StatefulWidget {
  final List<SafeZoneModel> existingZones;

  const AddSafeZoneScreen({super.key, required this.existingZones});

  @override
  State<AddSafeZoneScreen> createState() => _AddSafeZoneScreenState();
}

class _AddSafeZoneScreenState extends State<AddSafeZoneScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String selectedType = 'Home';
  LatLng? newZoneLocation;
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Safe Zone', style: TextStyle(color: Colors.black)),
      ),
      body: BlocConsumer<SafeZoneCubit, SafeZoneState>(
        listener: (context, state) {
          if (state is SafeZoneAddSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Zone added successfully!'), backgroundColor: Colors.green),
            );
            Navigator.pop(context); // نرجع بعد النجاح
          } else if (state is SafeZoneAddError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: GoogleMap(
                        // 💡 السطر ده بيحل مشكلة إنك مش عارف تتحرك في الخريطة!
                        gestureRecognizers: {
                          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
                        },
                        initialCameraPosition: CameraPosition(
                          target: widget.existingZones.isNotEmpty
                              ? LatLng(widget.existingZones.first.centerLatitude, widget.existingZones.first.centerLongitude)
                              : const LatLng(30.0444, 31.2357),
                          zoom: 14,
                        ),
                        onMapCreated: (controller) {
                          _mapController = controller;
                          // 💡 أول ما الخريطة تفتح، نادي الدالة اللي بتعرضهم كلهم
                          _fitAllMarkers();
                        },
                        onTap: (LatLng location) {
                          setState(() {
                            newZoneLocation = location;
                            addressController.text = "${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}";
                          });
                        },
                        markers: _buildMapMarkers(),
                        circles: _buildMapCircles(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text('Zone Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTypeButton('Home', Icons.home, Colors.blue),
                      _buildTypeButton('School', Icons.school, Colors.green),
                      _buildTypeButton('Custom', Icons.location_city, Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text('Add Zone', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Zone Name'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'My home',
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Address'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: addressController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            hintText: 'Tap on the map to select...',
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            filled: true,
                            fillColor: Color(0xFFF5F5F5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: state is SafeZoneAddLoading ? null : _onSavePressed,
                      child: state is SafeZoneAddLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Save Zone Change', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 💡 الدالة السحرية اللي بتحسب أبعاد الشاشة عشان تعرض كل الماركرز
  void _fitAllMarkers() {
    if (widget.existingZones.isEmpty) return;

    // بنفترض إن أول نقطة هي أبعد وأقرب نقطة مؤقتاً
    double minLat = widget.existingZones.first.centerLatitude;
    double maxLat = widget.existingZones.first.centerLatitude;
    double minLng = widget.existingZones.first.centerLongitude;
    double maxLng = widget.existingZones.first.centerLongitude;

    // بنقارن باقي النقط عشان نجيب الحدود
    for (var zone in widget.existingZones) {
      if (zone.centerLatitude < minLat) minLat = zone.centerLatitude;
      if (zone.centerLatitude > maxLat) maxLat = zone.centerLatitude;
      if (zone.centerLongitude < minLng) minLng = zone.centerLongitude;
      if (zone.centerLongitude > maxLng) maxLng = zone.centerLongitude;
    }

    // لو هو ماركر واحد بس متعملش Bounds عشان هتضرب إيرور
    if (minLat == maxLat && minLng == maxLng) {
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(minLat, minLng), 14));
      return;
    }

    // بنعمل المربع الوهمي ونخلي الكاميرا تحضنه (زودنا نص ثانية عشان الماب تكون حملت بالكامل)
    Future.delayed(const Duration(milliseconds: 300), () {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );
      // رقم 50 ده Padding (مسافة من أطراف الشاشة عشان الماركرز متلزقش في الشاشة)
      _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
  }

  Set<Marker> _buildMapMarkers() {
    Set<Marker> markers = {};
    for (var zone in widget.existingZones) {
      markers.add(
          Marker(
            markerId: MarkerId('old_${zone.id}'),
            position: LatLng(zone.centerLatitude, zone.centerLongitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                zone.type.toLowerCase() == 'home' ? BitmapDescriptor.hueBlue :
                zone.type.toLowerCase() == 'school' ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueOrange
            ),
          )
      );
    }
    if (newZoneLocation != null) {
      markers.add(
          Marker(
            markerId: const MarkerId('new_zone'),
            position: newZoneLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          )
      );
    }
    return markers;
  }

  Set<Circle> _buildMapCircles() {
    Set<Circle> circles = {};
    for (var zone in widget.existingZones) {
      circles.add(
          Circle(
            circleId: CircleId('circle_${zone.id}'),
            center: LatLng(zone.centerLatitude, zone.centerLongitude),
            radius: zone.radius,
            fillColor: Colors.green.withOpacity(0.2),
            strokeColor: Colors.green,
            strokeWidth: 1,
          )
      );
    }
    return circles;
  }

  Widget _buildTypeButton(String type, IconData icon, Color color) {
    bool isSelected = selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => selectedType = type),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? color : Colors.transparent, width: 2),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 8),
            Text(type, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _onSavePressed() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a zone name')));
      return;
    }
    if (newZoneLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please tap on the map to select a location')));
      return;
    }

    context.read<SafeZoneCubit>().addSafeZone(
      name: nameController.text,
      lat: newZoneLocation!.latitude,
      lng: newZoneLocation!.longitude,
      type: selectedType,
    );
  }
}