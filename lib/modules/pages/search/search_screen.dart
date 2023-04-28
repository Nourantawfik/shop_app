import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/modules/constant.dart';
import '../../componant/componant.dart';
import 'cubit_search/search_cubit.dart';
import 'cubit_search/search_states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController() ;
  var formkey = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShearchCubit(),
       child :BlocConsumer<ShearchCubit ,SearchStates>(
      listener: (BuildContext context , SearchStates state){},
      builder: (BuildContext context , SearchStates state){
        return
        Scaffold(
            body:
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                          {
                            return  "enter text to search" ;
                          }

                      },
                      decoration: InputDecoration(

                        suffixIcon:  CircleAvatar(
                            radius: 15,
                            backgroundColor: defaultColor,
                            child: IconButton(onPressed: (){
                              ShearchCubit.get(context).Search(searchController.text);

                            }, icon: Icon(Icons.done))) ,
                        prefixIcon: Icon(Icons.search),
                        labelText: 'search' ,
                        hintText: 'search_here' ,
                        border: InputBorder.none ,

                      ),
                    ),
                    SizedBox(height: 20,) ,

                    if (state is SearchLoadingSearchState)
                    LinearProgressIndicator() ,
                    SizedBox(height: 10,),
                    if (state is SearchSuccessSearchState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, index) => buildListProduct(
                                                                                             //old_price
                            ShearchCubit.get(context).model!.data!.data![index], context, index,old_price: false
                        ) ,
                        separatorBuilder: (BuildContext context, index) => MyDivider(),
                        itemCount: ShearchCubit.get(context).model!.data!.data!.length ,
                      ),
                    ),

                  ],
                ),
              ),
            ),
    );
      },
       ),
    );
  }
}
