

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

   @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
 // final itemRepository = ItemRepository();
 // List<Item> _availableProducts = [];
 // final List<PItem> _selectedProducts = [];

  @override
  void initState() {
    super.initState();

    itemRepository.findAll().then((products) => {
          setState(() => {_availableItems = items})
        });
  }

  IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _showEditTaskDialog(index);
                },
              )

IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _removeTask(index);
                    },
                  )


}