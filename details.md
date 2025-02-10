lib/
├── core/
│   └── supabase/
│       ├── supabase_service.dart   # Singleton for Supabase client
│       └── auth_service.dart       # Handles authentication logic
├── app/
│   └── app.dart                   # Main app configuration with routing
├── auth/
│   ├── bloc/
│   │   ├── auth_bloc.dart          # Bloc for authentication
│   │   ├── auth_event.dart         # Events for AuthBloc
│   │   └── auth_state.dart         # States for AuthBloc
│   └── presentation/
│       └── auth_page.dart          # Login and Signup UI
├── modules/
│   └── item/
│       ├── bloc/
│       │   ├── item_bloc.dart      # Bloc for managing items
│       │   ├── item_event.dart     # Events for ItemBloc
│       │   └── item_state.dart     # States for ItemBloc
│       ├── data/
│       │   ├── item_model.dart     # Item data model
│       │   └── item_repository.dart# Repository for fetching items
│       └── presentation/
│           └── item_list_page.dart # UI for item list
└── main.dart                      # Entry point


