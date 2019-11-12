import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_food_app/network/network.dart';
import 'package:flutter_food_app/services/webservice.dart';

CarList carList = CarList(carList: [
  Car(id: 1, category_id: 1, cm_3: 2000, fuel_id: 1, description: desc,
    brand: "Audi", model: "A4", fuel: "Benzyna", localimodelzation: "Wroclaw",
  category: "Sedan", photo: "https://firebasestorage.googleapis.com/v0/b/cars-2f419.appspot.com/o/cars%2F0%2F0.jpg?alt=media&token=8088ea82-8aca-4e95-a7c6-eeaf3e1df2c1",
  price: 30000, lat: 51.22531, lng: 22.622037, auction: true, featured: true,
  year: 2010, km: 214000),

  Car(id: 1, category_id: 1, cm_3: 2000, fuel_id: 1, description: desc,
      brand: "Audi", model: "A4", fuel: "Benzyna", localimodelzation: "Wroclaw",
      category: "Sedan", photo: "https://firebasestorage.googleapis.com/v0/b/cars-2f419.appspot.com/o/cars%2F0%2F0.jpg?alt=media&token=8088ea82-8aca-4e95-a7c6-eeaf3e1df2c1",
      price: 30000, lat: 51.22531, lng: 22.622037, auction: false, featured: true,
      year: 2010, km: 214000),

  Car(id: 1, category_id: 1, cm_3: 2000, fuel_id: 1, description: desc,
      brand: "Audi", model: "A4", fuel: "Benzyna", localimodelzation: "Wroclaw",
      category: "Sedan", photo: "https://firebasestorage.googleapis.com/v0/b/cars-2f419.appspot.com/o/cars%2F0%2F0.jpg?alt=media&token=8088ea82-8aca-4e95-a7c6-eeaf3e1df2c1",
      price: 30000, lat: 51.22531, lng: 22.622037, auction: false, featured: true,
      year: 2010, km: 214000),

  Car(id: 1, category_id: 1, cm_3: 2000, fuel_id: 1, description: "Some good car",
      brand: "Audi", model: "A4", fuel: "Benzyna", localimodelzation: "Wroclaw",
      category: "Sedan", photo: "https://firebasestorage.googleapis.com/v0/b/cars-2f419.appspot.com/o/cars%2F0%2F0.jpg?alt=media&token=8088ea82-8aca-4e95-a7c6-eeaf3e1df2c1",
      price: 30000, lat: 51.22531, lng: 22.622037, auction: false, featured: true,
      year: 2010, km: 214000),

  Car(id: 1, category_id: 1, cm_3: 2000, fuel_id: 1, description: "Some good car",
      brand: "Audi", model: "A4", fuel: "Benzyna", localimodelzation: "Wroclaw",
      category: "Sedan", photo: "https://firebasestorage.googleapis.com/v0/b/cars-2f419.appspot.com/o/cars%2F0%2F0.jpg?alt=media&token=8088ea82-8aca-4e95-a7c6-eeaf3e1df2c1",
      price: 30000, lat: 51.22531, lng: 22.622037, auction: true, featured: true,
      year: 2010, km: 214000),

  Car(id: 1, category_id: 1, cm_3: 2000, fuel_id: 1, description: "Some good car",
      brand: "Audi", model: "A4", fuel: "Benzyna", localimodelzation: "Wroclaw",
      category: "Sedan", photo: "https://firebasestorage.googleapis.com/v0/b/cars-2f419.appspot.com/o/cars%2F0%2F0.jpg?alt=media&token=8088ea82-8aca-4e95-a7c6-eeaf3e1df2c1",
      price: 30000, lat: 51.22531, lng: 22.622037, auction: false, featured: true,
      year: 2010, km: 214000),

  Car(id: 1, category_id: 1, cm_3: 2000, fuel_id: 1, description: "Some good car",
      brand: "Audi", model: "A4", fuel: "Benzyna", localimodelzation: "Wroclaw",
      category: "Sedan", photo: "https://firebasestorage.googleapis.com/v0/b/cars-2f419.appspot.com/o/cars%2F0%2F0.jpg?alt=media&token=8088ea82-8aca-4e95-a7c6-eeaf3e1df2c1",
      price: 30000, lat: 51.22531, lng: 22.622037, auction: false, featured: true,
      year: 2010, km: 214000)
]);

class CarList {
  List<Car> carList;

  CarList({@required this.carList});
}

class Car {
  int id;
  int category_id;
  int cm_3;
  int fuel_id;
  String description;
  String brand;
  String model;
  String fuel;
  String localimodelzation;
  String category;
  String photo;
  int price;
  double lat;
  double lng;
  bool auction;
  bool featured;
  int year;
  int km;

  Car({@required this.id,
      @required this.category_id,
      @required this.cm_3,
      @required this.fuel_id,
      @required this.description,
      @required this.brand,
      @required this.model,
      @required this.fuel,
      @required this.localimodelzation,
      @required this.category,
      @required this.photo,
      @required this.price,
      @required this.lat,
      @required this.lng,
      @required this.auction,
      @required this.featured,
      @required this.year,
      @required this.km});


  factory Car.fromJson(Map<String,dynamic> json) {
    return Car(
      id: json['id'] as int,
      category_id: json['category_id'] as int,
      cm_3: json['cm_3'] as int,
      fuel_id: json['fuel_id'] as int,
      description: json['description'],
      brand: json['brand'],
      model: json['model'],
      fuel: json['fuel'],
      localimodelzation: json['localimodelzation'],
      category: json['category'],
      photo: json['photo'], //?? ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL
      price: json['price'] as int,
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      auction: json['auction'] as bool,
      featured: json['featured'] == "true",
      year: json['year'] as int,
      km: json['km'] as int,
    );
  }

  static Resource<List<Car>> get all {

    return Resource(
        url: Network.CARS,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Car.fromJson(model)).toList();
        }
    );

  }


}

String desc = "AAA AUTO – największy dealer samochodów używanych w Europie Środkowej! Jesteśmy właścicielem wszystkich aut znajdujących się w naszej ofercie! NASZE ATUTY:  1. Jesteśmy właścicielami sprzedawanych pojazdów. Samochody oferowane w AAA AUTO wyróżniają się jakością i można je kupić w rozsądnej cenie. 2. Niemal 2 miliony zadowolonych klientów w 25-letniej historii firmy. 3. Specjalizujemy się w pojazdach krajowych - aż 80% naszych aut to pojazdy, które były pierwotnie zarejestrowane w Polsce. 4. W AAA AUTO przeprowadzamy kontrolę stanu licznika oraz liczby faktycznie przejechanych kilometrów. 5. Zapewniamy dożywotnią gwarancję legalnego pochodzenia pojazdu oraz Carlife - ubezpieczenie gwarancyjne na stan mechaniczny pojazdu do 36 miesięcy. 6. Umożliwiamy zawarcie umowy kredytu 7 dni w tygodniu* ( w tygodniu z niedzielą handlową), wpłata własna pod 0%. 7. Oferujemy OC i AC tańsze nawet do 30%. Wszystkie formalności można załatwić w naszym salonie. 8. Płacimy nawet do 20% więcej za Twój samochód, jeśli nowy kupisz u nas. 9. Oferujemy Profram \\\"7 dni na wymianę auta bez podania powodu\\\" 10. Umożliwiamy skorzystanie z długiej jazdy próbnej. 11. Kredyt dostępny na każde auto.";