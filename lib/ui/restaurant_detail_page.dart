import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/cubit/database/database_cubit.dart';
import 'package:restaurant_app/cubit/restaurant/restaurant_cubit.dart';
import 'package:restaurant_app/cubit/review/review_cubit.dart';
import 'package:restaurant_app/model/restaurant/restaurant_detail.dart';
import 'package:restaurant_app/model/review/review_request.dart';
import 'package:restaurant_app/util/navigation.dart';
import 'package:restaurant_app/widgets/loading_button.dart';
import 'package:restaurant_app/widgets/refresh_widget.dart';
import 'package:restaurant_app/widgets/restaurant_animation_container.dart';
import 'package:restaurant_app/widgets/restaurant_detail_shimmer.dart';
import 'package:restaurant_app/widgets/restaurant_menu_tile.dart';
import 'package:restaurant_app/widgets/review_tile.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String? id;

  const RestaurantDetailPage({Key? key, this.id}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  RestaurantCubit _restaurantCubit = RestaurantCubit();
  late String restaurantId;
  bool isFavorite = false;
  late RestaurantDetail restaurantDetailData;

  @override
  void initState() {
    super.initState();
    restaurantId = widget.id ?? Get.arguments['id'];
    _restaurantCubit.getRestaurantById(restaurantId);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RestaurantCubit>(
          create: (context) => _restaurantCubit,
        ),
        BlocProvider<DatabaseCubit>(
          create: (context) =>
              DatabaseCubit()..isRestaurantFavorite(restaurantId),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<DatabaseCubit, DatabaseState>(
              listener: (context, state) {
            if (state is DatabaseDataInsertSuccess) {
              Get.showSnackbar(GetBar(
                message: 'Added to favorite',
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                borderRadius: 15,
              ));
            } else if (state is DatabaseDataDeleteSuccess) {
              Get.showSnackbar(GetBar(
                message: 'Deleted from favorite',
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                borderRadius: 15,
              ));
            } else if (state is DatabaseDataError) {
              Get.showSnackbar(GetBar(
                message: state.errorMessage,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 3),
                borderRadius: 15,
              ));
            } else if (state is DatabaseDataStatus) {
              isFavorite = state.status;
            }
          }),
          BlocListener<RestaurantCubit, RestaurantState>(
            listener: (context, state) {
              if (state is RestaurantLoadError) {
                Get.showSnackbar(GetBar(
                  message: state.errorMessage,
                  margin: EdgeInsets.all(10),
                  duration: Duration(seconds: 4),
                  borderRadius: 15,
                ));
              }
            },
          ),
        ],
        child: Scaffold(
          body: RefreshWidget(
            onRefresh: () async {
              _restaurantCubit.getRestaurantById(restaurantId);
            },
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _animationController,
                child: Column(
                  children: [
                    Container(
                      height: 280,
                      child: Stack(
                        children: [
                          BlocConsumer<RestaurantCubit, RestaurantState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return RestaurantAnimationContainer(
                                animationController: _animationController,
                                width: double.infinity,
                                begin: Offset(0, -1),
                                end: Offset.zero,
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(15),
                                  ),
                                  color: Colors.amber,
                                ),
                                child: state is RestaurantDetailLoadSuccess
                                    ? Hero(
                                        tag: state.restaurantDetail.pictureId,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(15),
                                          ),
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.3),
                                              BlendMode.multiply,
                                            ),
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/food-plate.png',
                                              image:
                                                  'https://restaurant-api.dicoding.dev/images/medium/${state.restaurantDetail.pictureId}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            right: 25,
                            child: BlocBuilder<DatabaseCubit, DatabaseState>(
                                builder: (context, state) {
                              return RestaurantAnimationContainer(
                                key: Key('favorite_button'),
                                animationController: _animationController,
                                begin: Offset(1, 0),
                                end: Offset.zero,
                                child: Card(
                                  elevation: 1,
                                  shape: CircleBorder(),
                                  color: Colors.amber,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      if (!isFavorite)
                                        context
                                            .read<DatabaseCubit>()
                                            .insertToFavorite(
                                                restaurantDetailData);
                                      else
                                        context
                                            .read<DatabaseCubit>()
                                            .removeDataFromFavorite(
                                                restaurantDetailData);
                                      context
                                          .read<DatabaseCubit>()
                                          .isRestaurantFavorite(restaurantId);
                                    },
                                    child: Container(
                                      width: 65,
                                      height: 65,
                                      child: Center(
                                        child: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: BlocBuilder<RestaurantCubit, RestaurantState>(
                        builder: (context, state) {
                          if (state is RestaurantDetailLoadSuccess) {
                            restaurantDetailData = state.restaurantDetail;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RestaurantAnimationContainer(
                                  animationController: _animationController,
                                  begin: Offset(-1, 0),
                                  end: Offset.zero,
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    restaurantDetailData.name,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                RestaurantAnimationContainer(
                                  animationController: _animationController,
                                  begin: Offset(-1, 0),
                                  end: Offset.zero,
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on, size: 20),
                                      SizedBox(width: 5),
                                      Text(
                                        restaurantDetailData.city,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .apply(color: Colors.black),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '|',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.star, size: 20),
                                      SizedBox(width: 5),
                                      Text(
                                        '${restaurantDetailData.rating}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .apply(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                RestaurantAnimationContainer(
                                  animationController: _animationController,
                                  begin: Offset(-1, 0),
                                  end: Offset.zero,
                                  margin: const EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.amber,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Deskripsi',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .apply(color: Colors.black),
                                    ),
                                  ),
                                ),
                                RestaurantAnimationContainer(
                                  animationController: _animationController,
                                  begin: Offset(-1, 0),
                                  end: Offset.zero,
                                  margin: const EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  child: Text(
                                    restaurantDetailData.description,
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                RestaurantAnimationContainer(
                                  animationController: _animationController,
                                  begin: Offset(-1, 0),
                                  end: Offset.zero,
                                  margin: const EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.amber,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Makanan',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .apply(color: Colors.black),
                                    ),
                                  ),
                                ),
                                RestaurantAnimationContainer(
                                  animationController: _animationController,
                                  begin: Offset(0, 1),
                                  end: Offset.zero,
                                  margin: const EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 150,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: restaurantDetailData
                                          .menus.foods.length,
                                      itemExtent: 200,
                                      itemBuilder: (context, index) {
                                        Category restaurantFood =
                                            restaurantDetailData
                                                .menus.foods[index];
                                        return RestaurantMenuTile(
                                            restaurantMenuData: restaurantFood);
                                      }),
                                ),
                                RestaurantAnimationContainer(
                                  animationController: _animationController,
                                  begin: Offset(-1, 0),
                                  end: Offset.zero,
                                  margin: const EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.amber,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Minuman',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!
                                          .apply(color: Colors.black),
                                    ),
                                  ),
                                ),
                                RestaurantAnimationContainer(
                                  animationController: _animationController,
                                  begin: Offset(0, 1),
                                  end: Offset.zero,
                                  margin: const EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 150,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: restaurantDetailData
                                          .menus.drinks.length,
                                      itemExtent: 200,
                                      itemBuilder: (context, index) {
                                        Category restaurantDrink =
                                            restaurantDetailData
                                                .menus.drinks[index];
                                        return RestaurantMenuTile(
                                            restaurantMenuData:
                                                restaurantDrink);
                                      }),
                                ),
                                RestaurantAnimationContainer(
                                  animationController: _animationController,
                                  begin: Offset(-1, 0),
                                  end: Offset.zero,
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      primary: Colors.amber,
                                      side: BorderSide(color: Colors.amber),
                                    ),
                                    onPressed: () => showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15),
                                        ),
                                      ),
                                      enableDrag: true,
                                      builder: (context) =>
                                          RestaurantReviewBottomSheet(
                                        customerReviewData: restaurantDetailData
                                            .customerReviews,
                                      ),
                                    ),
                                    child: Text(
                                      'Lihat Review '
                                      '(${restaurantDetailData.customerReviews.length})',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (state is RestaurantLoading) {
                            return RestaurantDetailShimmer();
                          } else {
                            return Center(
                              child: Text('No data'),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => RestaurantReviewDialog(
                  id: restaurantId,
                ),
              );
            },
            backgroundColor: Colors.amber,
            child: Icon(
              Icons.reviews,
            ),
            tooltip: 'Tulis Review Baru',
          ),
        ),
      ),
    );
  }
}

class RestaurantReviewBottomSheet extends StatelessWidget {
  const RestaurantReviewBottomSheet({
    Key? key,
    required this.customerReviewData,
  }) : super(key: key);

  final List<CustomerReview> customerReviewData;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 25,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    controller: controller,
                    itemExtent: 100,
                    itemCount: customerReviewData.length,
                    itemBuilder: (context, index) {
                      return ReviewTile(
                          customerReview: customerReviewData[index]);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantReviewDialog extends StatelessWidget {
  final _reviewNameController = TextEditingController();
  final _reviewMessageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode myFocusNode = new FocusNode();
  final String id;

  RestaurantReviewDialog({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReviewCubit>(
      create: (context) => ReviewCubit(),
      child: BlocConsumer<ReviewCubit, ReviewState>(
        listener: (context, state) {
          if (state is ReviewUploadError) {
            Get.showSnackbar(GetBar(
              message: state.errorMessage,
              margin: EdgeInsets.all(10),
              duration: Duration(seconds: 4),
              borderRadius: 15,
            ));
          } else if (state is ReviewUploadSuccess) {
            _reviewNameController.clear();
            _reviewMessageController.clear();
            Navigation.back();
            Get.showSnackbar(
              GetBar(
                key: Key('send_review_snackbar'),
                message: 'Review berhasil dikirim',
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                borderRadius: 15,
              ),
            );
          }
        },
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            child: Container(
              height: 350,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Beri kami penilaian',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      key: Key('review_name_input'),
                      focusNode: myFocusNode,
                      cursorColor: Colors.amber,
                      controller: _reviewNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Nama',
                        hintText: 'Tulis nama kamu...',
                        focusColor: Colors.amber,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Kolom nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      key: Key('review_message_input'),
                      controller: _reviewMessageController,
                      cursorColor: Colors.amber,
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Review',
                        hintText: 'Tulis review kamu...',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Kolom review tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    if (state is ReviewLoading)
                      LoadingButton()
                    else
                      ElevatedButton(
                        key: Key('send_review_button'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final reviewRequest = ReviewRequest(
                              id: id,
                              name: _reviewNameController.text,
                              review: _reviewMessageController.text,
                            );
                            context
                                .read<ReviewCubit>()
                                .addNewReview(reviewRequest);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.amber,
                        ),
                        child: Container(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Kirim Review',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
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
