import 'dart:io';

class Point {
  int x;
  int y;

  Point(this.x, this.y);

  @override
  bool operator==(Object other) =>
      other is Point && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => "({$x, $y})";
}

class Edge {
  Point a;
  Point b;
  int side;

  Edge(this.a, this.b, this.side);

  bool merge(Edge o) {
    if (side != o.side) return false;

    if (b == o.a) {
      b = o.b;
      return true;
    }  else if (a == o.b) {
      a = o.a;
      return true;
    }

    return false;
  }

  @override
  String toString() => "$a$b | $side";
}

class Region {
  String type;
  int area;
  int perimeter;
  List<Point> plots;

  Region(this.type, this.area, this.perimeter, this.plots);
}

void day12(List<String> input) {
  final w = input[0].length;
  final h = input.length;

  final usedPlots = <int>{};
  final regions = <Region>[];

  bool checkPlot(int x, int y, String expected) {
    if (x < 0 || x >= w || y < 0 || y >= h) return false;
    
    return input[y][x] == expected;
  }

  void addPlotToRegion(Region region, int x, int y) {
    if (x < 0 || x >= w || y < 0 || y >= h) return;

    final index = y * w + x;
    if (usedPlots.contains(index)) return;

    region.area++;
    region.plots.add(Point(x, y));
    usedPlots.add(index);

    if (!checkPlot(x + 1, y, region.type)) {
      region.perimeter++;
    } else {
      addPlotToRegion(region, x + 1, y);
    }

    if (!checkPlot(x - 1, y, region.type)) {
      region.perimeter++;
    } else {
      addPlotToRegion(region, x - 1, y);
    }

    if (!checkPlot(x, y + 1, region.type)) {
      region.perimeter++;
    } else {
      addPlotToRegion(region, x, y + 1);
    }

    if (!checkPlot(x, y - 1, region.type)) {
      region.perimeter++;
    } else {
      addPlotToRegion(region, x, y - 1);
    }
  }

  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      final index = y * w + x;
      if (!usedPlots.contains(index)) {
        final region = Region(input[y][x], 0, 0, <Point>[]);
        addPlotToRegion(region, x, y);
        regions.add(region);
      }
    }
  }

  var cost = 0;
  for (final region in regions) {
    cost += region.area * region.perimeter;
  }

  print(cost);

  var costPart2 = 0;
  for (final region in regions) {
    var edges = <Edge>[];

    // Add all edges
    for (var plot in region.plots) {
      edges.add(Edge(Point(plot.x, plot.y), Point(plot.x + 1, plot.y), 0));
      edges.add(Edge(Point(plot.x + 1, plot.y), Point(plot.x + 1, plot.y + 1), 1));
      edges.add(Edge(Point(plot.x, plot.y), Point(plot.x, plot.y + 1), 2));
      edges.add(Edge(Point(plot.x, plot.y + 1), Point(plot.x + 1, plot.y + 1), 3));
    }

    // Remove overlapping edges
    var edgesToRemove = <Edge>{};
    for (var edge in edges) {
      var overlapping = edges.where((x) => x.a == edge.a && x.b == edge.b);
      if (overlapping.length > 1) {
        edgesToRemove.addAll(overlapping);
      }
    }

    for (var edge in edgesToRemove)  {
      edges.remove(edge);
    }

    // Merge any continous edges
    var anyMerge = true;
    while (anyMerge) {
      anyMerge = false;
      for (var i = 0; i < edges.length; i++) {
        for (var j = i; j < edges.length; j++) {
          if (edges[i].merge(edges[j])) {
            edges.removeAt(j);
            j--;
            anyMerge = true;
          }
        }
      }
    }

    costPart2 += region.area * edges.length;
  }

  print(costPart2);
}