import 'package:flutter/material.dart';

class LocationSearchField extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final String hintText;

  const LocationSearchField({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller,
    this.onTap,
    this.hintText = 'Select location',
  }) : super(key: key);

  @override
  State<LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<LocationSearchField> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ?? () => _showLocationPicker(context),
      child: Row(
        children: [
          Icon(widget.icon, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.controller.text.isEmpty
                      ? widget.hintText.toUpperCase()
                      : widget.controller.text.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.controller.text.isEmpty
                        ? Colors.grey.shade400
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
        ],
      ),
    );
  }

  void _showLocationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationPickerBottomSheet(
        controller: widget.controller,
        label: widget.label,
      ),
    );
  }
}

class LocationPickerBottomSheet extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const LocationPickerBottomSheet({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  @override
  State<LocationPickerBottomSheet> createState() =>
      _LocationPickerBottomSheetState();
}

class _LocationPickerBottomSheetState extends State<LocationPickerBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _locations = [
    'Colombo',
    'Kandy',
    'Galle',
    'Negombo',
    'Jaffna',
    'Trincomalee',
    'Batticaloa',
    'Matara',
    'Anuradhapura',
    'Kurunegala',
  ];
  List<String> _filteredLocations = [];

  @override
  void initState() {
    super.initState();
    _filteredLocations = _locations;
    _searchController.addListener(_filterLocations);
  }

  void _filterLocations() {
    setState(() {
      _filteredLocations = _locations
          .where((location) => location
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select ${widget.label}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search location...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF4A90E2)),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Location List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredLocations.length,
              itemBuilder: (context, index) {
                final location = _filteredLocations[index];
                return ListTile(
                  leading: const Icon(Icons.location_on, color: Color(0xFF4A90E2)),
                  title: Text(
                    location,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    widget.controller.text = location;
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}