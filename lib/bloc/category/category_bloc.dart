import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_new/model/categoryModel.dart';
import 'package:ui_new/service/categorydata.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is GetCatetgory) {
        emit(CategoryLoading());
        final data = await CatergoryDataJson().getCategory();
        emit(CategorySucces(data));
      }
    });
  }
}
