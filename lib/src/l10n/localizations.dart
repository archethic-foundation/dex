import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @btn_understand.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get btn_understand;

  /// No description provided for @btn_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get btn_save;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @connectionWalletDisconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect wallet'**
  String get connectionWalletDisconnect;

  /// No description provided for @go.
  ///
  /// In en, this message translates to:
  /// **'Go !'**
  String get go;

  /// No description provided for @btn_connect_wallet.
  ///
  /// In en, this message translates to:
  /// **'Connect wallet'**
  String get btn_connect_wallet;

  /// No description provided for @confirmationPopupTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Request'**
  String get confirmationPopupTitle;

  /// No description provided for @connectionWalletDisconnectWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to disconnect your wallet and exit the application?'**
  String get connectionWalletDisconnectWarning;

  /// No description provided for @changeCurrentAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning, your current account has been updated.'**
  String get changeCurrentAccountWarning;

  /// No description provided for @welcomeNoWallet.
  ///
  /// In en, this message translates to:
  /// **'Unlock the full potential of our Web3 application - get the Archethic Wallet now!'**
  String get welcomeNoWallet;

  /// No description provided for @menu_swap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get menu_swap;

  /// No description provided for @menu_liquidity.
  ///
  /// In en, this message translates to:
  /// **'Pools'**
  String get menu_liquidity;

  /// No description provided for @menu_earn.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get menu_earn;

  /// No description provided for @menu_bridge.
  ///
  /// In en, this message translates to:
  /// **'Bridge'**
  String get menu_bridge;

  /// No description provided for @menu_get_wallet.
  ///
  /// In en, this message translates to:
  /// **'Get Wallet'**
  String get menu_get_wallet;

  /// No description provided for @menu_documentation.
  ///
  /// In en, this message translates to:
  /// **'Documentation'**
  String get menu_documentation;

  /// No description provided for @menu_sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source code'**
  String get menu_sourceCode;

  /// No description provided for @menu_faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get menu_faq;

  /// No description provided for @menu_tuto.
  ///
  /// In en, this message translates to:
  /// **'Tutorials'**
  String get menu_tuto;

  /// No description provided for @menu_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get menu_privacy_policy;

  /// No description provided for @menu_terms_of_use.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get menu_terms_of_use;

  /// No description provided for @menu_report_bug.
  ///
  /// In en, this message translates to:
  /// **'Report a bug'**
  String get menu_report_bug;

  /// No description provided for @btn_selectToken.
  ///
  /// In en, this message translates to:
  /// **'Select a token'**
  String get btn_selectToken;

  /// No description provided for @btn_swap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get btn_swap;

  /// No description provided for @btn_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get btn_close;

  /// No description provided for @btn_confirm_swap.
  ///
  /// In en, this message translates to:
  /// **'Confirm swap'**
  String get btn_confirm_swap;

  /// No description provided for @token_selection_search_bar_hint.
  ///
  /// In en, this message translates to:
  /// **'Search symbol or from token address'**
  String get token_selection_search_bar_hint;

  /// No description provided for @token_selection_common_bases_title.
  ///
  /// In en, this message translates to:
  /// **'Common bases'**
  String get token_selection_common_bases_title;

  /// No description provided for @token_selection_your_tokens_title.
  ///
  /// In en, this message translates to:
  /// **'Your tokens'**
  String get token_selection_your_tokens_title;

  /// No description provided for @token_selection_get_tokens_from_wallet.
  ///
  /// In en, this message translates to:
  /// **'Retrieving tokens from your current account in your wallet...'**
  String get token_selection_get_tokens_from_wallet;

  /// No description provided for @slippage_tolerance.
  ///
  /// In en, this message translates to:
  /// **'Slippage tolerance'**
  String get slippage_tolerance;

  /// No description provided for @archethicDashboardMenuBridgeItem.
  ///
  /// In en, this message translates to:
  /// **'Bridge'**
  String get archethicDashboardMenuBridgeItem;

  /// No description provided for @archethicDashboardMenuBridgeDesc.
  ///
  /// In en, this message translates to:
  /// **'The portal allowing seamless assets deposits & withdrawals'**
  String get archethicDashboardMenuBridgeDesc;

  /// No description provided for @archethicDashboardMenuWalletOnWayItem.
  ///
  /// In en, this message translates to:
  /// **'Archethic Wallet'**
  String get archethicDashboardMenuWalletOnWayItem;

  /// No description provided for @archethicDashboardMenuWalletOnWayDesc.
  ///
  /// In en, this message translates to:
  /// **'Securely store, transfer and swap tokens and collectibles'**
  String get archethicDashboardMenuWalletOnWayDesc;

  /// No description provided for @archethicDashboardMenuFaucetItem.
  ///
  /// In en, this message translates to:
  /// **'Faucet'**
  String get archethicDashboardMenuFaucetItem;

  /// No description provided for @archethicDashboardMenuFaucetDesc.
  ///
  /// In en, this message translates to:
  /// **'Get Free Testnet UCO Here'**
  String get archethicDashboardMenuFaucetDesc;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @addressCopied.
  ///
  /// In en, this message translates to:
  /// **'Address copied'**
  String get addressCopied;

  /// No description provided for @addPool.
  ///
  /// In en, this message translates to:
  /// **'Add a pool'**
  String get addPool;

  /// No description provided for @btn_pool_add.
  ///
  /// In en, this message translates to:
  /// **'Create a new pool'**
  String get btn_pool_add;

  /// No description provided for @btn_confirm_pool_add.
  ///
  /// In en, this message translates to:
  /// **'Confirm the creation'**
  String get btn_confirm_pool_add;

  /// No description provided for @poolAddConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get poolAddConfirmTitle;

  /// No description provided for @poolAddFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new pool'**
  String get poolAddFormTitle;

  /// No description provided for @poolAddProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the creation process?'**
  String get poolAddProcessInterruptionWarning;

  /// No description provided for @poolAddSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'The pool has been created successfully'**
  String get poolAddSuccessInfo;

  /// No description provided for @poolAddInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get poolAddInProgressConfirmAEWallet;

  /// No description provided for @poolAddProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get poolAddProcessInProgress;

  /// No description provided for @poolAddConfirmMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'The UCO amount you entered has been reduced by \$0.5 to include transaction fees.'**
  String get poolAddConfirmMessageMaxHalfUCO;

  /// No description provided for @poolAddAddMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'This process requires a maximum of \$0.5 in transaction fees to be completed.'**
  String get poolAddAddMessageMaxHalfUCO;

  /// No description provided for @poolAddInProgressTxAddressesPoolGenesisAddress.
  ///
  /// In en, this message translates to:
  /// **'Pool genesis address:'**
  String get poolAddInProgressTxAddressesPoolGenesisAddress;

  /// No description provided for @poolAddInProgressTxAddressesPoolRegistrationAddress.
  ///
  /// In en, this message translates to:
  /// **'Pool registration transaction address:'**
  String get poolAddInProgressTxAddressesPoolRegistrationAddress;

  /// No description provided for @poolAddInProgressTxAddressesPoolFundsAddress.
  ///
  /// In en, this message translates to:
  /// **'Pool funds transfer transaction address:'**
  String get poolAddInProgressTxAddressesPoolFundsAddress;

  /// No description provided for @poolAddInProgressTxAddressesPoolAdditionAddress.
  ///
  /// In en, this message translates to:
  /// **'Liquidity addition transaction address:'**
  String get poolAddInProgressTxAddressesPoolAdditionAddress;

  /// No description provided for @addLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Add liquidity'**
  String get addLiquidity;

  /// No description provided for @btn_liquidity_add.
  ///
  /// In en, this message translates to:
  /// **'Add liquidity'**
  String get btn_liquidity_add;

  /// No description provided for @btn_confirm_liquidity_add.
  ///
  /// In en, this message translates to:
  /// **'Confirm the addition'**
  String get btn_confirm_liquidity_add;

  /// No description provided for @liquidityAddConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get liquidityAddConfirmTitle;

  /// No description provided for @liquidityAddFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Add liquidity'**
  String get liquidityAddFormTitle;

  /// No description provided for @liquidityAddProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get liquidityAddProcessInterruptionWarning;

  /// No description provided for @liquidityAddSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Liquidity has been added successfully'**
  String get liquidityAddSuccessInfo;

  /// No description provided for @liquidityAddInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get liquidityAddInProgressConfirmAEWallet;

  /// No description provided for @liquidityAddProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get liquidityAddProcessInProgress;

  /// No description provided for @liquidityAddConfirmInfosAmountTokens.
  ///
  /// In en, this message translates to:
  /// **'Add liquidity in the pool'**
  String get liquidityAddConfirmInfosAmountTokens;

  /// No description provided for @liquidityAddConfirmInfosMinAmount.
  ///
  /// In en, this message translates to:
  /// **'Mininum amount'**
  String get liquidityAddConfirmInfosMinAmount;

  /// No description provided for @liquidityAddConfirmMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'The UCO amount you entered has been reduced to include transaction fees.'**
  String get liquidityAddConfirmMessageMaxHalfUCO;

  /// No description provided for @liquidityAddMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'This process requires a maximum of %1 UCO in transaction fees to be completed.'**
  String get liquidityAddMessageMaxHalfUCO;

  /// No description provided for @liquidityAddFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'LP Tokens obtained: '**
  String get liquidityAddFinalAmount;

  /// No description provided for @liquidityAddTooltipSlippage.
  ///
  /// In en, this message translates to:
  /// **'Set slippage tolerance information'**
  String get liquidityAddTooltipSlippage;

  /// No description provided for @liquidityAddInProgresstxAddresses.
  ///
  /// In en, this message translates to:
  /// **'Liquidity addition transaction address:'**
  String get liquidityAddInProgresstxAddresses;

  /// No description provided for @liquidityAddInProgresstxAddressesShort.
  ///
  /// In en, this message translates to:
  /// **'Liquidity add. transaction address:'**
  String get liquidityAddInProgresstxAddressesShort;

  /// No description provided for @liquidityAddInfosMinimumAmount.
  ///
  /// In en, this message translates to:
  /// **'Mininum amount for'**
  String get liquidityAddInfosMinimumAmount;

  /// No description provided for @liquidityAddInfosExpectedToken.
  ///
  /// In en, this message translates to:
  /// **'Expected LP Token'**
  String get liquidityAddInfosExpectedToken;

  /// No description provided for @liquidityAddSettingsSlippageErrorBetween0and100.
  ///
  /// In en, this message translates to:
  /// **'The slippage tolerance should be between 0 (no slippage) and 100%'**
  String get liquidityAddSettingsSlippageErrorBetween0and100;

  /// No description provided for @liquidityAddSettingsSlippageErrorHighSlippage.
  ///
  /// In en, this message translates to:
  /// **'Warning. Your transaction may be significantly impacted due to high slippage.'**
  String get liquidityAddSettingsSlippageErrorHighSlippage;

  /// No description provided for @liquidityRemovePleaseConfirm.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm the removal of '**
  String get liquidityRemovePleaseConfirm;

  /// No description provided for @liquidityRemoveAmountLPTokens.
  ///
  /// In en, this message translates to:
  /// **'LP Tokens from the liquidity pool.'**
  String get liquidityRemoveAmountLPTokens;

  /// No description provided for @liquidityRemoveAmountLPToken.
  ///
  /// In en, this message translates to:
  /// **'LP Token from the liquidity pool.'**
  String get liquidityRemoveAmountLPToken;

  /// No description provided for @liquidityRemoveFinalAmountTokenObtained.
  ///
  /// In en, this message translates to:
  /// **'Token obtained:'**
  String get liquidityRemoveFinalAmountTokenObtained;

  /// No description provided for @liquidityRemoveFinalAmountTokenBurned.
  ///
  /// In en, this message translates to:
  /// **'LP Token burned:'**
  String get liquidityRemoveFinalAmountTokenBurned;

  /// No description provided for @liquidityRemoveInProgressTxAddresses.
  ///
  /// In en, this message translates to:
  /// **'Liquidity suppression transaction address:'**
  String get liquidityRemoveInProgressTxAddresses;

  /// No description provided for @liquidityRemoveInProgressTxAddressesShort.
  ///
  /// In en, this message translates to:
  /// **'Liquidity supp. transaction address:'**
  String get liquidityRemoveInProgressTxAddressesShort;

  /// No description provided for @failureUserRejected.
  ///
  /// In en, this message translates to:
  /// **'The request has been declined.'**
  String get failureUserRejected;

  /// No description provided for @failureConnectivityArchethic.
  ///
  /// In en, this message translates to:
  /// **'Please, open your Archethic Wallet and allow DApps connection.'**
  String get failureConnectivityArchethic;

  /// No description provided for @failureConnectivityArchethicBrave.
  ///
  /// In en, this message translates to:
  /// **'Please, open your Archethic Wallet, allow DApps connection and disable Brave\'s shield.'**
  String get failureConnectivityArchethicBrave;

  /// No description provided for @failureInsufficientFunds.
  ///
  /// In en, this message translates to:
  /// **'Funds are not sufficient.'**
  String get failureInsufficientFunds;

  /// No description provided for @failureTimeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout occurred.'**
  String get failureTimeout;

  /// No description provided for @failurePoolAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Pool already exists for this pair'**
  String get failurePoolAlreadyExists;

  /// No description provided for @failurePoolNotExists.
  ///
  /// In en, this message translates to:
  /// **'No pool for this pair'**
  String get failurePoolNotExists;

  /// No description provided for @failureIncompatibleBrowser.
  ///
  /// In en, this message translates to:
  /// **'Sorry, but your browser is not compatible with the app.\n\nPlease refer to the FAQ for more information.\nhttps://wiki.archethic.net/FAQ/dex#what-web-browsers-are-not-supported'**
  String get failureIncompatibleBrowser;

  /// No description provided for @removeLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Remove liquidity'**
  String get removeLiquidity;

  /// No description provided for @btn_liquidity_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove liquidity'**
  String get btn_liquidity_remove;

  /// No description provided for @btn_confirm_liquidity_remove.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btn_confirm_liquidity_remove;

  /// No description provided for @liquidityRemoveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get liquidityRemoveConfirmTitle;

  /// No description provided for @liquidityRemoveFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove liquidity'**
  String get liquidityRemoveFormTitle;

  /// No description provided for @liquidityRemoveProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get liquidityRemoveProcessInterruptionWarning;

  /// No description provided for @liquidityRemoveSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'The liquidity has been removed successfully'**
  String get liquidityRemoveSuccessInfo;

  /// No description provided for @liquidityRemoveInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get liquidityRemoveInProgressConfirmAEWallet;

  /// No description provided for @liquidityRemoveProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get liquidityRemoveProcessInProgress;

  /// No description provided for @swapConfirmInfosAmountTokens.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swapConfirmInfosAmountTokens;

  /// No description provided for @swapConfirmInfosAmountMinReceived.
  ///
  /// In en, this message translates to:
  /// **'Mininum received'**
  String get swapConfirmInfosAmountMinReceived;

  /// No description provided for @swapConfirmInfosAmountMinFees.
  ///
  /// In en, this message translates to:
  /// **'Fees:'**
  String get swapConfirmInfosAmountMinFees;

  /// No description provided for @swapConfirmInfosFeesLP.
  ///
  /// In en, this message translates to:
  /// **'Liquidity Provider fees'**
  String get swapConfirmInfosFeesLP;

  /// No description provided for @swapConfirmInfosFeesProtocol.
  ///
  /// In en, this message translates to:
  /// **'Protocol fees'**
  String get swapConfirmInfosFeesProtocol;

  /// No description provided for @swapConfirmInfosMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'The UCO amount you entered has been reduced to include transaction fees.'**
  String get swapConfirmInfosMessageMaxHalfUCO;

  /// No description provided for @swapFinalAmountAmountSwapped.
  ///
  /// In en, this message translates to:
  /// **'Final amount swapped:'**
  String get swapFinalAmountAmountSwapped;

  /// No description provided for @swapProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get swapProcessInterruptionWarning;

  /// No description provided for @swapSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'The swap has been completed successfully'**
  String get swapSuccessInfo;

  /// No description provided for @swapInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get swapInProgressConfirmAEWallet;

  /// No description provided for @swapProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get swapProcessInProgress;

  /// No description provided for @swapMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'The swap process requires a maximum of %1 in transaction fees to be completed.'**
  String get swapMessageMaxHalfUCO;

  /// No description provided for @swapCreatePool.
  ///
  /// In en, this message translates to:
  /// **'Create this pool'**
  String get swapCreatePool;

  /// No description provided for @swapIconRefreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh information'**
  String get swapIconRefreshTooltip;

  /// No description provided for @swapIconSlippageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Set slippage tolerance information'**
  String get swapIconSlippageTooltip;

  /// No description provided for @swapInProgressTxAddresses.
  ///
  /// In en, this message translates to:
  /// **'Swap transaction address:'**
  String get swapInProgressTxAddresses;

  /// No description provided for @swapInfosFees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get swapInfosFees;

  /// No description provided for @swapInfosPriceImpact.
  ///
  /// In en, this message translates to:
  /// **'Price impact'**
  String get swapInfosPriceImpact;

  /// No description provided for @swapInfosMinimumReceived.
  ///
  /// In en, this message translates to:
  /// **'Minimum received'**
  String get swapInfosMinimumReceived;

  /// No description provided for @swapInfosTVL.
  ///
  /// In en, this message translates to:
  /// **'TVL'**
  String get swapInfosTVL;

  /// No description provided for @swapInfosRatio.
  ///
  /// In en, this message translates to:
  /// **'Ratio'**
  String get swapInfosRatio;

  /// No description provided for @swapInfosLiquidityProviderFees.
  ///
  /// In en, this message translates to:
  /// **'Liquidity Provider fees'**
  String get swapInfosLiquidityProviderFees;

  /// No description provided for @swapInfosProtocolFees.
  ///
  /// In en, this message translates to:
  /// **'Protocol fees'**
  String get swapInfosProtocolFees;

  /// No description provided for @swapSettingsSlippageErrorBetween0and100.
  ///
  /// In en, this message translates to:
  /// **'The slippage tolerance should be between 0 (no slippage) and 100%'**
  String get swapSettingsSlippageErrorBetween0and100;

  /// No description provided for @swapSettingsSlippageErrorHighSlippage.
  ///
  /// In en, this message translates to:
  /// **'Warning. Your transaction may be significantly impacted due to high slippage.'**
  String get swapSettingsSlippageErrorHighSlippage;

  /// No description provided for @poolAddControlToken1Empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the token 1'**
  String get poolAddControlToken1Empty;

  /// No description provided for @poolAddControlToken2Empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the token 2'**
  String get poolAddControlToken2Empty;

  /// No description provided for @poolAddControlToken1AmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for token 1 exceeds your balance.'**
  String get poolAddControlToken1AmountExceedBalance;

  /// No description provided for @poolAddControlToken2AmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for token 2 exceeds your balance.'**
  String get poolAddControlToken2AmountExceedBalance;

  /// No description provided for @poolAddControl2TokensAmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for the 2 tokens exceeds your balance.'**
  String get poolAddControl2TokensAmountExceedBalance;

  /// No description provided for @poolAddControlSameTokens.
  ///
  /// In en, this message translates to:
  /// **'You cannot create a pool with the same 2 tokens'**
  String get poolAddControlSameTokens;

  /// No description provided for @addPoolProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get addPoolProcessStep0;

  /// No description provided for @addPoolProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information to create the pool'**
  String get addPoolProcessStep1;

  /// No description provided for @addPoolProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information to pay pool creation fees'**
  String get addPoolProcessStep2;

  /// No description provided for @addPoolProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Creation of a LP token associated with the pool being created'**
  String get addPoolProcessStep3;

  /// No description provided for @addPoolProcessStep4.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information needed to create the pool and add liquidity to the pool'**
  String get addPoolProcessStep4;

  /// No description provided for @addPoolProcessStep5.
  ///
  /// In en, this message translates to:
  /// **'Creating the pool and adding liquidity'**
  String get addPoolProcessStep5;

  /// No description provided for @addPoolProcessStep6.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get addPoolProcessStep6;

  /// No description provided for @addLiquidityProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get addLiquidityProcessStep0;

  /// No description provided for @addLiquidityProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information to add liquidity to the pool'**
  String get addLiquidityProcessStep1;

  /// No description provided for @addLiquidityProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Adding liquidity'**
  String get addLiquidityProcessStep2;

  /// No description provided for @addLiquidityProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get addLiquidityProcessStep3;

  /// No description provided for @removeLiquidityProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get removeLiquidityProcessStep0;

  /// No description provided for @removeLiquidityProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information to remove liquidity from the pool'**
  String get removeLiquidityProcessStep1;

  /// No description provided for @removeLiquidityProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Removing liquidity'**
  String get removeLiquidityProcessStep2;

  /// No description provided for @removeLiquidityProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get removeLiquidityProcessStep3;

  /// No description provided for @liquidityAddControlToken1AmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount of token 1'**
  String get liquidityAddControlToken1AmountEmpty;

  /// No description provided for @liquidityAddControlToken2AmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount of token 2'**
  String get liquidityAddControlToken2AmountEmpty;

  /// No description provided for @liquidityAddControlToken1AmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for token 1 exceeds your balance.'**
  String get liquidityAddControlToken1AmountExceedBalance;

  /// No description provided for @liquidityAddControlToken2AmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for token 2 exceeds your balance.'**
  String get liquidityAddControlToken2AmountExceedBalance;

  /// No description provided for @liquidityRemoveControlLPTokenAmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount of lp token'**
  String get liquidityRemoveControlLPTokenAmountEmpty;

  /// No description provided for @lpTokenAmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for lp token exceeds your balance.'**
  String get lpTokenAmountExceedBalance;

  /// No description provided for @liquidityRemoveTokensGetBackHeader.
  ///
  /// In en, this message translates to:
  /// **'Amounts of token to get back when removing liquidity'**
  String get liquidityRemoveTokensGetBackHeader;

  /// No description provided for @swapControlTokenToSwapEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the token to swap'**
  String get swapControlTokenToSwapEmpty;

  /// No description provided for @swapControlTokenSwappedEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the token swapped'**
  String get swapControlTokenSwappedEmpty;

  /// No description provided for @swapControlTokenToSwapAmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for token to swap exceeds your balance.'**
  String get swapControlTokenToSwapAmountExceedBalance;

  /// No description provided for @poolCardPooled.
  ///
  /// In en, this message translates to:
  /// **'Deposited'**
  String get poolCardPooled;

  /// No description provided for @swapProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get swapProcessStep0;

  /// No description provided for @swapProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Calculating'**
  String get swapProcessStep1;

  /// No description provided for @swapProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information to swap'**
  String get swapProcessStep2;

  /// No description provided for @swapProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Swapping'**
  String get swapProcessStep3;

  /// No description provided for @swapProcessStep4.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get swapProcessStep4;

  /// No description provided for @feesLbl.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get feesLbl;

  /// No description provided for @swapFromLbl.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get swapFromLbl;

  /// No description provided for @swapToEstimatedLbl.
  ///
  /// In en, this message translates to:
  /// **'To (estimated)'**
  String get swapToEstimatedLbl;

  /// No description provided for @poolAddConfirmNewPoolLbl.
  ///
  /// In en, this message translates to:
  /// **'New pool'**
  String get poolAddConfirmNewPoolLbl;

  /// No description provided for @poolAddConfirmWithLiquidityLbl.
  ///
  /// In en, this message translates to:
  /// **'With liquidity'**
  String get poolAddConfirmWithLiquidityLbl;

  /// No description provided for @confirmBeforeLbl.
  ///
  /// In en, this message translates to:
  /// **'Before'**
  String get confirmBeforeLbl;

  /// No description provided for @confirmAfterLbl.
  ///
  /// In en, this message translates to:
  /// **'After'**
  String get confirmAfterLbl;

  /// No description provided for @poolCardPoolVerified.
  ///
  /// In en, this message translates to:
  /// **'Pool verified'**
  String get poolCardPoolVerified;

  /// No description provided for @localHistoryTooltipLinkPool.
  ///
  /// In en, this message translates to:
  /// **'View the pool information in the explorer'**
  String get localHistoryTooltipLinkPool;

  /// No description provided for @depositProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get depositProcessStep0;

  /// No description provided for @depositProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get depositProcessStep1;

  /// No description provided for @depositProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Deposit in progress'**
  String get depositProcessStep2;

  /// No description provided for @depositProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get depositProcessStep3;

  /// No description provided for @farmDepositControlAmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount'**
  String get farmDepositControlAmountEmpty;

  /// No description provided for @farmDepositControlAmountMin.
  ///
  /// In en, this message translates to:
  /// **'The amount should be >= 0.00000143 LP Token'**
  String get farmDepositControlAmountMin;

  /// No description provided for @farmDepositControlLPTokenAmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered exceeds your balance.'**
  String get farmDepositControlLPTokenAmountExceedBalance;

  /// No description provided for @farmDepositConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get farmDepositConfirmTitle;

  /// No description provided for @farmDepositFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get farmDepositFormTitle;

  /// No description provided for @farmDepositProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get farmDepositProcessInterruptionWarning;

  /// No description provided for @farmDepositSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Deposit has been done successfully'**
  String get farmDepositSuccessInfo;

  /// No description provided for @farmDepositInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get farmDepositInProgressConfirmAEWallet;

  /// No description provided for @farmDepositProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get farmDepositProcessInProgress;

  /// No description provided for @btn_farm_deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get btn_farm_deposit;

  /// No description provided for @btn_confirm_farm_deposit.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btn_confirm_farm_deposit;

  /// No description provided for @withdrawProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get withdrawProcessStep0;

  /// No description provided for @withdrawProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get withdrawProcessStep1;

  /// No description provided for @withdrawProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Withdraw in progress'**
  String get withdrawProcessStep2;

  /// No description provided for @withdrawProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get withdrawProcessStep3;

  /// No description provided for @farmWithdrawControlAmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount'**
  String get farmWithdrawControlAmountEmpty;

  /// No description provided for @farmWithdrawConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get farmWithdrawConfirmTitle;

  /// No description provided for @farmWithdrawFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get farmWithdrawFormTitle;

  /// No description provided for @farmWithdrawProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get farmWithdrawProcessInterruptionWarning;

  /// No description provided for @farmWithdrawSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Withdraw has been done successfully'**
  String get farmWithdrawSuccessInfo;

  /// No description provided for @farmWithdrawInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get farmWithdrawInProgressConfirmAEWallet;

  /// No description provided for @farmWithdrawProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get farmWithdrawProcessInProgress;

  /// No description provided for @farmWithdrawControlLPTokenAmountExceedDeposited.
  ///
  /// In en, this message translates to:
  /// **'The amount entered exceeds the deposited amount.'**
  String get farmWithdrawControlLPTokenAmountExceedDeposited;

  /// No description provided for @btn_farm_withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get btn_farm_withdraw;

  /// No description provided for @btn_confirm_farm_withdraw.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btn_confirm_farm_withdraw;

  /// No description provided for @claimProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get claimProcessStep0;

  /// No description provided for @claimProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get claimProcessStep1;

  /// No description provided for @claimProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Claim in progress'**
  String get claimProcessStep2;

  /// No description provided for @claimProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get claimProcessStep3;

  /// No description provided for @farmClaimConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get farmClaimConfirmTitle;

  /// No description provided for @farmClaimFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get farmClaimFormTitle;

  /// No description provided for @farmClaimProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get farmClaimProcessInterruptionWarning;

  /// No description provided for @farmClaimSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Claim has been done successfully'**
  String get farmClaimSuccessInfo;

  /// No description provided for @farmClaimInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get farmClaimInProgressConfirmAEWallet;

  /// No description provided for @farmClaimProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get farmClaimProcessInProgress;

  /// No description provided for @btn_farm_claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get btn_farm_claim;

  /// No description provided for @btn_confirm_farm_claim.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btn_confirm_farm_claim;

  /// No description provided for @farmDetailsInfoAddressesFarmAddress.
  ///
  /// In en, this message translates to:
  /// **'Farm address: '**
  String get farmDetailsInfoAddressesFarmAddress;

  /// No description provided for @farmDetailsInfoAddressesLPAddress.
  ///
  /// In en, this message translates to:
  /// **'LP Token address: '**
  String get farmDetailsInfoAddressesLPAddress;

  /// No description provided for @farmDetailsInfoAPR.
  ///
  /// In en, this message translates to:
  /// **'Current APR'**
  String get farmDetailsInfoAPR;

  /// No description provided for @farmDetailsInfoDistributedRewards.
  ///
  /// In en, this message translates to:
  /// **'Distributed rewards'**
  String get farmDetailsInfoDistributedRewards;

  /// No description provided for @farmDetailsInfoLPDeposited.
  ///
  /// In en, this message translates to:
  /// **'LP Token deposited'**
  String get farmDetailsInfoLPDeposited;

  /// No description provided for @lpToken.
  ///
  /// In en, this message translates to:
  /// **'LP Token'**
  String get lpToken;

  /// No description provided for @lpTokens.
  ///
  /// In en, this message translates to:
  /// **'LP Tokens'**
  String get lpTokens;

  /// No description provided for @lpTokenExpected.
  ///
  /// In en, this message translates to:
  /// **'LP Token expected'**
  String get lpTokenExpected;

  /// No description provided for @lpTokensExpected.
  ///
  /// In en, this message translates to:
  /// **'LP Tokens expected'**
  String get lpTokensExpected;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @legacy.
  ///
  /// In en, this message translates to:
  /// **'Legacy'**
  String get legacy;

  /// No description provided for @lvl.
  ///
  /// In en, this message translates to:
  /// **'Lvl'**
  String get lvl;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @farmDetailsInfoNbDeposit.
  ///
  /// In en, this message translates to:
  /// **'Holders'**
  String get farmDetailsInfoNbDeposit;

  /// No description provided for @farmDetailsInfoPeriodWillStart.
  ///
  /// In en, this message translates to:
  /// **'Farm will start at'**
  String get farmDetailsInfoPeriodWillStart;

  /// No description provided for @farmDetailsInfoPeriodStarted.
  ///
  /// In en, this message translates to:
  /// **'Farm started since'**
  String get farmDetailsInfoPeriodStarted;

  /// No description provided for @farmDetailsInfoPeriodEndAt.
  ///
  /// In en, this message translates to:
  /// **'Farm ends at'**
  String get farmDetailsInfoPeriodEndAt;

  /// No description provided for @farmDetailsInfoPeriodEnded.
  ///
  /// In en, this message translates to:
  /// **'Farm ended'**
  String get farmDetailsInfoPeriodEnded;

  /// No description provided for @farmDetailsInfoRemainingReward.
  ///
  /// In en, this message translates to:
  /// **'Remaining reward'**
  String get farmDetailsInfoRemainingReward;

  /// No description provided for @farmDetailsInfoTokenRewardEarn.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get farmDetailsInfoTokenRewardEarn;

  /// No description provided for @farmDetailsInfoYourAvailableLP.
  ///
  /// In en, this message translates to:
  /// **'Your available LP Tokens'**
  String get farmDetailsInfoYourAvailableLP;

  /// No description provided for @farmDetailsInfoYourDepositedAmount.
  ///
  /// In en, this message translates to:
  /// **'Your deposited amount'**
  String get farmDetailsInfoYourDepositedAmount;

  /// No description provided for @farmDetailsInfoYourRewardAmount.
  ///
  /// In en, this message translates to:
  /// **'Your reward amount'**
  String get farmDetailsInfoYourRewardAmount;

  /// No description provided for @farmDetailsButtonDepositFarmClosed.
  ///
  /// In en, this message translates to:
  /// **'Deposit LP Tokens (Farm closed)'**
  String get farmDetailsButtonDepositFarmClosed;

  /// No description provided for @farmDetailsButtonDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit LP Tokens'**
  String get farmDetailsButtonDeposit;

  /// No description provided for @farmDetailsButtonWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get farmDetailsButtonWithdraw;

  /// No description provided for @farmDetailsButtonClaim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get farmDetailsButtonClaim;

  /// No description provided for @farmCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Farming'**
  String get farmCardTitle;

  /// No description provided for @refreshIconToolTip.
  ///
  /// In en, this message translates to:
  /// **'Refresh information'**
  String get refreshIconToolTip;

  /// No description provided for @poolDetailsInfoSwapFees.
  ///
  /// In en, this message translates to:
  /// **'Swap fees'**
  String get poolDetailsInfoSwapFees;

  /// No description provided for @poolDetailsInfoProtocolFees.
  ///
  /// In en, this message translates to:
  /// **'Protocol fees'**
  String get poolDetailsInfoProtocolFees;

  /// No description provided for @poolDetailsInfoAddressesPoolAddress.
  ///
  /// In en, this message translates to:
  /// **'Pool address: '**
  String get poolDetailsInfoAddressesPoolAddress;

  /// No description provided for @poolDetailsInfoAddressesLPAddress.
  ///
  /// In en, this message translates to:
  /// **'LP Token address: '**
  String get poolDetailsInfoAddressesLPAddress;

  /// No description provided for @poolDetailsInfoAddressesToken1Address.
  ///
  /// In en, this message translates to:
  /// **'Token %1 address: '**
  String get poolDetailsInfoAddressesToken1Address;

  /// No description provided for @poolDetailsInfoAddressesToken2Address.
  ///
  /// In en, this message translates to:
  /// **'Token %1 address: '**
  String get poolDetailsInfoAddressesToken2Address;

  /// No description provided for @poolDetailsInfoDeposited.
  ///
  /// In en, this message translates to:
  /// **'Deposited'**
  String get poolDetailsInfoDeposited;

  /// No description provided for @poolDetailsInfoDepositedEquivalent.
  ///
  /// In en, this message translates to:
  /// **'Equivalent'**
  String get poolDetailsInfoDepositedEquivalent;

  /// No description provided for @poolDetailsInfoTVL.
  ///
  /// In en, this message translates to:
  /// **'TVL'**
  String get poolDetailsInfoTVL;

  /// No description provided for @poolDetailsInfoAPR.
  ///
  /// In en, this message translates to:
  /// **'APR'**
  String get poolDetailsInfoAPR;

  /// No description provided for @poolDetailsInfoAPRFarm3Years.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get poolDetailsInfoAPRFarm3Years;

  /// No description provided for @time24h.
  ///
  /// In en, this message translates to:
  /// **'24h'**
  String get time24h;

  /// No description provided for @time7d.
  ///
  /// In en, this message translates to:
  /// **'7d'**
  String get time7d;

  /// No description provided for @timeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get timeAll;

  /// No description provided for @poolDetailsInfoVolume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get poolDetailsInfoVolume;

  /// No description provided for @poolDetailsInfoFees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get poolDetailsInfoFees;

  /// No description provided for @poolDetailsInfoButtonAddLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Add Liquidity'**
  String get poolDetailsInfoButtonAddLiquidity;

  /// No description provided for @poolDetailsInfoButtonRemoveLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Remove Liquidity'**
  String get poolDetailsInfoButtonRemoveLiquidity;

  /// No description provided for @poolAddFavoriteIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add this pool in my favorites tab'**
  String get poolAddFavoriteIconTooltip;

  /// No description provided for @poolCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Pool'**
  String get poolCardTitle;

  /// No description provided for @poolListSearchBarHint.
  ///
  /// In en, this message translates to:
  /// **'Search by pool or token address or \"UCO\"'**
  String get poolListSearchBarHint;

  /// No description provided for @poolCreatePoolButton.
  ///
  /// In en, this message translates to:
  /// **'Create Pool'**
  String get poolCreatePoolButton;

  /// No description provided for @poolListTabVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get poolListTabVerified;

  /// No description provided for @poolListTabMyPools.
  ///
  /// In en, this message translates to:
  /// **'My pools'**
  String get poolListTabMyPools;

  /// No description provided for @poolListTabFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get poolListTabFavorites;

  /// No description provided for @poolListTabResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get poolListTabResults;

  /// No description provided for @poolRefreshIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh information'**
  String get poolRefreshIconTooltip;

  /// No description provided for @poolRemoveFavoriteIconConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Remove the pool from favorite tab?'**
  String get poolRemoveFavoriteIconConfirmation;

  /// No description provided for @poolRemoveFavoriteIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove the pool from favorite tab?'**
  String get poolRemoveFavoriteIconTooltip;

  /// No description provided for @poolListSearching.
  ///
  /// In en, this message translates to:
  /// **'Searching in progress. Please wait'**
  String get poolListSearching;

  /// No description provided for @poolListConnectWalletMyPools.
  ///
  /// In en, this message translates to:
  /// **'Please, connect your wallet to list your pools with position.'**
  String get poolListConnectWalletMyPools;

  /// No description provided for @poolListEnterSearchCriteria.
  ///
  /// In en, this message translates to:
  /// **'Please enter your search criteria.'**
  String get poolListEnterSearchCriteria;

  /// No description provided for @poolListNoResult.
  ///
  /// In en, this message translates to:
  /// **'No results found.'**
  String get poolListNoResult;

  /// No description provided for @poolListAddFavoriteText1.
  ///
  /// In en, this message translates to:
  /// **'To add your favorite pools to this tab, please click on the'**
  String get poolListAddFavoriteText1;

  /// No description provided for @poolListAddFavoriteText2.
  ///
  /// In en, this message translates to:
  /// **'icon in the pool cards header.'**
  String get poolListAddFavoriteText2;

  /// No description provided for @farmClaimConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the claim of '**
  String get farmClaimConfirmInfosText;

  /// No description provided for @farmClaimFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount claimed: '**
  String get farmClaimFinalAmount;

  /// No description provided for @finalAmountNotRecovered.
  ///
  /// In en, this message translates to:
  /// **'The amount could not be recovered'**
  String get finalAmountNotRecovered;

  /// No description provided for @finalAmountsNotRecovered.
  ///
  /// In en, this message translates to:
  /// **'The amounts could not be recovered'**
  String get finalAmountsNotRecovered;

  /// No description provided for @farmClaimFormText.
  ///
  /// In en, this message translates to:
  /// **'are available for claiming.'**
  String get farmClaimFormText;

  /// No description provided for @farmClaimTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Claim transaction address: '**
  String get farmClaimTxAddress;

  /// No description provided for @farmDepositConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the deposit of '**
  String get farmDepositConfirmInfosText;

  /// No description provided for @farmDepositConfirmYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get farmDepositConfirmYourBalance;

  /// No description provided for @farmDepositConfirmFarmBalance.
  ///
  /// In en, this message translates to:
  /// **'Farm\'s balance'**
  String get farmDepositConfirmFarmBalance;

  /// No description provided for @farmDepositFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount deposited: '**
  String get farmDepositFinalAmount;

  /// No description provided for @farmDepositTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Deposit transaction address: '**
  String get farmDepositTxAddress;

  /// No description provided for @farmWithdrawConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the withdraw of '**
  String get farmWithdrawConfirmInfosText;

  /// No description provided for @farmWithdrawConfirmYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get farmWithdrawConfirmYourBalance;

  /// No description provided for @farmWithdrawConfirmFarmBalance.
  ///
  /// In en, this message translates to:
  /// **'Farm\'s balance'**
  String get farmWithdrawConfirmFarmBalance;

  /// No description provided for @farmWithdrawConfirmRewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get farmWithdrawConfirmRewards;

  /// No description provided for @farmWithdrawConfirmYouWillReceive.
  ///
  /// In en, this message translates to:
  /// **'You will receive '**
  String get farmWithdrawConfirmYouWillReceive;

  /// No description provided for @farmWithdrawFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount withdrawn: '**
  String get farmWithdrawFinalAmount;

  /// No description provided for @farmWithdrawFinalAmountReward.
  ///
  /// In en, this message translates to:
  /// **'Amount rewarded: '**
  String get farmWithdrawFinalAmountReward;

  /// No description provided for @farmWithdrawFormText.
  ///
  /// In en, this message translates to:
  /// **'You can withdraw all or part of your deposited LP tokens. At the same time, this will claim your rewards.'**
  String get farmWithdrawFormText;

  /// No description provided for @farmWithdrawFormTextNoRewardText1.
  ///
  /// In en, this message translates to:
  /// **'No reward are available'**
  String get farmWithdrawFormTextNoRewardText1;

  /// No description provided for @farmWithdrawFormTextNoRewardText2.
  ///
  /// In en, this message translates to:
  /// **' are available for claiming.'**
  String get farmWithdrawFormTextNoRewardText2;

  /// No description provided for @farmWithdrawTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Withdraw transaction address: '**
  String get farmWithdrawTxAddress;

  /// No description provided for @runningTasksNotificationTasksInProgress.
  ///
  /// In en, this message translates to:
  /// **'tasks in progress'**
  String get runningTasksNotificationTasksInProgress;

  /// No description provided for @runningTasksNotificationTaskInProgress.
  ///
  /// In en, this message translates to:
  /// **'task in progress'**
  String get runningTasksNotificationTaskInProgress;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @headerDecentralizedExchange.
  ///
  /// In en, this message translates to:
  /// **'Decentralized Exchange'**
  String get headerDecentralizedExchange;

  /// No description provided for @tokenSelectionSingleTokenLPTooltip.
  ///
  /// In en, this message translates to:
  /// **'LP Token for pair'**
  String get tokenSelectionSingleTokenLPTooltip;

  /// No description provided for @priceImpact.
  ///
  /// In en, this message translates to:
  /// **'Price impact:'**
  String get priceImpact;

  /// No description provided for @priceImpactHighTooltip.
  ///
  /// In en, this message translates to:
  /// **'Warning, the price impact is high.'**
  String get priceImpactHighTooltip;

  /// No description provided for @liquidityPositionsIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'You have liquidity positions'**
  String get liquidityPositionsIconTooltip;

  /// No description provided for @liquidityFavoriteIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'Favorite pool'**
  String get liquidityFavoriteIconTooltip;

  /// No description provided for @verifiedPoolIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'This pool has been verified by Archethic'**
  String get verifiedPoolIconTooltip;

  /// No description provided for @verifiedTokenIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'This token has been verified by Archethic'**
  String get verifiedTokenIconTooltip;

  /// No description provided for @poolInfoCardTVL.
  ///
  /// In en, this message translates to:
  /// **'TVL:'**
  String get poolInfoCardTVL;

  /// No description provided for @apr24hTooltip.
  ///
  /// In en, this message translates to:
  /// **'Estimation of the annual yield based on the fees generated by swaps over the last 24 hours.\nIt provides an idea of the potential annual return based on recent performance.'**
  String get apr24hTooltip;

  /// No description provided for @btn_farmLockDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get btn_farmLockDeposit;

  /// No description provided for @farmLockDepositFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get farmLockDepositFormTitle;

  /// No description provided for @farmLockDepositFormAmountLbl.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get farmLockDepositFormAmountLbl;

  /// No description provided for @farmLockDepositDurationFlexible.
  ///
  /// In en, this message translates to:
  /// **'Flexible'**
  String get farmLockDepositDurationFlexible;

  /// No description provided for @farmLockDepositDurationOneMonth.
  ///
  /// In en, this message translates to:
  /// **'1 month'**
  String get farmLockDepositDurationOneMonth;

  /// No description provided for @farmLockDepositDurationOneWeek.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get farmLockDepositDurationOneWeek;

  /// No description provided for @farmLockDepositDurationOneYear.
  ///
  /// In en, this message translates to:
  /// **'1 year'**
  String get farmLockDepositDurationOneYear;

  /// No description provided for @farmLockDepositDurationSixMonths.
  ///
  /// In en, this message translates to:
  /// **'6 months'**
  String get farmLockDepositDurationSixMonths;

  /// No description provided for @farmLockDepositDurationThreeMonths.
  ///
  /// In en, this message translates to:
  /// **'3 months'**
  String get farmLockDepositDurationThreeMonths;

  /// No description provided for @farmLockDepositDurationThreeYears.
  ///
  /// In en, this message translates to:
  /// **'3 years'**
  String get farmLockDepositDurationThreeYears;

  /// No description provided for @farmLockDepositDurationTwoYears.
  ///
  /// In en, this message translates to:
  /// **'2 years'**
  String get farmLockDepositDurationTwoYears;

  /// No description provided for @farmLockDepositDurationMax.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get farmLockDepositDurationMax;

  /// No description provided for @farmLockDepositAPREstimationLbl.
  ///
  /// In en, this message translates to:
  /// **'Est. APR:'**
  String get farmLockDepositAPREstimationLbl;

  /// No description provided for @farmLockDepositAPRLbl.
  ///
  /// In en, this message translates to:
  /// **'APR:'**
  String get farmLockDepositAPRLbl;

  /// No description provided for @btn_confirm_farm_add_lock.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btn_confirm_farm_add_lock;

  /// No description provided for @farmLockDepositUnlockDateLbl.
  ///
  /// In en, this message translates to:
  /// **'Release date:'**
  String get farmLockDepositUnlockDateLbl;

  /// No description provided for @farmLockDepositConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get farmLockDepositConfirmTitle;

  /// No description provided for @farmLockDepositConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the lock of '**
  String get farmLockDepositConfirmInfosText;

  /// No description provided for @farmLockDepositConfirmYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get farmLockDepositConfirmYourBalance;

  /// No description provided for @farmLockDepositConfirmInfosText2.
  ///
  /// In en, this message translates to:
  /// **' for '**
  String get farmLockDepositConfirmInfosText2;

  /// No description provided for @farmLockDepositFormLockDurationLbl.
  ///
  /// In en, this message translates to:
  /// **'Choose the lock duration'**
  String get farmLockDepositFormLockDurationLbl;

  /// No description provided for @farmLockDepositConfirmInfosText3.
  ///
  /// In en, this message translates to:
  /// **'You can recover your LP Tokens and associated rewards at any time.'**
  String get farmLockDepositConfirmInfosText3;

  /// No description provided for @farmLockDepositConfirmCheckBoxUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand I can\'t get my tokens back before the release date.'**
  String get farmLockDepositConfirmCheckBoxUnderstand;

  /// No description provided for @farmLockDepositConfirmMoreInfo.
  ///
  /// In en, this message translates to:
  /// **'More info.'**
  String get farmLockDepositConfirmMoreInfo;

  /// No description provided for @depositFarmLockProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get depositFarmLockProcessStep0;

  /// No description provided for @depositFarmLockProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get depositFarmLockProcessStep1;

  /// No description provided for @depositFarmLockProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Deposit in progress'**
  String get depositFarmLockProcessStep2;

  /// No description provided for @depositFarmLockProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get depositFarmLockProcessStep3;

  /// No description provided for @farmLockDepositFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount deposited: '**
  String get farmLockDepositFinalAmount;

  /// No description provided for @farmLockDepositTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Deposit transaction address: '**
  String get farmLockDepositTxAddress;

  /// No description provided for @farmLockDepositInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get farmLockDepositInProgressConfirmAEWallet;

  /// No description provided for @farmLockDepositSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Deposit have been done successfully'**
  String get farmLockDepositSuccessInfo;

  /// No description provided for @depositFarmLockProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get depositFarmLockProcessInProgress;

  /// No description provided for @farmLockWithdrawConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the withdraw of '**
  String get farmLockWithdrawConfirmInfosText;

  /// No description provided for @farmLockWithdrawConfirmYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get farmLockWithdrawConfirmYourBalance;

  /// No description provided for @farmLockWithdrawConfirmFarmBalance.
  ///
  /// In en, this message translates to:
  /// **'Farm\'s balance'**
  String get farmLockWithdrawConfirmFarmBalance;

  /// No description provided for @farmLockWithdrawConfirmRewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get farmLockWithdrawConfirmRewards;

  /// No description provided for @farmLockWithdrawConfirmYouWillReceive.
  ///
  /// In en, this message translates to:
  /// **'You will receive '**
  String get farmLockWithdrawConfirmYouWillReceive;

  /// No description provided for @farmLockWithdrawFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount withdrawn: '**
  String get farmLockWithdrawFinalAmount;

  /// No description provided for @farmLockWithdrawFinalAmountReward.
  ///
  /// In en, this message translates to:
  /// **'Amount rewarded: '**
  String get farmLockWithdrawFinalAmountReward;

  /// No description provided for @farmLockWithdrawFormText.
  ///
  /// In en, this message translates to:
  /// **'You can withdraw all or part of your deposited LP tokens. At the same time, this will claim your rewards.'**
  String get farmLockWithdrawFormText;

  /// No description provided for @farmLockWithdrawFormTextNoRewardText1.
  ///
  /// In en, this message translates to:
  /// **'No reward are available'**
  String get farmLockWithdrawFormTextNoRewardText1;

  /// No description provided for @farmLockWithdrawFormTextNoRewardText2.
  ///
  /// In en, this message translates to:
  /// **' are available for claiming.'**
  String get farmLockWithdrawFormTextNoRewardText2;

  /// No description provided for @farmLockWithdrawTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Withdraw transaction address: '**
  String get farmLockWithdrawTxAddress;

  /// No description provided for @farmLockWithdrawControlAmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount'**
  String get farmLockWithdrawControlAmountEmpty;

  /// No description provided for @farmLockWithdrawConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get farmLockWithdrawConfirmTitle;

  /// No description provided for @farmLockWithdrawFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get farmLockWithdrawFormTitle;

  /// No description provided for @farmLockWithdrawProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get farmLockWithdrawProcessInterruptionWarning;

  /// No description provided for @farmLockWithdrawSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Withdraw has been done successfully'**
  String get farmLockWithdrawSuccessInfo;

  /// No description provided for @farmLockWithdrawInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get farmLockWithdrawInProgressConfirmAEWallet;

  /// No description provided for @farmLockWithdrawProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get farmLockWithdrawProcessInProgress;

  /// No description provided for @farmLockWithdrawControlLPTokenAmountExceedDeposited.
  ///
  /// In en, this message translates to:
  /// **'The amount entered exceeds the deposited amount.'**
  String get farmLockWithdrawControlLPTokenAmountExceedDeposited;

  /// No description provided for @withdrawFarmLockProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get withdrawFarmLockProcessStep0;

  /// No description provided for @withdrawFarmLockProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get withdrawFarmLockProcessStep1;

  /// No description provided for @withdrawFarmLockProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Withdraw in progress'**
  String get withdrawFarmLockProcessStep2;

  /// No description provided for @withdrawFarmLockProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get withdrawFarmLockProcessStep3;

  /// No description provided for @farmLockBlockAddLiquidityHeader.
  ///
  /// In en, this message translates to:
  /// **'1 - Add liquidity'**
  String get farmLockBlockAddLiquidityHeader;

  /// No description provided for @farmLockBlockAddLiquidityDesc.
  ///
  /// In en, this message translates to:
  /// **'Add liquidity to the pool and receive LP tokens representing your share.\nBy adding liquidity, you gain access to farming opportunities and can earn additional rewards.'**
  String get farmLockBlockAddLiquidityDesc;

  /// No description provided for @farmLockBlockAddLiquidityViewGuideArticle.
  ///
  /// In en, this message translates to:
  /// **'View the guide article'**
  String get farmLockBlockAddLiquidityViewGuideArticle;

  /// No description provided for @farmLockBlockAddLiquidityBtnAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get farmLockBlockAddLiquidityBtnAdd;

  /// No description provided for @farmLockBlockAddLiquidityBtnInfos.
  ///
  /// In en, this message translates to:
  /// **'Infos'**
  String get farmLockBlockAddLiquidityBtnInfos;

  /// No description provided for @farmLockBlockEarnRewardsBtnInfosFarmLegacy.
  ///
  /// In en, this message translates to:
  /// **'Infos Farm legacy'**
  String get farmLockBlockEarnRewardsBtnInfosFarmLegacy;

  /// No description provided for @farmLockBlockEarnRewardsBtnInfosFarmLock.
  ///
  /// In en, this message translates to:
  /// **'Infos Farm lock'**
  String get farmLockBlockEarnRewardsBtnInfosFarmLock;

  /// No description provided for @farmLockBlockAddLiquidityBtnWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get farmLockBlockAddLiquidityBtnWithdraw;

  /// No description provided for @farmLockBlockEarnRewardsHeader.
  ///
  /// In en, this message translates to:
  /// **'2 - Earn more'**
  String get farmLockBlockEarnRewardsHeader;

  /// No description provided for @farmLockBlockEarnRewardsDesc.
  ///
  /// In en, this message translates to:
  /// **'Farm your LP Tokens to earn rewards. By locking them for a specified period, you increase your rewards.\nThe longer you lock, the greater your rewards.'**
  String get farmLockBlockEarnRewardsDesc;

  /// No description provided for @farmLockBlockEarnRewardsWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning: Rewards are recalculated every hour.'**
  String get farmLockBlockEarnRewardsWarning;

  /// No description provided for @farmLockBlockEarnRewardsStartFarm.
  ///
  /// In en, this message translates to:
  /// **'Info: Rewards emission will start on'**
  String get farmLockBlockEarnRewardsStartFarm;

  /// No description provided for @farmLockBlockEarnRewardsBtnAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get farmLockBlockEarnRewardsBtnAdd;

  /// No description provided for @farmLockBlockEarnRewardsBtnNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Farm not available'**
  String get farmLockBlockEarnRewardsBtnNotAvailable;

  /// No description provided for @farmLockBlockEarnRewardsViewGuideArticle.
  ///
  /// In en, this message translates to:
  /// **'View the guide article'**
  String get farmLockBlockEarnRewardsViewGuideArticle;

  /// No description provided for @farmLockBlockAprLbl.
  ///
  /// In en, this message translates to:
  /// **'APR 3 years'**
  String get farmLockBlockAprLbl;

  /// No description provided for @farmLockBlockFarmedTokensSummaryHeader.
  ///
  /// In en, this message translates to:
  /// **'Farmed Tokens Summary'**
  String get farmLockBlockFarmedTokensSummaryHeader;

  /// No description provided for @farmLockBlockBalanceSummaryHeader.
  ///
  /// In en, this message translates to:
  /// **'Your Balances Summary'**
  String get farmLockBlockBalanceSummaryHeader;

  /// No description provided for @farmLockBlockFarmedTokensSummaryCapitalInvestedLbl.
  ///
  /// In en, this message translates to:
  /// **'Capital Invested'**
  String get farmLockBlockFarmedTokensSummaryCapitalInvestedLbl;

  /// No description provided for @farmLockBlockFarmedTokensSummaryCapitalRewardsEarnedLbl.
  ///
  /// In en, this message translates to:
  /// **'Rewards Earned'**
  String get farmLockBlockFarmedTokensSummaryCapitalRewardsEarnedLbl;

  /// No description provided for @farmLockBlockListHeaderAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get farmLockBlockListHeaderAmount;

  /// No description provided for @farmLockBlockListHeaderRewards.
  ///
  /// In en, this message translates to:
  /// **'Estimated rewards'**
  String get farmLockBlockListHeaderRewards;

  /// No description provided for @farmLockBlockListHeaderUnlocksIn.
  ///
  /// In en, this message translates to:
  /// **'Unlocks in'**
  String get farmLockBlockListHeaderUnlocksIn;

  /// No description provided for @farmLockBlockListHeaderUnlocks.
  ///
  /// In en, this message translates to:
  /// **'Unlocks'**
  String get farmLockBlockListHeaderUnlocks;

  /// No description provided for @farmLockBlockListHeaderLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get farmLockBlockListHeaderLevel;

  /// No description provided for @farmLockBlockListHeaderAPR.
  ///
  /// In en, this message translates to:
  /// **'APR'**
  String get farmLockBlockListHeaderAPR;

  /// No description provided for @farmLockBlockListHeaderActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get farmLockBlockListHeaderActions;

  /// No description provided for @farmLockBtnLevelUp.
  ///
  /// In en, this message translates to:
  /// **'Level Up!'**
  String get farmLockBtnLevelUp;

  /// No description provided for @farmLockBtnWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get farmLockBtnWithdraw;

  /// No description provided for @levelUpFarmLockProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get levelUpFarmLockProcessStep0;

  /// No description provided for @levelUpFarmLockProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get levelUpFarmLockProcessStep1;

  /// No description provided for @levelUpFarmLockProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Level up in progress'**
  String get levelUpFarmLockProcessStep2;

  /// No description provided for @levelUpFarmLockProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get levelUpFarmLockProcessStep3;

  /// No description provided for @btn_farmLockLevelUp.
  ///
  /// In en, this message translates to:
  /// **'Level Up'**
  String get btn_farmLockLevelUp;

  /// No description provided for @farmLockLevelUpFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Level Up'**
  String get farmLockLevelUpFormTitle;

  /// No description provided for @farmLockLevelUpFormAmountLbl.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get farmLockLevelUpFormAmountLbl;

  /// No description provided for @farmLockLevelUpAPREstimationLbl.
  ///
  /// In en, this message translates to:
  /// **'Est. APR:'**
  String get farmLockLevelUpAPREstimationLbl;

  /// No description provided for @farmLockLevelUpAPRLbl.
  ///
  /// In en, this message translates to:
  /// **'APR:'**
  String get farmLockLevelUpAPRLbl;

  /// No description provided for @farmLockLevelUpUnlockDateLbl.
  ///
  /// In en, this message translates to:
  /// **'Release date:'**
  String get farmLockLevelUpUnlockDateLbl;

  /// No description provided for @farmLockLevelUpCurrentLvlLbl.
  ///
  /// In en, this message translates to:
  /// **'Current level:'**
  String get farmLockLevelUpCurrentLvlLbl;

  /// No description provided for @farmLockLevelUpConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get farmLockLevelUpConfirmTitle;

  /// No description provided for @farmLockLevelUpConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the lock of '**
  String get farmLockLevelUpConfirmInfosText;

  /// No description provided for @farmLockLevelUpConfirmYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get farmLockLevelUpConfirmYourBalance;

  /// No description provided for @farmLockLevelUpConfirmInfosText2.
  ///
  /// In en, this message translates to:
  /// **' for '**
  String get farmLockLevelUpConfirmInfosText2;

  /// No description provided for @farmLockLevelUpFormLockDurationLbl.
  ///
  /// In en, this message translates to:
  /// **'Choose the lock duration'**
  String get farmLockLevelUpFormLockDurationLbl;

  /// No description provided for @farmLockLevelUpConfirmInfosText3.
  ///
  /// In en, this message translates to:
  /// **'You can recover your LP Tokens and associated rewards at any time.'**
  String get farmLockLevelUpConfirmInfosText3;

  /// No description provided for @farmLockLevelUpFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount: '**
  String get farmLockLevelUpFinalAmount;

  /// No description provided for @farmLockLevelUpTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Level Up transaction address: '**
  String get farmLockLevelUpTxAddress;

  /// No description provided for @farmLockLevelUpInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get farmLockLevelUpInProgressConfirmAEWallet;

  /// No description provided for @farmLockLevelUpSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Deposit have been done successfully'**
  String get farmLockLevelUpSuccessInfo;

  /// No description provided for @farmLockLevelUpDesc.
  ///
  /// In en, this message translates to:
  /// **'You can extend the duration of your lock to earn more rewards.\nTo do this, you must choose a longer period than before, which will provide you with a higher level. The higher your level, the higher the APR.\nAt the same time, this will claim your actual rewards.'**
  String get farmLockLevelUpDesc;

  /// No description provided for @farmLockLevelUpConfirmCheckBoxUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand I can\'t get my tokens back before the release date.'**
  String get farmLockLevelUpConfirmCheckBoxUnderstand;

  /// No description provided for @farmLockLevelUpConfirmMoreInfo.
  ///
  /// In en, this message translates to:
  /// **'More info.'**
  String get farmLockLevelUpConfirmMoreInfo;

  /// No description provided for @addLiquiditySignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the amount of each token in the pool pair to the pool address and calls the smart contract\'s add liquidity function with the minimum amount for each token.'**
  String get addLiquiditySignTxDesc_en;

  /// No description provided for @addPoolSignTxDesc1_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends fees to the pool address to pay for the execution of the pool creation.'**
  String get addPoolSignTxDesc1_en;

  /// No description provided for @addPoolSignTxDesc2_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the amount of each token in the pool pair to the pool address, calls the smart contract\'s add pool function with the pair addresses and the new pool address, and then calls the smart contract\'s add liquidity function with the minimum amount for each token.'**
  String get addPoolSignTxDesc2_en;

  /// No description provided for @claimFarmSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction calls the smart contract\'s claim function to execute the claim.'**
  String get claimFarmSignTxDesc_en;

  /// No description provided for @depositFarmLockSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the LP tokens to be locked into the farm and calls the smart contract\'s deposit function with the tokens\' release date.'**
  String get depositFarmLockSignTxDesc_en;

  /// No description provided for @depositFarmSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the amount of LP tokens to the farm address and calls the smart contract\'s deposit function to execute the deposit.'**
  String get depositFarmSignTxDesc_en;

  /// No description provided for @levelUpFarmLockSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the LP tokens to be relocked into the farm by calling the smart contract\'s relock function with the tokens\' new release date and the associated index of the deposit.'**
  String get levelUpFarmLockSignTxDesc_en;

  /// No description provided for @removeLiquiditySignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction burns the amount of LP Token who wish to withdraw from the pool and calls the smart contract\'s remove liquidity function to obtain the equivalent tokens.'**
  String get removeLiquiditySignTxDesc_en;

  /// No description provided for @swapSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the amount of the token you want to swap to the pool address, calls the smart contract\'s swap function, and obtains the equivalent token, considering the slippage tolerance.'**
  String get swapSignTxDesc_en;

  /// No description provided for @withdrawFarmLockSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction calls the smart contract\'s withdraw function with the amount of LP tokens and the associated index of the deposit to execute the withdrawal and claim the associated rewards.'**
  String get withdrawFarmLockSignTxDesc_en;

  /// No description provided for @withdrawFarmSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction calls the smart contract\'s withdraw function with the amount of LP tokens to execute the withdrawal and claim the associated rewards.'**
  String get withdrawFarmSignTxDesc_en;

  /// No description provided for @addLiquiditySignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie le montant de chaque jeton de la paire de la pool à l\'adresse de la pool et appelle la fonction d\'ajout de liquidité du contrat intelligent avec le montant minimum pour chaque jeton.'**
  String get addLiquiditySignTxDesc_fr;

  /// No description provided for @addPoolSignTxDesc1_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie les frais à l\'adresse de la pool pour payer l\'exécution de la création de la pool.'**
  String get addPoolSignTxDesc1_fr;

  /// No description provided for @addPoolSignTxDesc2_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie le montant de chaque jeton de la paire de la pool à l\'adresse de la pool, appelle la fonction d\'ajout de pool du contrat intelligent avec les adresses de la paire et la nouvelle adresse de la pool, puis appelle la fonction d\'ajout de liquidité du contrat intelligent avec le montant minimum pour chaque jeton.'**
  String get addPoolSignTxDesc2_fr;

  /// No description provided for @claimFarmSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction appelle la fonction de récupération des récompenses du contrat intelligent pour exécuter la récupération.'**
  String get claimFarmSignTxDesc_fr;

  /// No description provided for @depositFarmLockSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie les jetons LP à verrouiller dans la farm et appelle la fonction de dépôt du contrat intelligent avec la date de libération des jetons.'**
  String get depositFarmLockSignTxDesc_fr;

  /// No description provided for @depositFarmSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie le montant de jetons LP à l\'adresse de la farm et appelle la fonction de dépôt du contrat intelligent pour exécuter le dépôt.'**
  String get depositFarmSignTxDesc_fr;

  /// No description provided for @levelUpFarmLockSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie les jetons LP à reverrouiller dans la farm en appelant la fonction de reverrouillage du contrat intelligent avec la nouvelle date de libération des jetons et l\'index associé du dépôt.'**
  String get levelUpFarmLockSignTxDesc_fr;

  /// No description provided for @removeLiquiditySignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction brûle le montant de jetons LP que vous souhaitez retirer de la pool et appelle la fonction de retrait de liquidité du contrat intelligent pour obtenir les jetons équivalents.'**
  String get removeLiquiditySignTxDesc_fr;

  /// No description provided for @swapSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie le montant du jeton que vous souhaitez échanger à l\'adresse de la pool, appelle la fonction d\'échange du contrat intelligent et obtient les jetons équivalents, en tenant compte du slippage.'**
  String get swapSignTxDesc_fr;

  /// No description provided for @withdrawFarmLockSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction appelle la fonction de retrait du contrat intelligent avec le montant de jetons LP et l\'index associé du dépôt pour exécuter le retrait et réclamer les récompenses associées.'**
  String get withdrawFarmLockSignTxDesc_fr;

  /// No description provided for @withdrawFarmSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction appelle la fonction de retrait du contrat intelligent avec le montant de jetons LP pour exécuter le retrait et réclamer les récompenses associées.'**
  String get withdrawFarmSignTxDesc_fr;

  /// No description provided for @poolFarmingAvailable.
  ///
  /// In en, this message translates to:
  /// **'Farming available'**
  String get poolFarmingAvailable;

  /// No description provided for @poolFarming.
  ///
  /// In en, this message translates to:
  /// **'Farming'**
  String get poolFarming;

  /// No description provided for @claimFarmLockSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction calls the smart contract\'s claim function to execute the claim.'**
  String get claimFarmLockSignTxDesc_en;

  /// No description provided for @claimFarmLockSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction appelle la fonction de récupération des récompenses du contrat intelligent pour exécuter la récupération.'**
  String get claimFarmLockSignTxDesc_fr;

  /// No description provided for @farmLockClaimConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the claim of '**
  String get farmLockClaimConfirmInfosText;

  /// No description provided for @farmLockClaimFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount claimed: '**
  String get farmLockClaimFinalAmount;

  /// No description provided for @farmLockClaimFormText.
  ///
  /// In en, this message translates to:
  /// **'are available for claiming.'**
  String get farmLockClaimFormText;

  /// No description provided for @farmLockClaimTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Claim transaction address: '**
  String get farmLockClaimTxAddress;

  /// No description provided for @farmLockClaimConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get farmLockClaimConfirmTitle;

  /// No description provided for @farmLockClaimFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get farmLockClaimFormTitle;

  /// No description provided for @farmLockClaimProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get farmLockClaimProcessInterruptionWarning;

  /// No description provided for @farmLockClaimSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Claim has been done successfully'**
  String get farmLockClaimSuccessInfo;

  /// No description provided for @farmLockClaimInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get farmLockClaimInProgressConfirmAEWallet;

  /// No description provided for @farmLockClaimProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get farmLockClaimProcessInProgress;

  /// No description provided for @btn_farm_lock_claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get btn_farm_lock_claim;

  /// No description provided for @btn_confirm_farm_lock_claim.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btn_confirm_farm_lock_claim;

  /// No description provided for @claimLockProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get claimLockProcessStep0;

  /// No description provided for @claimLockProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get claimLockProcessStep1;

  /// No description provided for @claimLockProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Claim in progress'**
  String get claimLockProcessStep2;

  /// No description provided for @claimLockProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get claimLockProcessStep3;

  /// No description provided for @farmLockBtnClaim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get farmLockBtnClaim;

  /// No description provided for @farmLockDetailsLevelSingleRewardsAllocated.
  ///
  /// In en, this message translates to:
  /// **'Rewards allocated per period'**
  String get farmLockDetailsLevelSingleRewardsAllocated;

  /// No description provided for @farmLockDetailsLevelSingleWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get farmLockDetailsLevelSingleWeight;

  /// No description provided for @poolTxTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get poolTxTypeUnknown;

  /// No description provided for @poolTxAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get poolTxAccount;

  /// No description provided for @poolTxTotalValue.
  ///
  /// In en, this message translates to:
  /// **'Total value:'**
  String get poolTxTotalValue;

  /// No description provided for @errorDesc1.
  ///
  /// In en, this message translates to:
  /// **'aeSwap'**
  String get errorDesc1;

  /// No description provided for @errorDesc2.
  ///
  /// In en, this message translates to:
  /// **'Oops! Page not found.'**
  String get errorDesc2;

  /// No description provided for @errorDesc3.
  ///
  /// In en, this message translates to:
  /// **'Return to Homepage'**
  String get errorDesc3;

  /// No description provided for @mobileInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Mobile Compatibility'**
  String get mobileInfoTitle;

  /// No description provided for @mobileInfoTxt1.
  ///
  /// In en, this message translates to:
  /// **'We have detected that you are using a mobile device. Currently, our application is not optimized for mobile devices.\nFor the best experience, we recommend the following options:'**
  String get mobileInfoTxt1;

  /// No description provided for @mobileInfoTxt2.
  ///
  /// In en, this message translates to:
  /// **'1. Use our application on a desktop computer.'**
  String get mobileInfoTxt2;

  /// No description provided for @mobileInfoTxt3.
  ///
  /// In en, this message translates to:
  /// **'2. Use our application within your Archethic wallet on iOS, DApps tab.'**
  String get mobileInfoTxt3;

  /// No description provided for @mobileInfoTxt4.
  ///
  /// In en, this message translates to:
  /// **'Please note that updates for mobile compatibility are coming soon.'**
  String get mobileInfoTxt4;

  /// No description provided for @mobileInfoTxt5.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your understanding.'**
  String get mobileInfoTxt5;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
