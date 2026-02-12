export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_database/firebase_database.dart';
export 'package:firebase_storage/firebase_storage.dart' hide Task;
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:fpdart/fpdart.dart' hide State;
export 'package:grpc/grpc.dart';
// Export Core Libraries
export 'package:hooks_riverpod/hooks_riverpod.dart';
export 'package:riverpod_annotation/riverpod_annotation.dart' show riverpod;
// Signals - New state management (coexisting during migration)
// signals_flutter re-exports signals, so we only need to export signals_flutter
// Hide types that conflict with Riverpod
export 'package:signals_flutter/signals_flutter.dart' hide AsyncData, AsyncError, AsyncLoading;

// Export Application Layer
export 'app/app.dart';
// Export Infrastructure Layer
export 'data/data.dart';
// Export Domain Layer
export 'domain/domain.dart';
// Export Presentation Layer
export 'view/view.dart';
