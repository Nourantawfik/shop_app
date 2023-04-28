
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/modules/pages/search/cubit_search/search_states.dart';
import '../../../../models/search_model.dart';
import '../../../constant.dart';
import '../../../network/remote/dio.dart';
import '../../../network/remote/endpoint.dart';

class ShearchCubit extends Cubit<SearchStates> {

  ShearchCubit() : super(SearchInitialState()) ;

  static ShearchCubit get(context) => BlocProvider.of(context) ;



  ShearchModel? model ;
  void Search(String text )
  {
    emit(SearchLoadingSearchState());
    DioHelper.PostData(Url: PRODUCT_SEARCH,token: token, data: {
      'text' : text ,
    }).then((value) {
      model = ShearchModel.fromJson(value.data) ;

      emit(SearchSuccessSearchState(model!));

    })
        .catchError((error){
      print("SearchEroor is + $error");
      emit(SearchErrorSearchState(error));
    });

  }




}