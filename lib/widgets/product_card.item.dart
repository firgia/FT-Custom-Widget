part of 'product_card.dart';

class _Item extends StatelessWidget {
  const _Item({
    required this.data,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final ProductCardData data;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(height: 16),
            _buildName(),
            const SizedBox(height: 4),
            _buildLocation(context),
            const SizedBox(height: 16),
            _buildPrice(context),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Image(
        image: data.image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        data.name,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLocation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 15,
            color: Theme.of(context).textTheme.caption?.color,
          ),
          Expanded(
            child: Text(
              data.location,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        "\$ ${data.price}",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class _ItemLoading extends StatelessWidget {
  const _ItemLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(height: 16),
          _buildName(),
          const SizedBox(height: 4),
          _buildLocation(context),
          const SizedBox(height: 16),
          _buildPrice(context),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(color: Colors.grey[200]),
    );
  }

  Widget _buildName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 16,
      width: double.infinity,
      color: Colors.grey[200],
    );
  }

  Widget _buildLocation(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 13,
      width: 50,
      color: Colors.grey[200],
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 20,
      width: 50,
      color: Colors.grey[200],
    );
  }
}
