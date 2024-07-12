import '/models/ride_option.dart';
import '/utils/icons_assets.dart';

List<RideOption> rideOptions = [
  RideOption(
    id: '00',
    title: 'Standard',
    timeOfArrival: DateTime.now().add(const Duration(minutes: 5)),
    price: 2500,
    icon: IconsAssets.stardard_car,
  ),
  RideOption(
    id: '01',
    title: 'Confort',
    timeOfArrival: DateTime.now().add(const Duration(minutes: 3)),
    price: 5500,
    icon: IconsAssets.premium_car,
  ),
  RideOption(
    id: '02',
    title: 'VIP',
    timeOfArrival: DateTime.now().add(const Duration(minutes: 2)),
    price: 8000,
    icon: IconsAssets.vip_car,
  ),
];
