/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

/// ===============================================================================
/// PAGINATED API JSON ============================================================
/// ===============================================================================
///
/// Generic class to parse paginated results from a Django backend
/// Specifically - the `PageNumberPagination` class
///
class PaginatedApiJson<T> {
  int? count;
  String? next;
  String? previous;
  List<T>? results;

  PaginatedApiJson({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  /// ===================================/
  ///
  /// JSON
  ///
  factory PaginatedApiJson.fromJson({required Map<String, dynamic> json, required Function fromJson}) => PaginatedApiJson<T>(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null ? null : List<T>.from(json["results"].map((dynamic x) => fromJson(x))),
      );
}
