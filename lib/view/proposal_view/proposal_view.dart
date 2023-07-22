import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/get_order_list_model.dart';
import '../../model/get_proposals_by_state.dart';
import '../../view_model/proposal_view_model.dart';
import '../widget/appbar.dart';
import '../widget/loading_widget.dart';
import '../widget/main_page_content.dart';
import '../widget/nav_drawer.dart';
import '../widget/nav_rail.dart';
import '../widget/small_card/small_card.dart';

class proposalView extends ConsumerWidget {
  const proposalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proposalListAsyncValue = ref.watch(proposalListview);
    print('sayfa calisti ${proposalListAsyncValue.toString()}');
    return proposalListAsyncValue.when(
      data: (proposalList) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 1100) {
              return Scaffold(
                appBar: AppbarTop(), //appbar
                body: Row(
                  children: [
                    const NavigationRailWidget(),
                    Expanded(
                        child: buildBody(
                            proposalList,
                            context,
                            FlutterI18n.translate(
                                context, "tr.proposal.proposals"),
                            'proposal')),
                  ],
                ),
              );
            } else {
              return Scaffold(
                appBar: AppbarTop(), // appbar
                body: SafeArea(
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: NavigationRailDrawer(), //drawer
                      ),
                      Expanded(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: buildBody(
                              proposalList,
                              context,
                              FlutterI18n.translate(
                                  context, "tr.proposal.proposals"),
                              'proposal'),
                        ), //order screen body
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
      loading: () => const LoadingWidget(),
      error: (error, stack) {
        print('Hata: $error');
        print('Stack trace: $stack');
        WidgetsBinding.instance.addPostFrameCallback((_) {
        });
        return Text('An error occurred: $error');
      },
    );
  }

  Padding buildBody(List<GetProposalModel> proposalList, BuildContext context,
      String topic, String className) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: constraints.maxHeight > 300,
                child: allMainPageContent(
                  topic: topic,
                ),
              ),
              Flexible(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: getCrossAxisCount(constraints),
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  itemCount: proposalList.length,
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    return SmallCard(
                      index: index,
                      className: className,
                      id: proposalList[index].proposalId.toString(),
                      status: proposalList[index].proposalState.toString(),
                      bodyHeader:
                          proposalList[index].supplierCompany.toString(),
                      headerDate:
                          proposalList[index].proposalValidDate.toString(),
                      paymentType: proposalList[index].paymentType.toString(),
                      demandNo: proposalList[index].proposalId.toString(),
                      deliveryDate: proposalList[index].deliveryDate.toString(),
                      paymentDueDate:
                          proposalList[index].paymentDueDate.toString(),
                      bodyList: proposalList[index].productProposals!,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  int getCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth > 900) {
      return 3;
    } else if (constraints.maxWidth > 550) {
      return 2;
    } else {
      return 1;
    }
  }
}
