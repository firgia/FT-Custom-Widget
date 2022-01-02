part of 'product_card.dart';

class _Builder extends StatelessWidget {
  const _Builder({
    this.label,
    required this.data,
    required this.onPressed,
    this.shrinkWrap = false,
    this.physics,
    Key? key,
  }) : super(key: key);

  final String? label;
  final List<ProductCardData> data;
  final Function(int index, ProductCardData data) onPressed;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) _buildLabel(context),
        MasonryGridView.count(
          physics: physics,
          shrinkWrap: shrinkWrap,
          itemCount: data.length,
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return _Item(
              data: data[index],
              onPressed: () => onPressed(index, data[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return (label != null)
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.headline6,
            ),
          )
        : const SizedBox();
  }
}

class _LoadingBuilder extends StatelessWidget {
  const _LoadingBuilder({
    required this.total,
    this.label,
    this.shrinkWrap = false,
    this.physics,
    Key? key,
  }) : super(key: key);
  final String? label;
  final int total;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) _buildLabel(context),
        MasonryGridView.count(
          physics: physics,
          shrinkWrap: shrinkWrap,
          itemCount: total,
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return const _ItemLoading();
          },
        ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return (label != null)
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.headline6,
            ),
          )
        : const SizedBox();
  }
}
