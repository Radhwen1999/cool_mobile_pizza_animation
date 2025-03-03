import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'app_theme.dart';
import 'half_circle.dart';

enum PizzaSize { large, medium, small }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PizzaSize _selectedSize = PizzaSize.large;

  double _pizzaScale = 1.0;
  Curve _pizzaCurve = Curves.easeIn;
  bool _isLiked = false;

  static const double _largeFactor = 1.0;
  static const double _mediumFactor = 0.9;
  static const double _smallFactor = 0.7;

  int _quantity = 1;

  final double _largePizzaPrice = 28.99;
  final double _mediumPizzaPrice = 24.99;
  final double _smallPizzaPrice = 20.99;

  double _currentPizzaPrice = 0.0;

  bool _isSelected(PizzaSize size) => _selectedSize == size;

  @override
  void initState() {
    super.initState();
    _currentPizzaPrice = _largePizzaPrice;
  }

  void _onSelectSize(PizzaSize size) {
    setState(() {
      _selectedSize = size;
      switch (_selectedSize) {
        case PizzaSize.large:
          _pizzaScale = _largeFactor;
          _currentPizzaPrice = _largePizzaPrice;
          break;
        case PizzaSize.medium:
          _pizzaScale = _mediumFactor;
          _currentPizzaPrice = _mediumPizzaPrice;
          break;
        case PizzaSize.small:
          _pizzaScale = _smallFactor;
          _currentPizzaPrice = _smallPizzaPrice;
          break;
      }

      _pizzaCurve = Curves.easeIn;
    });
  }

  void _onIncrementQuantity() {
    setState(() {
      if (_quantity < 20) {
        _quantity++;
      }
    });
  }

  void _onDecrementQuantity() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: primaryOrangeColor,
        ),
        actions: [
          IconButton(
            icon:  Icon(_isLiked ? CupertinoIcons.heart_solid : CupertinoIcons.heart,color: primaryOrangeColor,),
            color: primaryOrangeColor,
            style: IconButton.styleFrom(backgroundColor: primaryDarkColor),
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked; // Toggle the liked state
              });
            },
          ),
        ],
        title: const Text('Supreme Pizza'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                HalfCircle(pizzaScale: _pizzaScale, pizzaCurve: _pizzaCurve),

                _buildSizeSelectionButton(
                  size: PizzaSize.large,
                  label: "L",
                  topOffset: 0.3,
                  leftOffset: 0.05,
                ),
                _buildSizeSelectionButton(
                  size: PizzaSize.medium,
                  label: "M",
                  topOffset: 0.4,
                  leftOffset: 0.025,
                ),
                _buildSizeSelectionButton(
                  size: PizzaSize.small,
                  label: "S",
                  topOffset: 0.5,
                  leftOffset: 0.05,
                ),

                Positioned(
                  bottom: 100,
                  left: 40,
                  child: _buildQuantitySelector(),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrangeColor,
                      minimumSize: const Size(240, 50),
                    ),
                    child: Text(
                      "\$${(_quantity * _currentPizzaPrice).toStringAsFixed(2)} Add to cart",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: scaffoldBackground,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: const [
                      Gap(10),
                      Text(
                        "Baked to perfection on a crispy golden crust, "
                        "this pizza delivers the perfect balance of bold "
                        "flavors and cheesy goodness.",
                        style: paragraphTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(40),
        ],
      ),
    );
  }

  Widget _buildSizeSelectionButton({
    required PizzaSize size,
    required String label,
    required double topOffset,
    required double leftOffset,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Positioned(
      top: screenHeight * topOffset,
      left: screenHeight * leftOffset,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _isSelected(size) ? primaryOrangeColor : primaryDarkColor,
        ),
        onPressed: () => _onSelectSize(size),
        child: Text(
          label,
          style:
              _isSelected(size)
                  ? const TextStyle(
                    color: scaffoldBackground,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  )
                  : activatedPizzaButton,
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: primaryOrangeColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0.0, 5.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _onDecrementQuantity,
            icon: const Icon(Icons.remove),
            iconSize: 18,
            style: IconButton.styleFrom(
              backgroundColor: scaffoldBackground,
              minimumSize: const Size(30, 30),
              padding: EdgeInsets.zero,
            ),
          ),

          Text(
            '$_quantity',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: scaffoldBackground,
            ),
          ),

          IconButton(
            onPressed: _onIncrementQuantity,
            icon: const Icon(Icons.add),
            iconSize: 18,
            style: IconButton.styleFrom(
              backgroundColor: scaffoldBackground,
              minimumSize: const Size(30, 30),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
