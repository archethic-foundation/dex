import 'localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get btn_understand => 'I understand';

  @override
  String get btn_save => 'Save';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ok => 'Ok';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get connectionWalletDisconnect => 'Disconnect wallet';

  @override
  String get go => 'Go !';

  @override
  String get btn_connect_wallet => 'Connect wallet';

  @override
  String get confirmationPopupTitle => 'Confirmation Request';

  @override
  String get connectionWalletDisconnectWarning => 'Are you sure you want to disconnect your wallet and exit the application?';

  @override
  String get changeCurrentAccountWarning => 'Warning, your current account has been updated.';

  @override
  String get welcomeNoWallet => 'Unlock the full potential of our Web3 application - get the Archethic Wallet now!';

  @override
  String get menu_swap => 'Swap';

  @override
  String get menu_liquidity => 'Pools';

  @override
  String get menu_earn => 'Earn';

  @override
  String get menu_bridge => 'Bridge';

  @override
  String get menu_get_wallet => 'Get Wallet';

  @override
  String get menu_documentation => 'Documentation';

  @override
  String get menu_sourceCode => 'Source code';

  @override
  String get menu_faq => 'FAQ';

  @override
  String get menu_tuto => 'Tutorials';

  @override
  String get menu_privacy_policy => 'Privacy policy';

  @override
  String get menu_terms_of_use => 'Terms of use';

  @override
  String get menu_report_bug => 'Report a bug';

  @override
  String get btn_selectToken => 'Select a token';

  @override
  String get btn_swap => 'Swap';

  @override
  String get btn_close => 'Close';

  @override
  String get btn_confirm_swap => 'Confirm swap';

  @override
  String get token_selection_search_bar_hint => 'Search symbol or from token address';

  @override
  String get token_selection_common_bases_title => 'Common bases';

  @override
  String get token_selection_your_tokens_title => 'Your tokens';

  @override
  String get token_selection_get_tokens_from_wallet => 'Retrieving tokens from your current account in your wallet...';

  @override
  String get slippage_tolerance => 'Slippage tolerance';

  @override
  String get archethicDashboardMenuBridgeItem => 'Bridge';

  @override
  String get archethicDashboardMenuBridgeDesc => 'The portal allowing seamless assets deposits & withdrawals';

  @override
  String get archethicDashboardMenuWalletOnWayItem => 'Archethic Wallet';

  @override
  String get archethicDashboardMenuWalletOnWayDesc => 'Securely store, transfer and swap tokens and collectibles';

  @override
  String get archethicDashboardMenuFaucetItem => 'Faucet';

  @override
  String get archethicDashboardMenuFaucetDesc => 'Get Free Testnet UCO Here';

  @override
  String get logout => 'Logout';

  @override
  String get addressCopied => 'Address copied';

  @override
  String get addPool => 'Add a pool';

  @override
  String get btn_pool_add => 'Create a new pool';

  @override
  String get btn_confirm_pool_add => 'Confirm the creation';

  @override
  String get poolAddConfirmTitle => 'Confirmation';

  @override
  String get poolAddFormTitle => 'Create a new pool';

  @override
  String get poolAddProcessInterruptionWarning => 'Are you sure you want to stop the creation process?';

  @override
  String get poolAddSuccessInfo => 'The pool has been created successfully';

  @override
  String get poolAddInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get poolAddProcessInProgress => 'Please wait.';

  @override
  String get poolAddConfirmMessageMaxHalfUCO => 'The UCO amount you entered has been reduced by \$0.5 to include transaction fees.';

  @override
  String get poolAddAddMessageMaxHalfUCO => 'This process requires a maximum of \$0.5 in transaction fees to be completed.';

  @override
  String get poolAddInProgressTxAddressesPoolGenesisAddress => 'Pool genesis address:';

  @override
  String get poolAddInProgressTxAddressesPoolRegistrationAddress => 'Pool registration transaction address:';

  @override
  String get poolAddInProgressTxAddressesPoolFundsAddress => 'Pool funds transfer transaction address:';

  @override
  String get poolAddInProgressTxAddressesPoolAdditionAddress => 'Liquidity addition transaction address:';

  @override
  String get addLiquidity => 'Add liquidity';

  @override
  String get btn_liquidity_add => 'Add liquidity';

  @override
  String get btn_confirm_liquidity_add => 'Confirm the addition';

  @override
  String get liquidityAddConfirmTitle => 'Confirmation';

  @override
  String get liquidityAddFormTitle => 'Add liquidity';

  @override
  String get liquidityAddProcessInterruptionWarning => 'Are you sure you want to stop the process?';

  @override
  String get liquidityAddSuccessInfo => 'Liquidity has been added successfully';

  @override
  String get liquidityAddInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get liquidityAddProcessInProgress => 'Please wait.';

  @override
  String get liquidityAddConfirmInfosAmountTokens => 'Add liquidity in the pool';

  @override
  String get liquidityAddConfirmInfosMinAmount => 'Mininum amount';

  @override
  String get liquidityAddConfirmMessageMaxHalfUCO => 'The UCO amount you entered has been reduced to include transaction fees.';

  @override
  String get liquidityAddMessageMaxHalfUCO => 'This process requires a maximum of %1 UCO in transaction fees to be completed.';

  @override
  String get liquidityAddFinalAmount => 'LP Tokens obtained: ';

  @override
  String get liquidityAddTooltipSlippage => 'Set slippage tolerance information';

  @override
  String get liquidityAddInProgresstxAddresses => 'Liquidity addition transaction address:';

  @override
  String get liquidityAddInProgresstxAddressesShort => 'Liquidity add. transaction address:';

  @override
  String get liquidityAddInfosMinimumAmount => 'Mininum amount for';

  @override
  String get liquidityAddInfosExpectedToken => 'Expected LP Token';

  @override
  String get liquidityAddSettingsSlippageErrorBetween0and100 => 'The slippage tolerance should be between 0 (no slippage) and 100%';

  @override
  String get liquidityAddSettingsSlippageErrorHighSlippage => 'Warning. Your transaction may be significantly impacted due to high slippage.';

  @override
  String get liquidityRemovePleaseConfirm => 'Please, confirm the removal of ';

  @override
  String get liquidityRemoveAmountLPTokens => 'LP Tokens from the liquidity pool.';

  @override
  String get liquidityRemoveAmountLPToken => 'LP Token from the liquidity pool.';

  @override
  String get liquidityRemoveFinalAmountTokenObtained => 'Token obtained:';

  @override
  String get liquidityRemoveFinalAmountTokenBurned => 'LP Token burned:';

  @override
  String get liquidityRemoveInProgressTxAddresses => 'Liquidity suppression transaction address:';

  @override
  String get liquidityRemoveInProgressTxAddressesShort => 'Liquidity supp. transaction address:';

  @override
  String get failureUserRejected => 'The request has been declined.';

  @override
  String get failureConnectivityArchethic => 'Please, open your Archethic Wallet and allow DApps connection.';

  @override
  String get failureConnectivityArchethicBrave => 'Please, open your Archethic Wallet, allow DApps connection and disable Brave\'s shield.';

  @override
  String get failureInsufficientFunds => 'Funds are not sufficient.';

  @override
  String get failureTimeout => 'Timeout occurred.';

  @override
  String get failurePoolAlreadyExists => 'Pool already exists for this pair';

  @override
  String get failurePoolNotExists => 'No pool for this pair';

  @override
  String get failureIncompatibleBrowser => 'Sorry, but your browser is not compatible with the app.\n\nPlease refer to the FAQ for more information.\nhttps://wiki.archethic.net/FAQ/dex#what-web-browsers-are-not-supported';

  @override
  String get removeLiquidity => 'Remove liquidity';

  @override
  String get btn_liquidity_remove => 'Remove liquidity';

  @override
  String get btn_confirm_liquidity_remove => 'Confirm';

  @override
  String get liquidityRemoveConfirmTitle => 'Confirmation';

  @override
  String get liquidityRemoveFormTitle => 'Remove liquidity';

  @override
  String get liquidityRemoveProcessInterruptionWarning => 'Are you sure you want to stop the process?';

  @override
  String get liquidityRemoveSuccessInfo => 'The liquidity has been removed successfully';

  @override
  String get liquidityRemoveInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get liquidityRemoveProcessInProgress => 'Please wait.';

  @override
  String get swapConfirmInfosAmountTokens => 'Swap';

  @override
  String get swapConfirmInfosAmountMinReceived => 'Mininum received';

  @override
  String get swapConfirmInfosAmountMinFees => 'Fees:';

  @override
  String get swapConfirmInfosFeesLP => 'Liquidity Provider fees';

  @override
  String get swapConfirmInfosFeesProtocol => 'Protocol fees';

  @override
  String get swapConfirmInfosMessageMaxHalfUCO => 'The UCO amount you entered has been reduced to include transaction fees.';

  @override
  String get swapFinalAmountAmountSwapped => 'Final amount swapped:';

  @override
  String get swapProcessInterruptionWarning => 'Are you sure you want to stop the process?';

  @override
  String get swapSuccessInfo => 'The swap has been completed successfully';

  @override
  String get swapInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get swapProcessInProgress => 'Please wait.';

  @override
  String get swapMessageMaxHalfUCO => 'The swap process requires a maximum of %1 in transaction fees to be completed.';

  @override
  String get swapCreatePool => 'Create this pool';

  @override
  String get swapIconRefreshTooltip => 'Refresh information';

  @override
  String get swapIconSlippageTooltip => 'Set slippage tolerance information';

  @override
  String get swapInProgressTxAddresses => 'Swap transaction address:';

  @override
  String get swapInfosFees => 'Fees';

  @override
  String get swapInfosPriceImpact => 'Price impact';

  @override
  String get swapInfosMinimumReceived => 'Minimum received';

  @override
  String get swapInfosTVL => 'TVL';

  @override
  String get swapInfosRatio => 'Ratio';

  @override
  String get swapInfosLiquidityProviderFees => 'Liquidity Provider fees';

  @override
  String get swapInfosProtocolFees => 'Protocol fees';

  @override
  String get swapSettingsSlippageErrorBetween0and100 => 'The slippage tolerance should be between 0 (no slippage) and 100%';

  @override
  String get swapSettingsSlippageErrorHighSlippage => 'Warning. Your transaction may be significantly impacted due to high slippage.';

  @override
  String get poolAddControlToken1Empty => 'Please enter the token 1';

  @override
  String get poolAddControlToken2Empty => 'Please enter the token 2';

  @override
  String get poolAddControlToken1AmountExceedBalance => 'The amount entered for token 1 exceeds your balance.';

  @override
  String get poolAddControlToken2AmountExceedBalance => 'The amount entered for token 2 exceeds your balance.';

  @override
  String get poolAddControl2TokensAmountExceedBalance => 'The amount entered for the 2 tokens exceeds your balance.';

  @override
  String get poolAddControlSameTokens => 'You cannot create a pool with the same 2 tokens';

  @override
  String get addPoolProcessStep0 => 'Process not started';

  @override
  String get addPoolProcessStep1 => 'Retrieving information to create the pool';

  @override
  String get addPoolProcessStep2 => 'Retrieving information to pay pool creation fees';

  @override
  String get addPoolProcessStep3 => 'Creation of a LP token associated with the pool being created';

  @override
  String get addPoolProcessStep4 => 'Retrieving information needed to create the pool and add liquidity to the pool';

  @override
  String get addPoolProcessStep5 => 'Creating the pool and adding liquidity';

  @override
  String get addPoolProcessStep6 => 'Process finished';

  @override
  String get addLiquidityProcessStep0 => 'Process not started';

  @override
  String get addLiquidityProcessStep1 => 'Retrieving information to add liquidity to the pool';

  @override
  String get addLiquidityProcessStep2 => 'Adding liquidity';

  @override
  String get addLiquidityProcessStep3 => 'Process finished';

  @override
  String get removeLiquidityProcessStep0 => 'Process not started';

  @override
  String get removeLiquidityProcessStep1 => 'Retrieving information to remove liquidity from the pool';

  @override
  String get removeLiquidityProcessStep2 => 'Removing liquidity';

  @override
  String get removeLiquidityProcessStep3 => 'Process finished';

  @override
  String get liquidityAddControlToken1AmountEmpty => 'Please enter the amount of token 1';

  @override
  String get liquidityAddControlToken2AmountEmpty => 'Please enter the amount of token 2';

  @override
  String get liquidityAddControlToken1AmountExceedBalance => 'The amount entered for token 1 exceeds your balance.';

  @override
  String get liquidityAddControlToken2AmountExceedBalance => 'The amount entered for token 2 exceeds your balance.';

  @override
  String get liquidityRemoveControlLPTokenAmountEmpty => 'Please enter the amount of lp token';

  @override
  String get lpTokenAmountExceedBalance => 'The amount entered for lp token exceeds your balance.';

  @override
  String get liquidityRemoveTokensGetBackHeader => 'Amounts of token to get back when removing liquidity';

  @override
  String get swapControlTokenToSwapEmpty => 'Please enter the token to swap';

  @override
  String get swapControlTokenSwappedEmpty => 'Please enter the token swapped';

  @override
  String get swapControlTokenToSwapAmountExceedBalance => 'The amount entered for token to swap exceeds your balance.';

  @override
  String get poolCardPooled => 'Deposited';

  @override
  String get swapProcessStep0 => 'Process not started';

  @override
  String get swapProcessStep1 => 'Calculating';

  @override
  String get swapProcessStep2 => 'Retrieving information to swap';

  @override
  String get swapProcessStep3 => 'Swapping';

  @override
  String get swapProcessStep4 => 'Process finished';

  @override
  String get feesLbl => 'Fees';

  @override
  String get swapFromLbl => 'From';

  @override
  String get swapToEstimatedLbl => 'To (estimated)';

  @override
  String get poolAddConfirmNewPoolLbl => 'New pool';

  @override
  String get poolAddConfirmWithLiquidityLbl => 'With liquidity';

  @override
  String get confirmBeforeLbl => 'Before';

  @override
  String get confirmAfterLbl => 'After';

  @override
  String get poolCardPoolVerified => 'Pool verified';

  @override
  String get localHistoryTooltipLinkPool => 'View the pool information in the explorer';

  @override
  String get depositProcessStep0 => 'Process not started';

  @override
  String get depositProcessStep1 => 'Build transaction';

  @override
  String get depositProcessStep2 => 'Deposit in progress';

  @override
  String get depositProcessStep3 => 'Process finished';

  @override
  String get farmDepositControlAmountEmpty => 'Please enter the amount';

  @override
  String get farmDepositControlAmountMin => 'The amount should be >= 0.00000143 LP Token';

  @override
  String get farmDepositControlLPTokenAmountExceedBalance => 'The amount entered exceeds your balance.';

  @override
  String get farmDepositConfirmTitle => 'Confirmation';

  @override
  String get farmDepositFormTitle => 'Deposit';

  @override
  String get farmDepositProcessInterruptionWarning => 'Are you sure you want to stop the process?';

  @override
  String get farmDepositSuccessInfo => 'Deposit has been done successfully';

  @override
  String get farmDepositInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get farmDepositProcessInProgress => 'Please wait.';

  @override
  String get btn_farm_deposit => 'Deposit';

  @override
  String get btn_confirm_farm_deposit => 'Confirm';

  @override
  String get withdrawProcessStep0 => 'Process not started';

  @override
  String get withdrawProcessStep1 => 'Build transaction';

  @override
  String get withdrawProcessStep2 => 'Withdraw in progress';

  @override
  String get withdrawProcessStep3 => 'Process finished';

  @override
  String get farmWithdrawControlAmountEmpty => 'Please enter the amount';

  @override
  String get farmWithdrawConfirmTitle => 'Confirmation';

  @override
  String get farmWithdrawFormTitle => 'Withdraw';

  @override
  String get farmWithdrawProcessInterruptionWarning => 'Are you sure you want to stop the process?';

  @override
  String get farmWithdrawSuccessInfo => 'Withdraw has been done successfully';

  @override
  String get farmWithdrawInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get farmWithdrawProcessInProgress => 'Please wait.';

  @override
  String get farmWithdrawControlLPTokenAmountExceedDeposited => 'The amount entered exceeds the deposited amount.';

  @override
  String get btn_farm_withdraw => 'Withdraw';

  @override
  String get btn_confirm_farm_withdraw => 'Confirm';

  @override
  String get claimProcessStep0 => 'Process not started';

  @override
  String get claimProcessStep1 => 'Build transaction';

  @override
  String get claimProcessStep2 => 'Claim in progress';

  @override
  String get claimProcessStep3 => 'Process finished';

  @override
  String get farmClaimConfirmTitle => 'Confirmation';

  @override
  String get farmClaimFormTitle => 'Claim';

  @override
  String get farmClaimProcessInterruptionWarning => 'Are you sure you want to stop the process?';

  @override
  String get farmClaimSuccessInfo => 'Claim has been done successfully';

  @override
  String get farmClaimInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get farmClaimProcessInProgress => 'Please wait.';

  @override
  String get btn_farm_claim => 'Claim';

  @override
  String get btn_confirm_farm_claim => 'Confirm';

  @override
  String get farmDetailsInfoAddressesFarmAddress => 'Farm address: ';

  @override
  String get farmDetailsInfoAddressesLPAddress => 'LP Token address: ';

  @override
  String get farmDetailsInfoAPR => 'Current APR';

  @override
  String get farmDetailsInfoDistributedRewards => 'Distributed rewards';

  @override
  String get farmDetailsInfoLPDeposited => 'LP Token deposited';

  @override
  String get lpToken => 'LP Token';

  @override
  String get lpTokens => 'LP Tokens';

  @override
  String get lpTokenExpected => 'LP Token expected';

  @override
  String get lpTokensExpected => 'LP Tokens expected';

  @override
  String get available => 'Available';

  @override
  String get legacy => 'Legacy';

  @override
  String get lvl => 'Lvl';

  @override
  String get level => 'Level';

  @override
  String get farmDetailsInfoNbDeposit => 'Holders';

  @override
  String get farmDetailsInfoPeriodWillStart => 'Farm will start at';

  @override
  String get farmDetailsInfoPeriodStarted => 'Farm started since';

  @override
  String get farmDetailsInfoPeriodEndAt => 'Farm ends at';

  @override
  String get farmDetailsInfoPeriodEnded => 'Farm ended';

  @override
  String get farmDetailsInfoRemainingReward => 'Remaining reward';

  @override
  String get farmDetailsInfoTokenRewardEarn => 'Earn';

  @override
  String get farmDetailsInfoYourAvailableLP => 'Your available LP Tokens';

  @override
  String get farmDetailsInfoYourDepositedAmount => 'Your deposited amount';

  @override
  String get farmDetailsInfoYourRewardAmount => 'Your reward amount';

  @override
  String get farmDetailsButtonDepositFarmClosed => 'Deposit LP Tokens (Farm closed)';

  @override
  String get farmDetailsButtonDeposit => 'Deposit LP Tokens';

  @override
  String get farmDetailsButtonWithdraw => 'Withdraw';

  @override
  String get farmDetailsButtonClaim => 'Claim';

  @override
  String get farmCardTitle => 'Farming';

  @override
  String get refreshIconToolTip => 'Refresh information';

  @override
  String get poolDetailsInfoSwapFees => 'Swap fees';

  @override
  String get poolDetailsInfoProtocolFees => 'Protocol fees';

  @override
  String get poolDetailsInfoAddressesPoolAddress => 'Pool address: ';

  @override
  String get poolDetailsInfoAddressesLPAddress => 'LP Token address: ';

  @override
  String get poolDetailsInfoAddressesToken1Address => 'Token %1 address: ';

  @override
  String get poolDetailsInfoAddressesToken2Address => 'Token %1 address: ';

  @override
  String get poolDetailsInfoDeposited => 'Deposited';

  @override
  String get poolDetailsInfoDepositedEquivalent => 'Equivalent';

  @override
  String get poolDetailsInfoTVL => 'TVL';

  @override
  String get poolDetailsInfoAPR => 'APR';

  @override
  String get poolDetailsInfoAPRFarm3Years => 'Earn';

  @override
  String get time24h => '24h';

  @override
  String get time7d => '7d';

  @override
  String get timeAll => 'All';

  @override
  String get poolDetailsInfoVolume => 'Volume';

  @override
  String get poolDetailsInfoFees => 'Fees';

  @override
  String get poolDetailsInfoButtonAddLiquidity => 'Add Liquidity';

  @override
  String get poolDetailsInfoButtonRemoveLiquidity => 'Remove Liquidity';

  @override
  String get poolAddFavoriteIconTooltip => 'Add this pool in my favorites tab';

  @override
  String get poolCardTitle => 'Pool';

  @override
  String get poolListSearchBarHint => 'Search by pool or token address or \"UCO\"';

  @override
  String get poolCreatePoolButton => 'Create Pool';

  @override
  String get poolListTabVerified => 'Verified';

  @override
  String get poolListTabMyPools => 'My pools';

  @override
  String get poolListTabFavorites => 'Favorites';

  @override
  String get poolListTabResults => 'Results';

  @override
  String get poolRefreshIconTooltip => 'Refresh information';

  @override
  String get poolRemoveFavoriteIconConfirmation => 'Remove the pool from favorite tab?';

  @override
  String get poolRemoveFavoriteIconTooltip => 'Remove the pool from favorite tab?';

  @override
  String get poolListSearching => 'Searching in progress. Please wait';

  @override
  String get poolListConnectWalletMyPools => 'Please, connect your wallet to list your pools with position.';

  @override
  String get poolListEnterSearchCriteria => 'Please enter your search criteria.';

  @override
  String get poolListNoResult => 'No results found.';

  @override
  String get poolListAddFavoriteText1 => 'To add your favorite pools to this tab, please click on the';

  @override
  String get poolListAddFavoriteText2 => 'icon in the pool cards header.';

  @override
  String get farmClaimConfirmInfosText => 'Please confirm the claim of ';

  @override
  String get farmClaimFinalAmount => 'Amount claimed: ';

  @override
  String get finalAmountNotRecovered => 'The amount could not be recovered';

  @override
  String get finalAmountsNotRecovered => 'The amounts could not be recovered';

  @override
  String get farmClaimFormText => 'are available for claiming.';

  @override
  String get farmClaimTxAddress => 'Claim transaction address: ';

  @override
  String get farmDepositConfirmInfosText => 'Please confirm the deposit of ';

  @override
  String get farmDepositConfirmYourBalance => 'Your balance';

  @override
  String get farmDepositConfirmFarmBalance => 'Farm\'s balance';

  @override
  String get farmDepositFinalAmount => 'Amount deposited: ';

  @override
  String get farmDepositTxAddress => 'Deposit transaction address: ';

  @override
  String get farmWithdrawConfirmInfosText => 'Please confirm the withdraw of ';

  @override
  String get farmWithdrawConfirmYourBalance => 'Your balance';

  @override
  String get farmWithdrawConfirmFarmBalance => 'Farm\'s balance';

  @override
  String get farmWithdrawConfirmRewards => 'Rewards';

  @override
  String get farmWithdrawConfirmYouWillReceive => 'You will receive ';

  @override
  String get farmWithdrawFinalAmount => 'Amount withdrawn: ';

  @override
  String get farmWithdrawFinalAmountReward => 'Amount rewarded: ';

  @override
  String get farmWithdrawFormText => 'You can withdraw all or part of your deposited LP tokens. At the same time, this will claim your rewards.';

  @override
  String get farmWithdrawFormTextNoRewardText1 => 'No reward are available';

  @override
  String get farmWithdrawFormTextNoRewardText2 => ' are available for claiming.';

  @override
  String get farmWithdrawTxAddress => 'Withdraw transaction address: ';

  @override
  String get runningTasksNotificationTasksInProgress => 'tasks in progress';

  @override
  String get runningTasksNotificationTaskInProgress => 'task in progress';

  @override
  String get warning => 'Warning';

  @override
  String get headerDecentralizedExchange => 'Decentralized Exchange';

  @override
  String get tokenSelectionSingleTokenLPTooltip => 'LP Token for pair';

  @override
  String get priceImpact => 'Price impact:';

  @override
  String get priceImpactHighTooltip => 'Warning, the price impact is high.';

  @override
  String get liquidityPositionsIconTooltip => 'You have liquidity positions';

  @override
  String get liquidityFavoriteIconTooltip => 'Favorite pool';

  @override
  String get verifiedPoolIconTooltip => 'This pool has been verified by Archethic';

  @override
  String get verifiedTokenIconTooltip => 'This token has been verified by Archethic';

  @override
  String get poolInfoCardTVL => 'TVL:';

  @override
  String get apr24hTooltip => 'Estimation of the annual yield based on the fees generated by swaps over the last 24 hours.\nIt provides an idea of the potential annual return based on recent performance.';

  @override
  String get btn_farmLockDeposit => 'Deposit';

  @override
  String get farmLockDepositFormTitle => 'Deposit';

  @override
  String get farmLockDepositFormAmountLbl => 'Amount';

  @override
  String get farmLockDepositDurationFlexible => 'Flexible';

  @override
  String get farmLockDepositDurationOneMonth => '1 month';

  @override
  String get farmLockDepositDurationOneWeek => '1 week';

  @override
  String get farmLockDepositDurationOneYear => '1 year';

  @override
  String get farmLockDepositDurationSixMonths => '6 months';

  @override
  String get farmLockDepositDurationThreeMonths => '3 months';

  @override
  String get farmLockDepositDurationThreeYears => '3 years';

  @override
  String get farmLockDepositDurationTwoYears => '2 years';

  @override
  String get farmLockDepositDurationMax => 'Max';

  @override
  String get farmLockDepositAPREstimationLbl => 'Est. APR:';

  @override
  String get farmLockDepositAPRLbl => 'APR:';

  @override
  String get btn_confirm_farm_add_lock => 'Confirm';

  @override
  String get farmLockDepositUnlockDateLbl => 'Release date:';

  @override
  String get farmLockDepositConfirmTitle => 'Confirmation';

  @override
  String get farmLockDepositConfirmInfosText => 'Please confirm the lock of ';

  @override
  String get farmLockDepositConfirmYourBalance => 'Your balance';

  @override
  String get farmLockDepositConfirmInfosText2 => ' for ';

  @override
  String get farmLockDepositFormLockDurationLbl => 'Choose the lock duration';

  @override
  String get farmLockDepositConfirmInfosText3 => 'You can recover your LP Tokens and associated rewards at any time.';

  @override
  String get farmLockDepositConfirmCheckBoxUnderstand => 'I understand I can\'t get my tokens back before the release date.';

  @override
  String get farmLockDepositConfirmMoreInfo => 'More info.';

  @override
  String get depositFarmLockProcessStep0 => 'Process not started';

  @override
  String get depositFarmLockProcessStep1 => 'Build transaction';

  @override
  String get depositFarmLockProcessStep2 => 'Deposit in progress';

  @override
  String get depositFarmLockProcessStep3 => 'Process finished';

  @override
  String get farmLockDepositFinalAmount => 'Amount deposited: ';

  @override
  String get farmLockDepositTxAddress => 'Deposit transaction address: ';

  @override
  String get farmLockDepositInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get farmLockDepositSuccessInfo => 'Deposit have been done successfully';

  @override
  String get depositFarmLockProcessInProgress => 'Please wait.';

  @override
  String get farmLockWithdrawConfirmInfosText => 'Please confirm the withdraw of ';

  @override
  String get farmLockWithdrawConfirmYourBalance => 'Your balance';

  @override
  String get farmLockWithdrawConfirmFarmBalance => 'Farm\'s balance';

  @override
  String get farmLockWithdrawConfirmRewards => 'Rewards';

  @override
  String get farmLockWithdrawConfirmYouWillReceive => 'You will receive ';

  @override
  String get farmLockWithdrawFinalAmount => 'Amount withdrawn: ';

  @override
  String get farmLockWithdrawFinalAmountReward => 'Amount rewarded: ';

  @override
  String get farmLockWithdrawFormText => 'You can withdraw all or part of your deposited LP tokens. At the same time, this will claim your rewards.';

  @override
  String get farmLockWithdrawFormTextNoRewardText1 => 'No reward are available';

  @override
  String get farmLockWithdrawFormTextNoRewardText2 => ' are available for claiming.';

  @override
  String get farmLockWithdrawTxAddress => 'Withdraw transaction address: ';

  @override
  String get farmLockWithdrawControlAmountEmpty => 'Please enter the amount';

  @override
  String get farmLockWithdrawConfirmTitle => 'Confirmation';

  @override
  String get farmLockWithdrawFormTitle => 'Withdraw';

  @override
  String get farmLockWithdrawProcessInterruptionWarning => 'Are you sure you want to stop the process?';

  @override
  String get farmLockWithdrawSuccessInfo => 'Withdraw has been done successfully';

  @override
  String get farmLockWithdrawInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get farmLockWithdrawProcessInProgress => 'Please wait.';

  @override
  String get farmLockWithdrawControlLPTokenAmountExceedDeposited => 'The amount entered exceeds the deposited amount.';

  @override
  String get withdrawFarmLockProcessStep0 => 'Process not started';

  @override
  String get withdrawFarmLockProcessStep1 => 'Build transaction';

  @override
  String get withdrawFarmLockProcessStep2 => 'Withdraw in progress';

  @override
  String get withdrawFarmLockProcessStep3 => 'Process finished';

  @override
  String get farmLockBlockAddLiquidityHeader => '1 - Add liquidity';

  @override
  String get farmLockBlockAddLiquidityDesc => 'Add liquidity to the pool and receive LP tokens representing your share.\nBy adding liquidity, you gain access to farming opportunities and can earn additional rewards.';

  @override
  String get farmLockBlockAddLiquidityViewGuideArticle => 'View the guide article';

  @override
  String get farmLockBlockAddLiquidityBtnAdd => 'Add';

  @override
  String get farmLockBlockAddLiquidityBtnInfos => 'Infos';

  @override
  String get farmLockBlockEarnRewardsBtnInfosFarmLegacy => 'Infos Farm legacy';

  @override
  String get farmLockBlockEarnRewardsBtnInfosFarmLock => 'Infos Farm lock';

  @override
  String get farmLockBlockAddLiquidityBtnWithdraw => 'Withdraw';

  @override
  String get farmLockBlockEarnRewardsHeader => '2 - Earn more';

  @override
  String get farmLockBlockEarnRewardsDesc => 'Farm your LP Tokens to earn rewards. By locking them for a specified period, you increase your rewards.\nThe longer you lock, the greater your rewards.';

  @override
  String get farmLockBlockEarnRewardsWarning => 'Warning: Rewards are recalculated every hour.';

  @override
  String get farmLockBlockEarnRewardsStartFarm => 'Info: Rewards emission will start on';

  @override
  String get farmLockBlockEarnRewardsBtnAdd => 'Add';

  @override
  String get farmLockBlockEarnRewardsBtnNotAvailable => 'Farm not available';

  @override
  String get farmLockBlockEarnRewardsViewGuideArticle => 'View the guide article';

  @override
  String get farmLockBlockAprLbl => 'APR 3 years';

  @override
  String get farmLockBlockFarmedTokensSummaryHeader => 'Farmed Tokens Summary';

  @override
  String get farmLockBlockBalanceSummaryHeader => 'Your Balances Summary';

  @override
  String get farmLockBlockFarmedTokensSummaryCapitalInvestedLbl => 'Capital Invested';

  @override
  String get farmLockBlockFarmedTokensSummaryCapitalRewardsEarnedLbl => 'Rewards Earned';

  @override
  String get farmLockBlockListHeaderAmount => 'Amount';

  @override
  String get farmLockBlockListHeaderRewards => 'Estimated rewards';

  @override
  String get farmLockBlockListHeaderUnlocksIn => 'Unlocks in';

  @override
  String get farmLockBlockListHeaderUnlocks => 'Unlocks';

  @override
  String get farmLockBlockListHeaderLevel => 'Level';

  @override
  String get farmLockBlockListHeaderAPR => 'APR';

  @override
  String get farmLockBlockListHeaderActions => 'Actions';

  @override
  String get farmLockBtnLevelUp => 'Level Up!';

  @override
  String get farmLockBtnWithdraw => 'Withdraw';

  @override
  String get levelUpFarmLockProcessStep0 => 'Process not started';

  @override
  String get levelUpFarmLockProcessStep1 => 'Build transaction';

  @override
  String get levelUpFarmLockProcessStep2 => 'Level up in progress';

  @override
  String get levelUpFarmLockProcessStep3 => 'Process finished';

  @override
  String get btn_farmLockLevelUp => 'Level Up';

  @override
  String get farmLockLevelUpFormTitle => 'Level Up';

  @override
  String get farmLockLevelUpFormAmountLbl => 'Amount';

  @override
  String get farmLockLevelUpAPREstimationLbl => 'Est. APR:';

  @override
  String get farmLockLevelUpAPRLbl => 'APR:';

  @override
  String get farmLockLevelUpUnlockDateLbl => 'Release date:';

  @override
  String get farmLockLevelUpCurrentLvlLbl => 'Current level:';

  @override
  String get farmLockLevelUpConfirmTitle => 'Confirmation';

  @override
  String get farmLockLevelUpConfirmInfosText => 'Please confirm the lock of ';

  @override
  String get farmLockLevelUpConfirmYourBalance => 'Your balance';

  @override
  String get farmLockLevelUpConfirmInfosText2 => ' for ';

  @override
  String get farmLockLevelUpFormLockDurationLbl => 'Choose the lock duration';

  @override
  String get farmLockLevelUpConfirmInfosText3 => 'You can recover your LP Tokens and associated rewards at any time.';

  @override
  String get farmLockLevelUpFinalAmount => 'Amount: ';

  @override
  String get farmLockLevelUpTxAddress => 'Level Up transaction address: ';

  @override
  String get farmLockLevelUpInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get farmLockLevelUpSuccessInfo => 'Deposit have been done successfully';

  @override
  String get farmLockLevelUpDesc => 'You can extend the duration of your lock to earn more rewards.\nTo do this, you must choose a longer period than before, which will provide you with a higher level. The higher your level, the higher the APR.\nAt the same time, this will claim your actual rewards.';

  @override
  String get farmLockLevelUpConfirmCheckBoxUnderstand => 'I understand I can\'t get my tokens back before the release date.';

  @override
  String get farmLockLevelUpConfirmMoreInfo => 'More info.';

  @override
  String get addLiquiditySignTxDesc_en => 'The transaction sends the amount of each token in the pool pair to the pool address and calls the smart contract\'s add liquidity function with the minimum amount for each token.';

  @override
  String get addPoolSignTxDesc1_en => 'The transaction sends fees to the pool address to pay for the execution of the pool creation.';

  @override
  String get addPoolSignTxDesc2_en => 'The transaction sends the amount of each token in the pool pair to the pool address, calls the smart contract\'s add pool function with the pair addresses and the new pool address, and then calls the smart contract\'s add liquidity function with the minimum amount for each token.';

  @override
  String get claimFarmSignTxDesc_en => 'The transaction calls the smart contract\'s claim function to execute the claim.';

  @override
  String get depositFarmLockSignTxDesc_en => 'The transaction sends the LP tokens to be locked into the farm and calls the smart contract\'s deposit function with the tokens\' release date.';

  @override
  String get depositFarmSignTxDesc_en => 'The transaction sends the amount of LP tokens to the farm address and calls the smart contract\'s deposit function to execute the deposit.';

  @override
  String get levelUpFarmLockSignTxDesc_en => 'The transaction sends the LP tokens to be relocked into the farm by calling the smart contract\'s relock function with the tokens\' new release date and the associated index of the deposit.';

  @override
  String get removeLiquiditySignTxDesc_en => 'The transaction burns the amount of LP Token who wish to withdraw from the pool and calls the smart contract\'s remove liquidity function to obtain the equivalent tokens.';

  @override
  String get swapSignTxDesc_en => 'The transaction sends the amount of the token you want to swap to the pool address, calls the smart contract\'s swap function, and obtains the equivalent token, considering the slippage tolerance.';

  @override
  String get withdrawFarmLockSignTxDesc_en => 'The transaction calls the smart contract\'s withdraw function with the amount of LP tokens and the associated index of the deposit to execute the withdrawal and claim the associated rewards.';

  @override
  String get withdrawFarmSignTxDesc_en => 'The transaction calls the smart contract\'s withdraw function with the amount of LP tokens to execute the withdrawal and claim the associated rewards.';

  @override
  String get addLiquiditySignTxDesc_fr => 'La transaction envoie le montant de chaque jeton de la paire de la pool à l\'adresse de la pool et appelle la fonction d\'ajout de liquidité du contrat intelligent avec le montant minimum pour chaque jeton.';

  @override
  String get addPoolSignTxDesc1_fr => 'La transaction envoie les frais à l\'adresse de la pool pour payer l\'exécution de la création de la pool.';

  @override
  String get addPoolSignTxDesc2_fr => 'La transaction envoie le montant de chaque jeton de la paire de la pool à l\'adresse de la pool, appelle la fonction d\'ajout de pool du contrat intelligent avec les adresses de la paire et la nouvelle adresse de la pool, puis appelle la fonction d\'ajout de liquidité du contrat intelligent avec le montant minimum pour chaque jeton.';

  @override
  String get claimFarmSignTxDesc_fr => 'La transaction appelle la fonction de récupération des récompenses du contrat intelligent pour exécuter la récupération.';

  @override
  String get depositFarmLockSignTxDesc_fr => 'La transaction envoie les jetons LP à verrouiller dans la farm et appelle la fonction de dépôt du contrat intelligent avec la date de libération des jetons.';

  @override
  String get depositFarmSignTxDesc_fr => 'La transaction envoie le montant de jetons LP à l\'adresse de la farm et appelle la fonction de dépôt du contrat intelligent pour exécuter le dépôt.';

  @override
  String get levelUpFarmLockSignTxDesc_fr => 'La transaction envoie les jetons LP à reverrouiller dans la farm en appelant la fonction de reverrouillage du contrat intelligent avec la nouvelle date de libération des jetons et l\'index associé du dépôt.';

  @override
  String get removeLiquiditySignTxDesc_fr => 'La transaction brûle le montant de jetons LP que vous souhaitez retirer de la pool et appelle la fonction de retrait de liquidité du contrat intelligent pour obtenir les jetons équivalents.';

  @override
  String get swapSignTxDesc_fr => 'La transaction envoie le montant du jeton que vous souhaitez échanger à l\'adresse de la pool, appelle la fonction d\'échange du contrat intelligent et obtient les jetons équivalents, en tenant compte du slippage.';

  @override
  String get withdrawFarmLockSignTxDesc_fr => 'La transaction appelle la fonction de retrait du contrat intelligent avec le montant de jetons LP et l\'index associé du dépôt pour exécuter le retrait et réclamer les récompenses associées.';

  @override
  String get withdrawFarmSignTxDesc_fr => 'La transaction appelle la fonction de retrait du contrat intelligent avec le montant de jetons LP pour exécuter le retrait et réclamer les récompenses associées.';

  @override
  String get poolFarmingAvailable => 'Farming available';

  @override
  String get poolFarming => 'Farming';

  @override
  String get claimFarmLockSignTxDesc_en => 'The transaction calls the smart contract\'s claim function to execute the claim.';

  @override
  String get claimFarmLockSignTxDesc_fr => 'La transaction appelle la fonction de récupération des récompenses du contrat intelligent pour exécuter la récupération.';

  @override
  String get farmLockClaimConfirmInfosText => 'Please confirm the claim of ';

  @override
  String get farmLockClaimFinalAmount => 'Amount claimed: ';

  @override
  String get farmLockClaimFormText => 'are available for claiming.';

  @override
  String get farmLockClaimTxAddress => 'Claim transaction address: ';

  @override
  String get farmLockClaimConfirmTitle => 'Confirmation';

  @override
  String get farmLockClaimFormTitle => 'Claim';

  @override
  String get farmLockClaimProcessInterruptionWarning => 'Are you sure you want to stop the process?';

  @override
  String get farmLockClaimSuccessInfo => 'Claim has been done successfully';

  @override
  String get farmLockClaimInProgressConfirmAEWallet => 'Please, confirm a transaction in your Archethic Wallet';

  @override
  String get farmLockClaimProcessInProgress => 'Please wait.';

  @override
  String get btn_farm_lock_claim => 'Claim';

  @override
  String get btn_confirm_farm_lock_claim => 'Confirm';

  @override
  String get claimLockProcessStep0 => 'Process not started';

  @override
  String get claimLockProcessStep1 => 'Build transaction';

  @override
  String get claimLockProcessStep2 => 'Claim in progress';

  @override
  String get claimLockProcessStep3 => 'Process finished';

  @override
  String get farmLockBtnClaim => 'Claim';

  @override
  String get farmLockDetailsLevelSingleRewardsAllocated => 'Rewards allocated per period';

  @override
  String get farmLockDetailsLevelSingleWeight => 'Weight';

  @override
  String get poolTxTypeUnknown => 'Unknown';

  @override
  String get poolTxAccount => 'Account';

  @override
  String get poolTxTotalValue => 'Total value:';

  @override
  String get errorDesc1 => 'aeSwap';

  @override
  String get errorDesc2 => 'Oops! Page not found.';

  @override
  String get errorDesc3 => 'Return to Homepage';

  @override
  String get mobileInfoTitle => 'Mobile Compatibility';

  @override
  String get mobileInfoTxt1 => 'We have detected that you are using a mobile device. Currently, our application is not optimized for mobile devices.\nFor the best experience, we recommend the following options:';

  @override
  String get mobileInfoTxt2 => '1. Use our application on a desktop computer.';

  @override
  String get mobileInfoTxt3 => '2. Use our application within your Archethic wallet on iOS, DApps tab.';

  @override
  String get mobileInfoTxt4 => 'Please note that updates for mobile compatibility are coming soon.';

  @override
  String get mobileInfoTxt5 => 'Thank you for your understanding.';
}
