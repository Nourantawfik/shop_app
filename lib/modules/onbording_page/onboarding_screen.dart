import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_pro/modules/login_page/login_screen.dart';
import 'package:shop_pro/modules/network/local/chache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../componant/componant.dart';

class BoardingModel
{
  String image ;
  String title;
  String body ;
  BoardingModel({required this.image, required this.title, required this.body});
}

void submit(context)
{
  ChaceHelper.saveData(key: "onBoarding", value: true).then((value) {
    if(value)
      {
        NavigteAndFinish(context , LogInScreen() );
      }
  });
}

class OnBordingScreen extends StatefulWidget {

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  var onboardingController = PageController() ;

  bool? islaste ;

  @override
  Widget build(BuildContext context) {
    List<BoardingModel> onBoarding = [
      BoardingModel(
        image: 'https://img.freepik.com/premium-vector/coffee-shop-interior_1284-74277.jpg',
        title: " This is title ",
        body: "  this is body" ,
      ),
      BoardingModel(
          image: "'https://img.freepik.com/premium-vector/coffee-shop-interior_1284-74277.jpg' ",
          title:" This is title ",
          body:"  this is body" ,
      ) ,
      BoardingModel(
          image: "'https://img.freepik.com/premium-vector/coffee-shop-interior_1284-74277.jpg' ",
          title: " This is title ",
          body: "  this is body" ,
      ) ,
    ] ;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () {
            submit(context);
          }, child: Text('Skip' ,style: Theme.of(context).textTheme.bodyText1,)),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            Expanded(
              child: PageView.builder(
                onPageChanged: ((int index ){
                  if(index == onBoarding.length - 1)
                    {
                      setState((){

                        islaste = true ;
                      });

                    }
                  else
                    {
                      setState((){

                        islaste = false ;
                      });
                    }
                }),
                controller:onboardingController ,
                physics: BouncingScrollPhysics(),
                itemBuilder:((context, index) => OnBoardingDesign(onBoarding[index])) ,
                itemCount:3  ,
              ),
            ),
            SizedBox(height: 15,),

            Row(
              children: [
                SmoothPageIndicator(
                  controller: onboardingController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.brown[700]! ,
                    dotColor: Colors.brown[400]!,
                    expansionFactor:  2,
                    spacing: 5,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                Spacer(),

    FloatingActionButton(onPressed: (){
      if (islaste!)
        {
          submit(context);
        }else
          {
            onboardingController.nextPage(duration: Duration(microseconds:750), curve: Curves.fastLinearToSlowEaseIn);
          }

    } , child: Icon(Icons.arrow_forward_ios_outlined),

    ),
              ],
            ),

          ],
        ),
      ),
    );
  }

 Widget  OnBoardingDesign(BoardingModel model) =>
      Column(
        children: [
          Image(image: NetworkImage( model.image)) ,
          SizedBox(height: 10,) ,

          Text( model.title  ,) ,

          SizedBox(height: 10,) ,

          Text( model.body  ,),

          SizedBox(height: 10,) ,

        ],
      );
}
