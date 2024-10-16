import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/controller/houseman/houseman_cubit.dart';
import 'package:providerapp/controller/houseman/houseman_state.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/widget/houseman_details.dart';

class AllHouseman extends StatelessWidget {
  const AllHouseman({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorHelper.background,
      appBar: AppBar(
        title: Text(S.of(context).Houseman,
            style: TextStyleHelper.textStylefontSize19
                .copyWith(color: Colors.white)),
        backgroundColor: ColorHelper.purple,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
              height: 700,
              child: BlocBuilder<HousemanCubit, HousemanStatus>(
                builder: (context, state) {
                  if (state is HousemanLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is Housemanloaded) {
                    final houseman = (state).housemanList;
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5 / 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: houseman.length,
                        itemBuilder: (context, index) {
                          return HousemanDetails(
                            imagePath: houseman[index].imagePath,
                            textHouseMan: houseman[index].name,
                          );
                        });
                  } else if (state is HousemanFailure) {
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return Container();
                  }
                },
              )),
        ),
      ),
    );
  }
}
