
// flights.dart
class Flights {
  String flightId;
  String departureTime;
  String arrivalTime;
  String departingCity;
  String arrivalCity;
  String ticketPrice;

  Flights({
    required this.flightId,
    required this.departureTime,
    required this.arrivalTime,
    required this.departingCity,
    required this.arrivalCity,
    required this.ticketPrice,
  });

  factory Flights.fromJson(Map<String, dynamic> json) {
    return Flights(
      flightId: json['flightId'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      departingCity: json['DepartingCity'],
      arrivalCity: json['arrivalCity'],
      ticketPrice: json['TicketPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flightId': flightId,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'DepartingCity': departingCity,
      'arrivalCity': arrivalCity,
      'TicketPrice': ticketPrice,
    };
  }
}