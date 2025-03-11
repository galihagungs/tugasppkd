import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_new/local/dbHelper.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  DbHelper dbhelper = DbHelper();
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetProductAll) {
        try {
          emit(ProductLoading());
          final data = await dbhelper.getProduct();
          emit(ProductSucces(data));
        } catch (e) {
          emit(ProductFailed(e.toString()));
        }
      }
    });
  }
}
