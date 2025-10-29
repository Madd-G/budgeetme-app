import 'package:budgeetme/core/theme/theme.dart';
import 'package:budgeetme/core/extensions/number_extensions.dart';
import 'package:budgeetme/core/utils/currency_input_formatter.dart';
import 'package:budgeetme/features/transaction/domain/constants/transaction_constants.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction_type.dart';
import 'package:budgeetme/features/dashboard/presentation/providers/transaction_list/transaction_list_provider.dart';
import 'package:budgeetme/features/transaction/presentation/providers/transaction_manage/transaction_manage_provider.dart';
import 'package:budgeetme/features/transaction/presentation/widgets/amount_card.dart';
import 'package:budgeetme/features/transaction/presentation/widgets/category_selector.dart';
import 'package:budgeetme/features/transaction/presentation/widgets/date_picker_field.dart';
import 'package:budgeetme/features/transaction/presentation/widgets/delete_button.dart';
import 'package:budgeetme/features/transaction/presentation/widgets/description_field.dart';
import 'package:budgeetme/features/transaction/presentation/widgets/submit_button.dart';
import 'package:budgeetme/features/transaction/presentation/widgets/type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionFormScreen extends ConsumerStatefulWidget {
  const TransactionFormScreen({super.key, this.transaction});

  final Transaction? transaction;

  @override
  ConsumerState<TransactionFormScreen> createState() =>
      _TransactionFormScreenState();
}

class _TransactionFormScreenState extends ConsumerState<TransactionFormScreen>
    with SingleTickerProviderStateMixin {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late TransactionType _selectedType;
  late String _selectedCategory;
  late final AnimationController _fadeController;
  final FocusNode _amountFocusNode = FocusNode();

  List<String> get _categories => _selectedType == TransactionType.income
      ? TransactionConstants.incomeCategories
      : TransactionConstants.expenseCategories;

  bool get _isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    final transaction = widget.transaction;
    _formKey = GlobalKey<FormState>();
    _selectedDate = transaction?.date ?? DateTime.now();
    _selectedType = transaction?.type ?? TransactionType.income;

    final transactionCategory = transaction?.category;
    if (transactionCategory != null &&
        _categories.contains(transactionCategory)) {
      _selectedCategory = transactionCategory;
    } else {
      _selectedCategory = _categories.first;
    }

    final initialAmount = transaction != null
        ? transaction.amount.toCompactCurrency()
        : '';
    _amountController = TextEditingController(text: initialAmount);
    _descriptionController = TextEditingController(
      text: transaction?.description ?? '',
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _amountFocusNode.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      transactionManageProvider,
      _onManageStateChanged,
    );

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final manageState = ref.watch(transactionManageProvider);
    final isIncome = _selectedType == TransactionType.income;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: Text(_isEditing ? 'Edit Transaksi' : 'Tambah Transaksi'),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                context.pop();
              }
            },
          ),
        ),
        body: FadeTransition(
          opacity: _fadeController,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AmountCard(
                    controller: _amountController,
                    focusNode: _amountFocusNode,
                    isIncome: isIncome,
                    isEditing: _isEditing,
                    onChanged: () => setState(() {}),
                  ),
                  const SizedBox(height: 24),

                  TypeSelector(
                    selectedType: _selectedType,
                    isEnabled: !_isEditing,
                    onTypeChanged: (type) {
                      setState(() {
                        _selectedType = type;
                        _selectedCategory = _categories.first;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  CategorySelector(
                    categories: _categories,
                    selectedCategory: _selectedCategory,
                    isEnabled: !_isEditing,
                    onCategoryChanged: (category) {
                      setState(() => _selectedCategory = category);
                    },
                  ),
                  const SizedBox(height: 20),

                  DatePickerField(
                    selectedDate: _selectedDate,
                    isEnabled: !_isEditing,
                    onDateSelected: (date) {
                      setState(() => _selectedDate = date);
                    },
                  ),
                  const SizedBox(height: 20),

                  DescriptionField(controller: _descriptionController),
                  const SizedBox(height: 32),

                  SubmitButton(
                    isLoading: manageState.isLoading,
                    isIncome: isIncome,
                    isEditing: _isEditing,
                    onPressed: _handleSubmit,
                  ),

                  if (_isEditing) ...[
                    const SizedBox(height: 12),
                    DeleteButton(onPressed: _handleDelete),
                  ],
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _handleSubmit() async {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah transaksi tidak boleh kosong')),
      );
      _amountFocusNode.requestFocus();
      return;
    }

    final amount = CurrencyInputFormatter.parse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan jumlah yang valid')),
      );
      _amountFocusNode.requestFocus();
      return;
    }

    final description = _descriptionController.text.trim().isEmpty
        ? null
        : _descriptionController.text.trim();

    final transaction = widget.transaction;

    final updated = Transaction(
      id: transaction?.id ?? 0,
      amount: amount,
      type: _selectedType,
      category: _selectedCategory,
      description: description,
      date: _selectedDate,
    );

    final notifier = ref.read(transactionManageProvider.notifier);

    if (_isEditing) {
      await notifier.update(updated);
    } else {
      await notifier.create(updated);
    }
  }

  Future<void> _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Transaksi'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus transaksi ini? Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.expense,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final transaction = widget.transaction;
      if (transaction != null) {
        final notifier = ref.read(transactionManageProvider.notifier);
        await notifier.delete(transaction.id);
      }
    }
  }

  void _onManageStateChanged(
    AsyncValue<void>? previous,
    AsyncValue<void> next,
  ) {
    next.whenOrNull(
      data: (data) async {
        // Refresh the transaction list to show new/updated/deleted transaction
        await ref.read(transactionListProvider.notifier).refresh();

        if (!mounted) return;

        final colorScheme = Theme.of(context).colorScheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: colorScheme.onPrimary),
                const SizedBox(width: 12),
                Text(
                  _isEditing
                      ? 'Transaksi berhasil diperbarui'
                      : 'Transaksi berhasil ditambahkan',
                ),
              ],
            ),
            backgroundColor: AppColors.income,
          ),
        );
        if (Navigator.of(context).canPop()) {
          context.pop();
        }
      },
      error: (error, _) {
        final colorScheme = Theme.of(context).colorScheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_rounded, color: colorScheme.onError),
                const SizedBox(width: 12),
                Expanded(child: Text('Gagal menyimpan transaksi: $error')),
              ],
            ),
            backgroundColor: AppColors.expense,
          ),
        );
      },
    );
  }
}
