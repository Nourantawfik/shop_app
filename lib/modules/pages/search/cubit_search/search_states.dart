
import 'package:shop_pro/models/search_model.dart';



 abstract class SearchStates {}

 class SearchInitialState extends SearchStates {}

 //search
 class SearchLoadingSearchState extends SearchStates{}

 class SearchSuccessSearchState extends SearchStates{

   final ShearchModel? model ;
   SearchSuccessSearchState(this.model);
 }

 class SearchErrorSearchState extends SearchStates {
   String error;

   SearchErrorSearchState(this.error);
 }