# PrimeTag Task

This is a Flutter application built as a technical task for PrimeTag. It includes:

-  Login flow using [ReqRes API](https://reqres.in)
-  Product listing using [FakeStore API](https://fakestoreapi.com)
-  Cart management with offline support using Hive
-  Clean Architecture + Bloc + Freezed

---

##  App Setup Instructions

1. **Clone the repo**
   ```bash
   git clone https://github.com/fahdmekawy/primetag_task.git
   cd primetag_task
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (Freezed & Hive)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

##  Dependencies Used

| Package                    | Purpose                                |
|----------------------------|----------------------------------------|
| `flutter_bloc`             | State management using Bloc pattern    |
| `freezed` + `build_runner` | Union types and data modeling          |
| `dio`                      | Networking layer with interceptor/logs |
| `hive` + `hive_flutter`    | Local persistent storage (cart data)   |
| `get_it`                   | Dependency injection container         |
| `pretty_dio_logger`        | Logging Dio requests/responses         |
| `dartz`                    | Functional programming (Either, etc.)  |

---

##  Project Structure

```
lib/
├── core/
│   ├── di/                # Dependency injection
│   ├── networking/        # Dio factory
│   └── error/             # Failure definitions
├── features/
│   ├── auth/              # Login feature
│   ├── products/          # Product listing
│   └── cart/              # Cart feature with Hive support
```

Each feature follows clean architecture principles:

- `domain/` → entities, repositories, use cases
- `data/` → data sources, models, repository implementation
- `presentation/` → UI (screens/widgets) and Blocs

---

## 📡 Offline Mode

If product API fails (e.g., no internet), the app displays the cart from local Hive storage instead.

---


