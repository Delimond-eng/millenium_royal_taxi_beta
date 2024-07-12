import '/models/story_address.dart';

import '/models/address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const List<Address> myAddresses = [
  const Address(
    id: '01',
    title: 'Home',
    city: 'Port Harcourt',
    country: 'Nigeria',
    latLng: LatLng(4.807200, 7.021780),
    polylines: [],
    postcode: '',
    state: 'Rivers',
    street: 'Trans - Amadi',
  ),
  const Address(
    id: '02',
    title: 'Office',
    city: 'Port Harcourt',
    country: 'Nigeria',
    latLng: LatLng(4.757670, 7.033320),
    polylines: [],
    postcode: '540001',
    state: 'Rivers',
    street: 'NEW GRA',
  ),
];

final List<StoryAddress> destinations = [
  StoryAddress(
    title: 'Avenue O.U.A 25',
  ),
  StoryAddress(
    title: 'Avenue Kasangani',
  ),
  StoryAddress(
    title: 'Avenue Douane 15338',
  ),
  StoryAddress(
    title: 'Avenue Isiro 10',
  ),
];
