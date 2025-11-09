# BudgeetMe

Aplikasi expense tracker untuk mencatat pemasukan dan pengeluaran keuangan pribadi. Dibangun dengan Flutter dan menggunakan Clean Architecture.

## Demo





https://github.com/user-attachments/assets/0f981bb4-2308-45be-b57f-c3a38860ab69




## Fitur Utama

- **Dashboard** - Lihat ringkasan saldo, pemasukan, dan pengeluaran
- **Manajemen Transaksi** - Tambah, edit, dan hapus transaksi
- **Kategori** - Filter transaksi berdasarkan kategori
- **Riwayat** - Lihat daftar transaksi yang dikelompokkan per tanggal
- **Dark Mode** - Tema terang dan gelap
- **Real-time Sync** - Data tersinkronisasi langsung dengan backend

## Tech Stack

- **Flutter** - Framework UI
- **Riverpod** - State management
- **Go Router** - Navigation
- **Dio** - HTTP client untuk API calls
- **Clean Architecture** - Pemisahan layer domain, data, dan presentation

## Struktur Folder

```
lib/
├── core/                          
│   ├── constants/                 # Konstanta (API endpoints, dll)
│   ├── exceptions/                # Custom exception handling
│   ├── extensions/                # Extension methods (DateTime, Number)
│   ├── network/                   # Setup Dio dan interceptors
│   ├── routing/                   # Routing
│   ├── theme/                     # Tema app (colors, fonts, theme)
│   ├── utils/                     # Helper utilities
│   └── widgets/                   # Shared widgets
│
└── features/                      
    ├── dashboard/                 # Fitur halaman utama
    │   ├── data/                  # Data layer
    │   │   ├── datasources/       # API datasource
    │   │   ├── models/            # Data models
    │   │   └── repositories/      # Repository implementation
    │   ├── domain/                # Business logic layer
    │   │   ├── entities/          # Domain entities
    │   │   ├── repositories/      # Repository interface
    │   │   └── usecases/          # Use cases
    │   └── presentation/          # UI layer
    │       ├── providers/         # Riverpod providers
    │       ├── screens/           # Screen widgets
    │       └── widgets/           # Feature-specific widgets
    │
    └── transaction/               # Fitur CRUD transaksi
        ├── data/
        ├── domain/
        └── presentation/
```

## API Integration

Aplikasi ini menggunakan public REST API untuk operasi CRUD transaksi.

Contoh: https://invenx-backend-app.up.railway.app/transactions


**Endpoints yang digunakan:**
- `GET /transactions/summary` - Ambil ringkasan saldo
- `GET /transactions/paginated` - Ambil daftar transaksi
- `GET /transactions/:id` - Detail transaksi
- `POST/transactions` - Tambah transaksi baru
- `PUT /transactions/:id` - Update transaksi
- `DELETE /transactions/:id` - Hapus transaksi
- `GET /transactions/category/:id` - Filter by kategori
- `GET /transactions/category/:id/summary` - Summary per kategori

**Backend Repository:**  
Link Backend: [InvenX-Backend](https://github.com/Madd-G/InvenX-Backend)

##  Penjelasan Kode Penting

### Provider Pattern (GET)
Menggunakan Riverpod untuk fetch data:

```dart
// Provider untuk fetch data
@riverpod
Future<DashboardSummary> dashboardTransactionSummary(Ref ref) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.fetchSummary();
}

// Di widget
final summary = ref.watch(dashboardTransactionSummaryProvider);
summary.when(
  data: (data) => Text(data.balance.toFormattedCurrency()),
  loading: () => CircularProgressIndicator(),
  error: (err, _) => ErrorView(),
);
```

### Provider Pattern (POST)
Menggunakan Riverpod untuk create/update data:

```dart
// Provider untuk manage data (create, update, delete)
@Riverpod(keepAlive: true)
class TransactionManage extends _$TransactionManage {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> create(Transaction transaction) async {
    state = const AsyncLoading();
    try {
      final useCase = ref.read(manageTransactionUseCaseProvider);
      await useCase.create(transaction);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

// Di widget - panggil method create
final notifier = ref.read(transactionManageProvider.notifier);
await notifier.create(newTransaction);

// Listen perubahan state
ref.listen(transactionManageProvider, (previous, next) {
  next.whenOrNull(
    data: (_) => showSnackBar('Transaksi berhasil ditambahkan'),
    error: (err, _) => showSnackBar('Gagal: $err'),
  );
});
```

### Repository Pattern (GET)
Abstraksi data source untuk fetch:

```dart
// Interface (domain/repositories)
abstract class DashboardRepository {
  Future<DashboardTransactionSummary> fetchSummary();
  Future<List<Transaction>> fetchTransactions();
}

// Implementation (data/repositories)
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _dataSource;
  
  @override
  Future<DashboardTransactionSummary> fetchSummary() async {
    final dto = await _dataSource.fetchSummary();
    return DashboardTransactionSummary(
      totalIncome: dto.income,
      totalExpense: dto.expenses,
      balance: dto.balance,
    );
  }
}
```

### Repository Pattern (POST)
Abstraksi data source untuk create/update:

```dart
// Interface (domain/repositories)
abstract class TransactionRepository {
  Future<Transaction> createTransaction(Transaction transaction);
  Future<Transaction> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(int id);
}

// Implementation (data/repositories)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource _transactionDataSource;
  final DashboardRemoteDataSource _dashboardDataSource;
  
  @override
  Future<Transaction> createTransaction(Transaction transaction) async {
    // Convert entity to request model
    final request = TransactionRequestModel.fromTransaction(transaction);
    
    // Send POST request
    final id = await _transactionDataSource.createTransaction(request);
    
    // Fetch detail dari server untuk data terbaru
    final detail = await _dashboardDataSource.fetchTransactionDetail(id);
    
    // Return entity
    return detail.toEntity();
  }
}
```

### Extensions
Helper methods untuk formatting:

```dart
// Number extensions
'${amount.toFormattedCurrency()}' // Rp 50.000

// DateTime extensions
transaction.date.toIndonesianLongFormat() // 15 Januari 2024
```

## Dependencies

| Package | Fungsi |
|---------|--------|
| `flutter_riverpod` | State management |
| `riverpod_annotation` | Code generation untuk providers |
| `go_router` | Routing & navigation |
| `dio` | HTTP client untuk API calls |
| `intl` | Formatting currency & dates |
| `shimmer` | Loading shimmer effect |
