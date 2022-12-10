import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'list_brands_event.dart';
part 'list_brands_state.dart';

class ListBrandsBloc extends HydratedBloc<ListBrandsEvent, ListBrandsState> {
  ListBrandsBloc() : super(const ListBrandsState()) {
    on<BrandsFetched>(_onBrandsFetched);
    on<SearchBrandChanged>(_onSearchBrandChanged);
    on<BrandSelected>(_onBrandSelected);
  }

  void _onBrandsFetched(
    BrandsFetched event,
    Emitter<ListBrandsState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    } else {
      emit(state.copyWith(
        listBrandsStatus: ListBrandsStatus.initial,
      ));
    }

    try {
      final brands = await _fetchBrands();

      return emit(
        state.copyWith(
          listBrandsStatus: ListBrandsStatus.success,
          brands: brands,
          brandsCopy: brands,
          hasReachedMax: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(listBrandsStatus: ListBrandsStatus.failure));
    }
  }

  void _onBrandSelected(
    BrandSelected event,
    Emitter<ListBrandsState> emit,
  ) async {
    emit(state.copyWith(
      selectedBrand: event.brand,
    ));
  }

  void _onSearchBrandChanged(
    SearchBrandChanged event,
    Emitter<ListBrandsState> emit,
  ) async {
    if (event.text.isEmpty) {
      return emit(
        state.copyWith(
          brandsCopy: state.brands,
        ),
      );
    }
    final brands = state.brands
        .where(
          (brand) =>
              brand.name!.toLowerCase().contains(event.text.toLowerCase()),
        )
        .toList();

    print(brands);

    emit(
      state.copyWith(
        brandsCopy: brands,
      ),
    );
  }

  Future<List<Brand>> _fetchBrands() async {
    QueryBuilder<Brand> query = QueryBuilder(Brand());
    query.includeObject(['models']);
    return query.find();
  }

  @override
  ListBrandsState? fromJson(Map<String, dynamic> json) {
    return ListBrandsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ListBrandsState state) {
    return state.toMap();
  }
}
