import 'dart:math';
import 'package:fleet_customer/models/orders.dart';
import 'package:flutter/material.dart';

class TspViewModel with ChangeNotifier {
  double bestDistance;
  List<int> bestRoute;
  List<StopPoint> stopPoints;

  double distancePoint(StopPoint a, StopPoint b) {
    double earthRadius = 6371;
    var lat1 = a.lat * pi / 180;
    var lat2 = b.lat * pi / 180;
    var lng1 = a.lng * pi / 180;
    var lng2 = b.lng * pi / 180;
    var dLat = (lat2 - lat1);
    var dLng = (lng2 - lng1);
    var d = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLng / 2) * sin(dLng / 2);
    var c = 2 * atan2(sqrt(d), sqrt(1 - d));
    return earthRadius * c;
  }

  // Tạo ra tất cả các hoán vị có thể của một danh sách các số nguyên
  List<List<int>> permute(List<int> data, int start) {
    var result = <List<int>>[];
    if (start == data.length - 1) {
      result.add(List.of(data));
    } else {
      for (var i = start; i < data.length; i++) {
        var dataCopy = List.of(data);
        dataCopy[start] = data[i];
        dataCopy[i] = data[start];
        result.addAll(permute(dataCopy, start + 1));
      }
    }
    return result;
  }

  void optimizeRoute(List<StopPoint> points) {
    int n = points.length;
    bestDistance = double.infinity; // Dương vô cùng
    for (var route in permute(List.generate(n, (i) => i), 0)) {
      double distance = 0.0;
      for (int i = 0; i < n - 1; i++) {
        distance += distancePoint(points[route[i]], points[route[i + 1]]);
      }
      if (distance < bestDistance) {
        bestDistance = distance;
        bestRoute = route;
      }
    }
    stopPoints = List.generate(points.length, (i) => points[bestRoute[i]]);
    notifyListeners();
  }

  // Kết hợp Exhaustive search và Branch and Bound
  // double tourCost(List<int> tour, List<StopPoint> points) {
  //   double cost = 0;
  //   for (int i = 0; i < tour.length - 1; i++) {
  //     cost += distancePoint(points[tour[i]], points[tour[i + 1]]);
  //   }
  //   cost += distancePoint(points[tour.last], points[tour.first]);
  //   return cost;
  // }

  // bool isTourBetter(List<int> tour, List<StopPoint> points) {
  //   double cost = tourCost(tour, points);
  //   return cost < bestDistance;
  // }

  // List<int> branchAndBound(List<int> currentTour, List<StopPoint> points) {
  //   int n = points.length;
  //   List<int> bestTour = List.generate(n, (i) => i);
  //   double bestCost = double.infinity;
  //   List<List<int>> queue = [currentTour];
  //   while (queue.isNotEmpty) {
  //     List<int> current = queue.removeAt(0);
  //     if (isTourBetter(current, points)) {
  //       for (int i = 1; i < n - 1; i++) {
  //         for (int j = i + 1; j < n; j++) {
  //           List<int> neighbor = List.of(current);
  //           neighbor[i] = current[j];
  //           neighbor[j] = current[i];
  //           queue.add(neighbor);
  //         }
  //       }
  //     } else {
  //       continue;
  //     }
  //     if (tourCost(current, points) < bestCost) {
  //       bestTour = List.of(current);
  //       bestCost = tourCost(current, points);
  //     }
  //   }
  //   return bestTour;
  // }

  // void optimizeRoute(List<StopPoint> points) {
  //   int n = points.length;
  //   List<int> currentTour = List.generate(n, (i) => i);
  //   List<List<int>> permutations = permute(currentTour, 1);
  //   for (List<int> tour in permutations) {
  //     if (isTourBetter(tour, points)) {
  //       bestRoute = tour;
  //       bestDistance = tourCost(tour, points);
  //     }
  //   }
  //   List<int> branchAndBoundTour = branchAndBound(currentTour, points);
  //   if (isTourBetter(branchAndBoundTour, points)) {
  //     bestRoute = branchAndBoundTour;
  //     bestDistance = tourCost(branchAndBoundTour, points);
  //   }
  //   stopPoints = List.generate(points.length, (i) => points[bestRoute[i]]);
  //   notifyListeners();
  // }
}
