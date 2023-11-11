import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_pool_infos_response.freezed.dart';
part 'get_pool_infos_response.g.dart';

@freezed
class GetPoolInfosResponse with _$GetPoolInfosResponse {
  const factory GetPoolInfosResponse({
    required Token token1,
    required Token token2,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'lp_token') required LPToken lpToken,
    required double fee,
  }) = _GetPoolInfosResponse;

  factory GetPoolInfosResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPoolInfosResponseFromJson(json);
}

@freezed
class Token with _$Token {
  const factory Token({
    required String address,
    required double reserve,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

@freezed
class LPToken with _$LPToken {
  const factory LPToken({
    required String address,
    required double supply,
  }) = _LPToken;

  factory LPToken.fromJson(Map<String, dynamic> json) =>
      _$LPTokenFromJson(json);
}
