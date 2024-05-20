import 'package:QuickDo/core/utils/tools.dart';
import 'package:QuickDo/core/widgets/animations/fade_animation.dart';
import 'package:QuickDo/core/widgets/empty_data/empty_data_widget.dart';
import 'package:QuickDo/core/widgets/error_widgets/general_error_widget.dart';
import 'package:QuickDo/core/widgets/loading_widget/loading_footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../cubits/pagination_cubit.dart';

typedef CreatedCallback = void Function(PaginationCubit cubit);

typedef ListBuilder<Model> = Widget Function(List<Model> list);

class PaginationList<Model> extends StatefulWidget {
  final RepositoryCallBack? repositoryCallBack;
  final ListBuilder<Model>? listBuilder;
  final CreatedCallback? onCubitCreated;
  final bool? withPagination;
  final bool withEmptyWidget;
  final Map<String, dynamic>? initialParam;
  final VoidCallback? onRefresh;
  final Axis scrollDirection;
  final Widget? errorWidget;
  final Widget? noDataWidget;
  final Widget? loadingWidget;
  final PageController? scrollController;
  final Color? textColorNoDataText;
  final double? paddingTextErrorWidget;
  final ScrollPhysics? physics;
  bool isHorizontal;
  Widget ? titleWidget;

  PaginationList(
      {Key? key,
      this.noDataWidget,
      this.physics,
      this.paddingTextErrorWidget,
      this.scrollController,
      this.textColorNoDataText,
      this.errorWidget,
      this.loadingWidget,
      this.scrollDirection = Axis.vertical,
      this.repositoryCallBack,
      this.listBuilder,
      this.withPagination = false,
      this.onCubitCreated,
      this.titleWidget ,
      this.initialParam,
      this.isHorizontal = false,
      this.withEmptyWidget = true,
      this.onRefresh})
      : super(key: key);

  @override
  _PaginationListState<Model> createState() => _PaginationListState<Model>();
}

class _PaginationListState<Model> extends State<PaginationList<Model>> {
  final RefreshController _refreshController = RefreshController();
  PaginationCubit<Model>? cubit;

  @override
  void initState() {
    cubit = PaginationCubit<Model>(widget.repositoryCallBack!);
    if (widget.onCubitCreated != null) {
      widget.onCubitCreated!(cubit!);
    }
    cubit?.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildConsumer();
  }

  _buildConsumer() {
    return BlocConsumer<PaginationCubit<Model>, PaginationState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is Error) {
            Tool.showToast(state.message, context);
          } else if (state is GetListSuccessfully) {
            if (widget.onRefresh != null) widget.onRefresh!();

            _refreshController.refreshCompleted();

            if (state.noMoreData) {
              _refreshController.loadNoData();
            } else {
              _refreshController.loadComplete();
            }
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return widget.loadingWidget ??
                const Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CupertinoActivityIndicator(radius: 15),
                ));
          } else if (state is GetListSuccessfully) {
            return smartRefresher(state.list as List<Model>);
          } else if (state is Error) {
            return widget.errorWidget ??
                GeneralErrorWidget(
                  paddingText: widget.paddingTextErrorWidget!,
                  message: state.message,
                  onTap: () {
                    cubit?.getList();
                  },
                );
          } else {
            return Container();
          }
        });
  }

  smartRefresher(List<Model> list) {
    Widget child;
    if (list.isEmpty && widget.withEmptyWidget) {
      child = widget.noDataWidget ?? const EmptyDataWidget();
    } else {
      child = widget.listBuilder!(list);
    }

    return FadeAnimation(
      delay: 0.2,
      child: widget.isHorizontal
          ? Container(
              width: MediaQuery.of(context).size.width,
              height:
                  list.isEmpty ? 0 : MediaQuery.of(context).size.height * 0.25,
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  list.isNotEmpty && widget.titleWidget!=null ? widget.titleWidget! : const Offstage(),
                  Expanded(
                    child: SmartRefresher(
                      physics: widget.physics,
                      scrollController: widget.scrollController,
                      scrollDirection: widget.scrollDirection,
                      enablePullDown: widget.scrollDirection == Axis.vertical,
                      enablePullUp: widget.withPagination != null
                          ? widget.withPagination!
                          : widget.scrollDirection == Axis.vertical,
                      header: const MaterialClassicHeader(),
                      controller: _refreshController,
                      onRefresh: () async {
                        cubit?.getList();
                      },
                      onLoading: () async {
                        cubit?.getList(loadMore: true);
                      },
                      footer: customFooter,
                      child: child,
                    ),
                  ),
                ],
              ),
            )
          : SmartRefresher(
        dragStartBehavior: DragStartBehavior.start,
              physics: widget.physics,
              scrollController: widget.scrollController,
              scrollDirection: widget.scrollDirection,
              enablePullDown: widget.scrollDirection == Axis.vertical,
              enablePullUp: widget.withPagination != null
                  ? widget.withPagination!
                  : widget.scrollDirection == Axis.vertical,
              header:  widget.titleWidget!=null?SliverToBoxAdapter(child: widget.titleWidget,):const MaterialClassicHeader(),
              controller: _refreshController,
              onRefresh: () async {
                cubit?.getList();
              },
              onLoading: () async {
                cubit?.getList(loadMore: true);
              },
              footer: customFooter,
              child: child,
            ),
    );
  }
}
