import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/location_traking_view/cubit/safe_zone_cubit_states.dart';
import 'dart:convert';

import 'package:smartkids_gurad/features/location_traking_view/data/models/safe_zone_model.dart';


class LocationTrackingView extends StatefulWidget {
  const LocationTrackingView({super.key});

  @override
  State<LocationTrackingView> createState() => _LocationTrackingViewState();
}

class _LocationTrackingViewState extends State<LocationTrackingView> {
  HubConnection? _hubConnection;
  GoogleMapController? _mapController;

  LatLng? _currentLocation; // اللوكيشن اللي هييجي من السوكيت
  bool _isLoadingMap = true; // عشان نعرض اللودينج في البداية

  // 💡 متغيرات الكاميرا والدوائر
  bool _isFollowingChild = true; // هل الكاميرا مركزة على الطفل؟
  Set<Circle> _mapCircles = {}; // الدوائر الخضراء
  Set<Marker> _mapMarkers = {}; // العلامات (الطفل والمنطقة)
  @override
  void initState() {
    super.initState();
    _initSignalR();
  }

  Future<void> _initSignalR() async {
    // 1. بناء الاتصال
    _hubConnection = HubConnectionBuilder()
        .withUrl(
      'https://smartkidsguard-production.up.railway.app/hubs/location',
      options: HttpConnectionOptions(
        accessTokenFactory: () async => CacheHelper.getData(key: 'token'), // 💡 حط التوكن بتاعك هنا
      ),
    )
        .build();

    // 2. الاستماع لحدث استقبال اللوكيشن
    _hubConnection?.on("ReceiveLocation", _handleReceiveLocation);

    // 3. تشغيل الاتصال وطلب الانضمام لجروب الطفل
    try {
      await _hubConnection?.start();
      print("SignalR Connected Successfully");
      int? currentChildId = CacheHelper.getData(key: 'current_child_id');
      await _hubConnection?.invoke("JoinChildGroup", args: [currentChildId ?? 1024]);
      if (mounted) {
        setState(() {
          _currentLocation = const LatLng(30.0444, 31.2357); // القاهرة مثلاً
          _isLoadingMap = false;
          _updateChildMarker(); // رسم ماركر الطفل
        });
      }
    } catch (e) {
      print("Error connecting to SignalR: $e");
      // ممكن هنا تهندل الـ Error state
    }
  }

  void _handleReceiveLocation(List<dynamic>? parameters) {
    print("🚀 SignalR Payload Received: $parameters");

    if (parameters != null && parameters.isNotEmpty) {
      try {
        final payload = parameters.first;
        Map<String, dynamic> data;

        // 💡 بنسأل فلاتر: الداتا دي جاية نص String ولا جاية متظبطة Object؟
        if (payload is String) {
          // لو الباك إند بعتها نص (زي كود الهاردوير)، بنفكها إحنا لـ JSON
          data = jsonDecode(payload);
        } else if (payload is Map) {
          // لو الباك إند محولها جاهز، بناخدها زي ما هي
          data = Map<String, dynamic>.from(payload);
        } else {
          print("⚠️ Unknown format received.");
          return;
        }

        // الكلمات ظهرت في كود الهاردوير إنها سمول
        final double lat = (data['latitude'] ?? 0.0) as double;
        final double lng = (data['longitude'] ?? 0.0) as double;

        if (lat == 0.0 && lng == 0.0) {
          print("⚠️ Location is 0.0 (No GPS Signal Yet), ignoring.");
          return;
        }

        setState(() {
          _currentLocation = LatLng(lat, lng);
          _isLoadingMap = false;
          _updateChildMarker();
        });

// 💡 لو إحنا مش بنستكشف منطقة آمنة، خلي الكاميرا تمشي ورا الطفل
        if (_isFollowingChild) {
          _mapController?.animateCamera(CameraUpdate.newLatLng(_currentLocation!));
        }      } catch (e) {
        print("❌ Error parsing location data: $e");
      }
    }
  }
  // 💡 تحديث ماركر الطفل
  void _updateChildMarker() {
    if (_currentLocation == null) return;

    // بنفلتر الماركرز عشان نشيل ماركر الطفل القديم ونحط الجديد
    _mapMarkers.removeWhere((m) => m.markerId.value == 'child_marker');
    _mapMarkers.add(
      Marker(
        markerId: const MarkerId('child_marker'),
        position: _currentLocation!,
        // icon: BitmapDescriptor.fromAssetImage(...) // لو معاك صورة حطها هنا
      ),
    );
  }
  // 💡 دالة بتشتغل لما ندوس على الكارت
  void _focusOnSafeZone(SafeZoneModel zone) {
    setState(() {
      _isFollowingChild = false; // وقف تتبع الطفل مؤقتاً

      final zoneLatLng = LatLng(zone.centerLatitude, zone.centerLongitude);

      // رسم الدايرة الخضراء
      _mapCircles = {
        Circle(
          circleId: CircleId('zone_${zone.id}'),
          center: zoneLatLng,
          radius: zone.radius, // الرادياس اللي راجع من الباك
          fillColor: Colors.green.withOpacity(0.2), // لون شفاف من جوه
          strokeColor: Colors.green, // حدود الدايرة
          strokeWidth: 2,
        )
      };

      // رسم ماركر في نص الدايرة
      _mapMarkers.removeWhere((m) => m.markerId.value == 'zone_marker');
      _mapMarkers.add(
        Marker(
          markerId: const MarkerId('zone_marker'),
          position: zoneLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), // ماركر أخضر
        ),
      );
    });

    // تحريك الكاميرا للمنطقة (زوم 16 كويس للمناطق)
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(zone.centerLatitude, zone.centerLongitude), 16));
  }

  // 💡 دالة الرجوع للطفل
  void _backToChildLocation() {
    if (_currentLocation == null) return;
    setState(() {
      _isFollowingChild = true;
      _mapCircles.clear(); // مسح الدوائر
      _mapMarkers.removeWhere((m) => m.markerId.value == 'zone_marker'); // مسح ماركر المنطقة
    });
    // تحريك الكاميرا للطفل تاني
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(_currentLocation!, 16));
  }
  @override
  void dispose() {
    _hubConnection?.stop(); // مهم جداً تقفل السوكيت لما تطلع من الشاشة
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Column(
          children: [
            // 1. App Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // 💡 كده هيرجعك للرئيسية بأمان بدل ما يقفل الأبلكيشن
                      Navigator.pushNamedAndRemoveUntil(context, RoutesManager.homeScreen, (route) => false);
                    },
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                  ),                  const Text(
                    "Location Tracking",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // 2. Map Section
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _isLoadingMap
                    ? const Center(child: CircularProgressIndicator(color: ColorsManager.bluee))
                    : Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _currentLocation!,
                          zoom: 16,
                        ),
                        onMapCreated: (controller) => _mapController = controller,
                        markers: _mapMarkers,
                        circles: _mapCircles, // ربطنا الدوائر هنا
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                      ),
                    ),
                    // 💡 زرار العودة للطفل بيظهر بس لو إحنا مش متابعين الطفل
                    if (!_isFollowingChild)
                      Positioned(
                        top: 16,
                        right: 16,
                        child: FloatingActionButton.extended(
                          onPressed: _backToChildLocation,
                          backgroundColor: Colors.white,
                          icon: const Icon(Icons.person_pin_circle, color: ColorsManager.bluee),
                          label: const Text("Back to Child", style: TextStyle(color: Colors.black)),
                        ),
                      )
                  ],
                ),
              ),
            ),

            // 3. Safe Zones Section (From API)
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Safe Zones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () {
                            List<SafeZoneModel> currentZones = [];
                            if (context.read<SafeZoneCubit>().state is SafeZoneSuccess) {
                              currentZones = (context.read<SafeZoneCubit>().state as SafeZoneSuccess).safeZones;
                            }
                            Navigator.pushNamed(context, RoutesManager.addSafeZoneScreen, arguments: currentZones)
                                .then((_) {
                              context.read<SafeZoneCubit>().fetchSafeZones();
                            });
                          },
                          child: const Text("Add New", style: TextStyle(color: ColorsManager.bluee)),
                        ),
                      ],
                    ),
                    Expanded(
                      // 💡 غيرنا الـ Builder لـ Consumer عشان نطلع رسالة المسح
                      child: BlocConsumer<SafeZoneCubit, SafeZoneState>(
                        listenWhen: (previous, current) {
                          // بنسمع بس لحالات المسح عشان نطلع الـ SnackBar
                          return current is SafeZoneDeleteSuccess || current is SafeZoneDeleteError;
                        },
                        listener: (context, state) {
                          if (state is SafeZoneDeleteSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.green));
                          } else if (state is SafeZoneDeleteError) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.red));
                          }
                        },
                        buildWhen: (previous, current) {
                          // 💡 الشاشة مش هتعمل Rebuild غير في الحالات دي بس، يعني وقت المسح اللستة مش هتختفي
                          return current is SafeZoneLoading ||
                              current is SafeZoneSuccess ||
                              current is SafeZoneError;
                        },
                        builder: (context, state) {
                          if (state is SafeZoneLoading) {
                            return const Center(child: CircularProgressIndicator(color: ColorsManager.bluee));
                          } else if (state is SafeZoneError) {
                            return Center(child: Text(state.error, style: const TextStyle(color: Colors.red)));
                          } else if (state is SafeZoneSuccess) {
                            final zones = state.safeZones;
                            if (zones.isEmpty) {
                              return const Center(child: Text("No Safe Zones found.", style: TextStyle(color: Colors.grey)));
                            }
                            return ListView.separated(
                              itemCount: zones.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final zone = zones[index];
                                // 💡 باصينا الـ context هنا عشان نقدر نكلم الـ Cubit من جوه الكارت
                                return _buildSafeZoneCard(zone, context);
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 💡 دالة رسم الكارت مربوطة بالداتا الحقيقية وتغيير الأيقونات والألوان
// 💡 ضفنا BuildContext context كـ Parameter
  Widget _buildSafeZoneCard(SafeZoneModel zone, BuildContext context) {
    IconData icon;
    Color iconColor;

    String typeLower = zone.type.toLowerCase();

    if (typeLower == 'home') {
      icon = Icons.home;
      iconColor = Colors.blue;
    } else if (typeLower == 'school') {
      icon = Icons.school;
      iconColor = Colors.green;
    } else {
      icon = Icons.location_city;
      iconColor = Colors.redAccent;
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)
          ]),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _focusOnSafeZone(zone);
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.2),
              child: Icon(icon, color: iconColor),
            ),
            title: Text(zone.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(zone.type, style: const TextStyle(color: Colors.grey)),
            // 💡 حطينا الدرع الأخضر وأيقونة المسح الحمرا جنب بعض في Row
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shield_outlined, color: Colors.green),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    // 💡 التريكة: لو مسحنا المنطقة اللي إحنا عاملين عليها فوكس دلوقتي، الخريطة ترجع للطفل أوتوماتيك
                    if (!_isFollowingChild && _mapCircles.isNotEmpty && _mapCircles.first.circleId.value == 'zone_${zone.id}') {
                      _backToChildLocation();
                    }
                    // بنكلم السيرفر يمسح
                    context.read<SafeZoneCubit>().deleteSafeZone(zone.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }}