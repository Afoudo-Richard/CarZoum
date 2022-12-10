part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.authenticated = false,
    this.isSignedInAnonymous = false,
    this.checker = false,
    this.hasWalkedThrough = false,
  });

  final bool authenticated;
  final bool isSignedInAnonymous;
  final bool checker;
  final bool hasWalkedThrough;

  AuthenticationState copyWith({
    bool? authenticated,
    bool? isSignedInAnonymous,
    bool? checker,
    bool? hasWalkedThrough,
  }) {
    return AuthenticationState(
      authenticated: authenticated ?? this.authenticated,
      isSignedInAnonymous: isSignedInAnonymous ?? this.isSignedInAnonymous,
      checker: checker ?? this.checker,
      hasWalkedThrough: hasWalkedThrough ?? this.hasWalkedThrough,
    );
  }

  @override
  List<Object?> get props => [
        authenticated,
        isSignedInAnonymous,
        checker,
        hasWalkedThrough,
      ];

  Future<User?> getUser() async {
    return await ParseUser.currentUser();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authenticated': authenticated,
      'isSignedInAnonymous': isSignedInAnonymous,
      'checker': checker,
      'hasWalkedThrough': hasWalkedThrough,
    };
  }

  factory AuthenticationState.fromMap(Map<String, dynamic> map) {
    return AuthenticationState(
      authenticated: map['authenticated'] as bool,
      isSignedInAnonymous: map['isSignedInAnonymous'] as bool,
      checker: map['checker'] as bool,
      hasWalkedThrough: map['hasWalkedThrough'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationState.fromJson(String source) =>
      AuthenticationState.fromMap(json.decode(source) as Map<String, dynamic>);
}
