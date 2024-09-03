import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations-aeswap_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/localizations-aeswap.dart';
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

  /// No description provided for @aeswap_btn_understand.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get aeswap_btn_understand;

  /// No description provided for @aeswap_btn_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get aeswap_btn_save;

  /// No description provided for @aeswap_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get aeswap_yes;

  /// No description provided for @aeswap_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get aeswap_no;

  /// No description provided for @aeswap_ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get aeswap_ok;

  /// No description provided for @aeswap_settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get aeswap_settingsTitle;

  /// No description provided for @aeswap_connectionWalletDisconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect wallet'**
  String get aeswap_connectionWalletDisconnect;

  /// No description provided for @aeswap_go.
  ///
  /// In en, this message translates to:
  /// **'Go !'**
  String get aeswap_go;

  /// No description provided for @aeswap_btn_connect_wallet.
  ///
  /// In en, this message translates to:
  /// **'Connect wallet'**
  String get aeswap_btn_connect_wallet;

  /// No description provided for @aeswap_confirmationPopupTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Request'**
  String get aeswap_confirmationPopupTitle;

  /// No description provided for @aeswap_connectionWalletDisconnectWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to disconnect your wallet and exit the application?'**
  String get aeswap_connectionWalletDisconnectWarning;

  /// No description provided for @aeswap_changeCurrentAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning, your current account has been updated.'**
  String get aeswap_changeCurrentAccountWarning;

  /// No description provided for @aeswap_welcomeNoWallet.
  ///
  /// In en, this message translates to:
  /// **'Unlock the full potential of our Web3 application - get the Archethic Wallet now!'**
  String get aeswap_welcomeNoWallet;

  /// No description provided for @aeswap_menu_swap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get aeswap_menu_swap;

  /// No description provided for @aeswap_menu_liquidity.
  ///
  /// In en, this message translates to:
  /// **'Pools'**
  String get aeswap_menu_liquidity;

  /// No description provided for @aeswap_menu_earn.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get aeswap_menu_earn;

  /// No description provided for @aeswap_menu_bridge.
  ///
  /// In en, this message translates to:
  /// **'Bridge'**
  String get aeswap_menu_bridge;

  /// No description provided for @aeswap_menu_get_wallet.
  ///
  /// In en, this message translates to:
  /// **'Get Wallet'**
  String get aeswap_menu_get_wallet;

  /// No description provided for @aeswap_menu_documentation.
  ///
  /// In en, this message translates to:
  /// **'Documentation'**
  String get aeswap_menu_documentation;

  /// No description provided for @aeswap_menu_sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source code'**
  String get aeswap_menu_sourceCode;

  /// No description provided for @aeswap_menu_faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get aeswap_menu_faq;

  /// No description provided for @aeswap_menu_tuto.
  ///
  /// In en, this message translates to:
  /// **'Tutorials'**
  String get aeswap_menu_tuto;

  /// No description provided for @aeswap_menu_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get aeswap_menu_privacy_policy;

  /// No description provided for @aeswap_menu_terms_of_use.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get aeswap_menu_terms_of_use;

  /// No description provided for @aeswap_menu_report_bug.
  ///
  /// In en, this message translates to:
  /// **'Report a bug'**
  String get aeswap_menu_report_bug;

  /// No description provided for @aeswap_btn_selectToken.
  ///
  /// In en, this message translates to:
  /// **'Select a token'**
  String get aeswap_btn_selectToken;

  /// No description provided for @aeswap_btn_swap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get aeswap_btn_swap;

  /// No description provided for @aeswap_btn_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get aeswap_btn_close;

  /// No description provided for @aeswap_btn_confirm_swap.
  ///
  /// In en, this message translates to:
  /// **'Confirm swap'**
  String get aeswap_btn_confirm_swap;

  /// No description provided for @aeswap_token_selection_search_bar_hint.
  ///
  /// In en, this message translates to:
  /// **'Search symbol or from token address'**
  String get aeswap_token_selection_search_bar_hint;

  /// No description provided for @aeswap_token_selection_common_bases_title.
  ///
  /// In en, this message translates to:
  /// **'Common bases'**
  String get aeswap_token_selection_common_bases_title;

  /// No description provided for @aeswap_token_selection_your_tokens_title.
  ///
  /// In en, this message translates to:
  /// **'Your tokens'**
  String get aeswap_token_selection_your_tokens_title;

  /// No description provided for @aeswap_token_selection_get_tokens_from_wallet.
  ///
  /// In en, this message translates to:
  /// **'Retrieving tokens from your current account in your wallet...'**
  String get aeswap_token_selection_get_tokens_from_wallet;

  /// No description provided for @aeswap_slippage_tolerance.
  ///
  /// In en, this message translates to:
  /// **'Slippage tolerance'**
  String get aeswap_slippage_tolerance;

  /// No description provided for @aeswap_archethicDashboardMenuBridgeItem.
  ///
  /// In en, this message translates to:
  /// **'Bridge'**
  String get aeswap_archethicDashboardMenuBridgeItem;

  /// No description provided for @aeswap_archethicDashboardMenuBridgeDesc.
  ///
  /// In en, this message translates to:
  /// **'The portal allowing seamless assets deposits & withdrawals'**
  String get aeswap_archethicDashboardMenuBridgeDesc;

  /// No description provided for @aeswap_archethicDashboardMenuWalletOnWayItem.
  ///
  /// In en, this message translates to:
  /// **'Archethic Wallet'**
  String get aeswap_archethicDashboardMenuWalletOnWayItem;

  /// No description provided for @aeswap_archethicDashboardMenuWalletOnWayDesc.
  ///
  /// In en, this message translates to:
  /// **'Securely store, transfer and swap tokens and collectibles'**
  String get aeswap_archethicDashboardMenuWalletOnWayDesc;

  /// No description provided for @aeswap_archethicDashboardMenuFaucetItem.
  ///
  /// In en, this message translates to:
  /// **'Faucet'**
  String get aeswap_archethicDashboardMenuFaucetItem;

  /// No description provided for @aeswap_archethicDashboardMenuFaucetDesc.
  ///
  /// In en, this message translates to:
  /// **'Get Free Testnet UCO Here'**
  String get aeswap_archethicDashboardMenuFaucetDesc;

  /// No description provided for @aeswap_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get aeswap_logout;

  /// No description provided for @aeswap_addressCopied.
  ///
  /// In en, this message translates to:
  /// **'Address copied'**
  String get aeswap_addressCopied;

  /// No description provided for @aeswap_addPool.
  ///
  /// In en, this message translates to:
  /// **'Add a pool'**
  String get aeswap_addPool;

  /// No description provided for @aeswap_btn_pool_add.
  ///
  /// In en, this message translates to:
  /// **'Create a new pool'**
  String get aeswap_btn_pool_add;

  /// No description provided for @aeswap_btn_confirm_pool_add.
  ///
  /// In en, this message translates to:
  /// **'Confirm the creation'**
  String get aeswap_btn_confirm_pool_add;

  /// No description provided for @aeswap_poolAddConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get aeswap_poolAddConfirmTitle;

  /// No description provided for @aeswap_poolAddFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new pool'**
  String get aeswap_poolAddFormTitle;

  /// No description provided for @aeswap_poolAddProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the creation process?'**
  String get aeswap_poolAddProcessInterruptionWarning;

  /// No description provided for @aeswap_poolAddSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'The pool has been created successfully'**
  String get aeswap_poolAddSuccessInfo;

  /// No description provided for @aeswap_poolAddInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_poolAddInProgressConfirmAEWallet;

  /// No description provided for @aeswap_poolAddProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get aeswap_poolAddProcessInProgress;

  /// No description provided for @aeswap_poolAddConfirmMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'The UCO amount you entered has been reduced by \$0.5 to include transaction fees.'**
  String get aeswap_poolAddConfirmMessageMaxHalfUCO;

  /// No description provided for @aeswap_poolAddAddMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'This process requires a maximum of \$0.5 in transaction fees to be completed.'**
  String get aeswap_poolAddAddMessageMaxHalfUCO;

  /// No description provided for @aeswap_poolAddInProgressTxAddressesPoolGenesisAddress.
  ///
  /// In en, this message translates to:
  /// **'Pool genesis address:'**
  String get aeswap_poolAddInProgressTxAddressesPoolGenesisAddress;

  /// No description provided for @aeswap_poolAddInProgressTxAddressesPoolRegistrationAddress.
  ///
  /// In en, this message translates to:
  /// **'Pool registration transaction address:'**
  String get aeswap_poolAddInProgressTxAddressesPoolRegistrationAddress;

  /// No description provided for @aeswap_poolAddInProgressTxAddressesPoolFundsAddress.
  ///
  /// In en, this message translates to:
  /// **'Pool funds transfer transaction address:'**
  String get aeswap_poolAddInProgressTxAddressesPoolFundsAddress;

  /// No description provided for @aeswap_poolAddInProgressTxAddressesPoolAdditionAddress.
  ///
  /// In en, this message translates to:
  /// **'Liquidity addition transaction address:'**
  String get aeswap_poolAddInProgressTxAddressesPoolAdditionAddress;

  /// No description provided for @aeswap_addLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Add liquidity'**
  String get aeswap_addLiquidity;

  /// No description provided for @aeswap_btn_liquidity_add.
  ///
  /// In en, this message translates to:
  /// **'Add liquidity'**
  String get aeswap_btn_liquidity_add;

  /// No description provided for @aeswap_btn_confirm_liquidity_add.
  ///
  /// In en, this message translates to:
  /// **'Confirm the addition'**
  String get aeswap_btn_confirm_liquidity_add;

  /// No description provided for @aeswap_liquidityAddConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get aeswap_liquidityAddConfirmTitle;

  /// No description provided for @aeswap_liquidityAddFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Add liquidity'**
  String get aeswap_liquidityAddFormTitle;

  /// No description provided for @aeswap_liquidityAddProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get aeswap_liquidityAddProcessInterruptionWarning;

  /// No description provided for @aeswap_liquidityAddSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Liquidity has been added successfully'**
  String get aeswap_liquidityAddSuccessInfo;

  /// No description provided for @aeswap_liquidityAddInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_liquidityAddInProgressConfirmAEWallet;

  /// No description provided for @aeswap_liquidityAddProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get aeswap_liquidityAddProcessInProgress;

  /// No description provided for @aeswap_liquidityAddConfirmInfosAmountTokens.
  ///
  /// In en, this message translates to:
  /// **'Add liquidity in the pool'**
  String get aeswap_liquidityAddConfirmInfosAmountTokens;

  /// No description provided for @aeswap_liquidityAddConfirmInfosMinAmount.
  ///
  /// In en, this message translates to:
  /// **'Mininum amount'**
  String get aeswap_liquidityAddConfirmInfosMinAmount;

  /// No description provided for @aeswap_liquidityAddConfirmMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'The UCO amount you entered has been reduced to include transaction fees.'**
  String get aeswap_liquidityAddConfirmMessageMaxHalfUCO;

  /// No description provided for @aeswap_liquidityAddMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'This process requires a maximum of %1 UCO in transaction fees to be completed.'**
  String get aeswap_liquidityAddMessageMaxHalfUCO;

  /// No description provided for @aeswap_liquidityAddFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'LP Tokens obtained: '**
  String get aeswap_liquidityAddFinalAmount;

  /// No description provided for @aeswap_liquidityAddTooltipSlippage.
  ///
  /// In en, this message translates to:
  /// **'Set slippage tolerance information'**
  String get aeswap_liquidityAddTooltipSlippage;

  /// No description provided for @aeswap_liquidityAddInProgresstxAddresses.
  ///
  /// In en, this message translates to:
  /// **'Liquidity addition transaction address:'**
  String get aeswap_liquidityAddInProgresstxAddresses;

  /// No description provided for @aeswap_liquidityAddInProgresstxAddressesShort.
  ///
  /// In en, this message translates to:
  /// **'Liquidity add. transaction address:'**
  String get aeswap_liquidityAddInProgresstxAddressesShort;

  /// No description provided for @aeswap_liquidityAddInfosMinimumAmount.
  ///
  /// In en, this message translates to:
  /// **'Mininum amount for'**
  String get aeswap_liquidityAddInfosMinimumAmount;

  /// No description provided for @aeswap_liquidityAddInfosExpectedToken.
  ///
  /// In en, this message translates to:
  /// **'Expected LP Token'**
  String get aeswap_liquidityAddInfosExpectedToken;

  /// No description provided for @aeswap_liquidityAddSettingsSlippageErrorBetween0and100.
  ///
  /// In en, this message translates to:
  /// **'The slippage tolerance should be between 0 (no slippage) and 100%'**
  String get aeswap_liquidityAddSettingsSlippageErrorBetween0and100;

  /// No description provided for @aeswap_liquidityAddSettingsSlippageErrorHighSlippage.
  ///
  /// In en, this message translates to:
  /// **'Warning. Your transaction may be significantly impacted due to high slippage.'**
  String get aeswap_liquidityAddSettingsSlippageErrorHighSlippage;

  /// No description provided for @aeswap_liquidityRemovePleaseConfirm.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm the removal of '**
  String get aeswap_liquidityRemovePleaseConfirm;

  /// No description provided for @aeswap_liquidityRemoveAmountLPTokens.
  ///
  /// In en, this message translates to:
  /// **'LP Tokens from the liquidity pool.'**
  String get aeswap_liquidityRemoveAmountLPTokens;

  /// No description provided for @aeswap_liquidityRemoveAmountLPToken.
  ///
  /// In en, this message translates to:
  /// **'LP Token from the liquidity pool.'**
  String get aeswap_liquidityRemoveAmountLPToken;

  /// No description provided for @aeswap_liquidityRemoveFinalAmountTokenObtained.
  ///
  /// In en, this message translates to:
  /// **'Token obtained:'**
  String get aeswap_liquidityRemoveFinalAmountTokenObtained;

  /// No description provided for @aeswap_liquidityRemoveFinalAmountTokenBurned.
  ///
  /// In en, this message translates to:
  /// **'LP Token burned:'**
  String get aeswap_liquidityRemoveFinalAmountTokenBurned;

  /// No description provided for @aeswap_liquidityRemoveInProgressTxAddresses.
  ///
  /// In en, this message translates to:
  /// **'Liquidity suppression transaction address:'**
  String get aeswap_liquidityRemoveInProgressTxAddresses;

  /// No description provided for @aeswap_liquidityRemoveInProgressTxAddressesShort.
  ///
  /// In en, this message translates to:
  /// **'Liquidity supp. transaction address:'**
  String get aeswap_liquidityRemoveInProgressTxAddressesShort;

  /// No description provided for @aeswap_failureUserRejected.
  ///
  /// In en, this message translates to:
  /// **'The request has been declined.'**
  String get aeswap_failureUserRejected;

  /// No description provided for @aeswap_failureConnectivityArchethic.
  ///
  /// In en, this message translates to:
  /// **'Please, open your Archethic Wallet and allow DApps connection.'**
  String get aeswap_failureConnectivityArchethic;

  /// No description provided for @aeswap_failureConnectivityArchethicBrave.
  ///
  /// In en, this message translates to:
  /// **'Please, open your Archethic Wallet, allow DApps connection and disable Brave\'s shield.'**
  String get aeswap_failureConnectivityArchethicBrave;

  /// No description provided for @aeswap_failureInsufficientFunds.
  ///
  /// In en, this message translates to:
  /// **'Funds are not sufficient.'**
  String get aeswap_failureInsufficientFunds;

  /// No description provided for @aeswap_failureTimeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout occurred.'**
  String get aeswap_failureTimeout;

  /// No description provided for @aeswap_failurePoolAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Pool already exists for this pair'**
  String get aeswap_failurePoolAlreadyExists;

  /// No description provided for @aeswap_failurePoolNotExists.
  ///
  /// In en, this message translates to:
  /// **'No pool for this pair'**
  String get aeswap_failurePoolNotExists;

  /// No description provided for @aeswap_failureIncompatibleBrowser.
  ///
  /// In en, this message translates to:
  /// **'Sorry, but your browser is not compatible with the app.\n\nPlease refer to the FAQ for more information.\nhttps://wiki.archethic.net/FAQ/dex#what-web-browsers-are-not-supported'**
  String get aeswap_failureIncompatibleBrowser;

  /// No description provided for @aeswap_removeLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Remove liquidity'**
  String get aeswap_removeLiquidity;

  /// No description provided for @aeswap_btn_liquidity_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove liquidity'**
  String get aeswap_btn_liquidity_remove;

  /// No description provided for @aeswap_btn_confirm_liquidity_remove.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get aeswap_btn_confirm_liquidity_remove;

  /// No description provided for @aeswap_liquidityRemoveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get aeswap_liquidityRemoveConfirmTitle;

  /// No description provided for @aeswap_liquidityRemoveFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove liquidity'**
  String get aeswap_liquidityRemoveFormTitle;

  /// No description provided for @aeswap_liquidityRemoveProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get aeswap_liquidityRemoveProcessInterruptionWarning;

  /// No description provided for @aeswap_liquidityRemoveSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'The liquidity has been removed successfully'**
  String get aeswap_liquidityRemoveSuccessInfo;

  /// No description provided for @aeswap_liquidityRemoveInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_liquidityRemoveInProgressConfirmAEWallet;

  /// No description provided for @aeswap_liquidityRemoveProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get aeswap_liquidityRemoveProcessInProgress;

  /// No description provided for @aeswap_swapConfirmInfosAmountTokens.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get aeswap_swapConfirmInfosAmountTokens;

  /// No description provided for @aeswap_swapConfirmInfosAmountMinReceived.
  ///
  /// In en, this message translates to:
  /// **'Mininum received'**
  String get aeswap_swapConfirmInfosAmountMinReceived;

  /// No description provided for @aeswap_swapConfirmInfosAmountMinFees.
  ///
  /// In en, this message translates to:
  /// **'Fees:'**
  String get aeswap_swapConfirmInfosAmountMinFees;

  /// No description provided for @aeswap_swapConfirmInfosFeesLP.
  ///
  /// In en, this message translates to:
  /// **'Liquidity Provider fees'**
  String get aeswap_swapConfirmInfosFeesLP;

  /// No description provided for @aeswap_swapConfirmInfosFeesProtocol.
  ///
  /// In en, this message translates to:
  /// **'Protocol fees'**
  String get aeswap_swapConfirmInfosFeesProtocol;

  /// No description provided for @aeswap_swapConfirmInfosMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'The UCO amount you entered has been reduced to include transaction fees.'**
  String get aeswap_swapConfirmInfosMessageMaxHalfUCO;

  /// No description provided for @aeswap_swapFinalAmountAmountSwapped.
  ///
  /// In en, this message translates to:
  /// **'Final amount swapped:'**
  String get aeswap_swapFinalAmountAmountSwapped;

  /// No description provided for @aeswap_swapProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get aeswap_swapProcessInterruptionWarning;

  /// No description provided for @aeswap_swapSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'The swap has been completed successfully'**
  String get aeswap_swapSuccessInfo;

  /// No description provided for @aeswap_swapInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_swapInProgressConfirmAEWallet;

  /// No description provided for @aeswap_swapProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get aeswap_swapProcessInProgress;

  /// No description provided for @aeswap_swapMessageMaxHalfUCO.
  ///
  /// In en, this message translates to:
  /// **'The swap process requires a maximum of %1 in transaction fees to be completed.'**
  String get aeswap_swapMessageMaxHalfUCO;

  /// No description provided for @aeswap_swapCreatePool.
  ///
  /// In en, this message translates to:
  /// **'Create this pool'**
  String get aeswap_swapCreatePool;

  /// No description provided for @aeswap_swapIconRefreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh information'**
  String get aeswap_swapIconRefreshTooltip;

  /// No description provided for @aeswap_swapIconSlippageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Set slippage tolerance information'**
  String get aeswap_swapIconSlippageTooltip;

  /// No description provided for @aeswap_swapInProgressTxAddresses.
  ///
  /// In en, this message translates to:
  /// **'Swap transaction address:'**
  String get aeswap_swapInProgressTxAddresses;

  /// No description provided for @aeswap_swapInfosFees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get aeswap_swapInfosFees;

  /// No description provided for @aeswap_swapInfosPriceImpact.
  ///
  /// In en, this message translates to:
  /// **'Price impact'**
  String get aeswap_swapInfosPriceImpact;

  /// No description provided for @aeswap_swapInfosMinimumReceived.
  ///
  /// In en, this message translates to:
  /// **'Minimum received'**
  String get aeswap_swapInfosMinimumReceived;

  /// No description provided for @aeswap_swapInfosTVL.
  ///
  /// In en, this message translates to:
  /// **'TVL'**
  String get aeswap_swapInfosTVL;

  /// No description provided for @aeswap_swapInfosRatio.
  ///
  /// In en, this message translates to:
  /// **'Ratio'**
  String get aeswap_swapInfosRatio;

  /// No description provided for @aeswap_swapInfosLiquidityProviderFees.
  ///
  /// In en, this message translates to:
  /// **'Liquidity Provider fees'**
  String get aeswap_swapInfosLiquidityProviderFees;

  /// No description provided for @aeswap_swapInfosProtocolFees.
  ///
  /// In en, this message translates to:
  /// **'Protocol fees'**
  String get aeswap_swapInfosProtocolFees;

  /// No description provided for @aeswap_swapSettingsSlippageErrorBetween0and100.
  ///
  /// In en, this message translates to:
  /// **'The slippage tolerance should be between 0 (no slippage) and 100%'**
  String get aeswap_swapSettingsSlippageErrorBetween0and100;

  /// No description provided for @aeswap_swapSettingsSlippageErrorHighSlippage.
  ///
  /// In en, this message translates to:
  /// **'Warning. Your transaction may be significantly impacted due to high slippage.'**
  String get aeswap_swapSettingsSlippageErrorHighSlippage;

  /// No description provided for @aeswap_poolAddControlToken1Empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the token 1'**
  String get aeswap_poolAddControlToken1Empty;

  /// No description provided for @aeswap_poolAddControlToken2Empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the token 2'**
  String get aeswap_poolAddControlToken2Empty;

  /// No description provided for @aeswap_poolAddControlToken1AmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for token 1 exceeds your balance.'**
  String get aeswap_poolAddControlToken1AmountExceedBalance;

  /// No description provided for @aeswap_poolAddControlToken2AmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for token 2 exceeds your balance.'**
  String get aeswap_poolAddControlToken2AmountExceedBalance;

  /// No description provided for @aeswap_poolAddControl2TokensAmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for the 2 tokens exceeds your balance.'**
  String get aeswap_poolAddControl2TokensAmountExceedBalance;

  /// No description provided for @aeswap_poolAddControlSameTokens.
  ///
  /// In en, this message translates to:
  /// **'You cannot create a pool with the same 2 tokens'**
  String get aeswap_poolAddControlSameTokens;

  /// No description provided for @aeswap_addPoolProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_addPoolProcessStep0;

  /// No description provided for @aeswap_addPoolProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information to create the pool'**
  String get aeswap_addPoolProcessStep1;

  /// No description provided for @aeswap_addPoolProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information to pay pool creation fees'**
  String get aeswap_addPoolProcessStep2;

  /// No description provided for @aeswap_addPoolProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Creation of a LP token associated with the pool being created'**
  String get aeswap_addPoolProcessStep3;

  /// No description provided for @aeswap_addPoolProcessStep4.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information needed to create the pool and add liquidity to the pool'**
  String get aeswap_addPoolProcessStep4;

  /// No description provided for @aeswap_addPoolProcessStep5.
  ///
  /// In en, this message translates to:
  /// **'Creating the pool and adding liquidity'**
  String get aeswap_addPoolProcessStep5;

  /// No description provided for @aeswap_addPoolProcessStep6.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_addPoolProcessStep6;

  /// No description provided for @aeswap_addLiquidityProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_addLiquidityProcessStep0;

  /// No description provided for @aeswap_addLiquidityProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information to add liquidity to the pool'**
  String get aeswap_addLiquidityProcessStep1;

  /// No description provided for @aeswap_addLiquidityProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Adding liquidity'**
  String get aeswap_addLiquidityProcessStep2;

  /// No description provided for @aeswap_addLiquidityProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_addLiquidityProcessStep3;

  /// No description provided for @aeswap_removeLiquidityProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_removeLiquidityProcessStep0;

  /// No description provided for @aeswap_removeLiquidityProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information to remove liquidity from the pool'**
  String get aeswap_removeLiquidityProcessStep1;

  /// No description provided for @aeswap_removeLiquidityProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Removing liquidity'**
  String get aeswap_removeLiquidityProcessStep2;

  /// No description provided for @aeswap_removeLiquidityProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_removeLiquidityProcessStep3;

  /// No description provided for @aeswap_liquidityAddControlToken1AmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount of token 1'**
  String get aeswap_liquidityAddControlToken1AmountEmpty;

  /// No description provided for @aeswap_liquidityAddControlToken2AmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount of token 2'**
  String get aeswap_liquidityAddControlToken2AmountEmpty;

  /// No description provided for @aeswap_liquidityAddControlToken1AmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for token 1 exceeds your balance.'**
  String get aeswap_liquidityAddControlToken1AmountExceedBalance;

  /// No description provided for @aeswap_liquidityAddControlToken2AmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for token 2 exceeds your balance.'**
  String get aeswap_liquidityAddControlToken2AmountExceedBalance;

  /// No description provided for @aeswap_liquidityRemoveControlLPTokenAmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount of lp token'**
  String get aeswap_liquidityRemoveControlLPTokenAmountEmpty;

  /// No description provided for @aeswap_lpTokenAmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for lp token exceeds your balance.'**
  String get aeswap_lpTokenAmountExceedBalance;

  /// No description provided for @aeswap_liquidityRemoveTokensGetBackHeader.
  ///
  /// In en, this message translates to:
  /// **'Amounts of token to get back when removing liquidity'**
  String get aeswap_liquidityRemoveTokensGetBackHeader;

  /// No description provided for @aeswap_swapControlTokenToSwapEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the token to swap'**
  String get aeswap_swapControlTokenToSwapEmpty;

  /// No description provided for @aeswap_swapControlTokenSwappedEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the token swapped'**
  String get aeswap_swapControlTokenSwappedEmpty;

  /// No description provided for @aeswap_swapControlTokenToSwapAmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered for token to swap exceeds your balance.'**
  String get aeswap_swapControlTokenToSwapAmountExceedBalance;

  /// No description provided for @aeswap_poolCardPooled.
  ///
  /// In en, this message translates to:
  /// **'Deposited'**
  String get aeswap_poolCardPooled;

  /// No description provided for @aeswap_swapProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_swapProcessStep0;

  /// No description provided for @aeswap_swapProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Calculating'**
  String get aeswap_swapProcessStep1;

  /// No description provided for @aeswap_swapProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Retrieving information to swap'**
  String get aeswap_swapProcessStep2;

  /// No description provided for @aeswap_swapProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Swapping'**
  String get aeswap_swapProcessStep3;

  /// No description provided for @aeswap_swapProcessStep4.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_swapProcessStep4;

  /// No description provided for @aeswap_feesLbl.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get aeswap_feesLbl;

  /// No description provided for @aeswap_swapFromLbl.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get aeswap_swapFromLbl;

  /// No description provided for @aeswap_swapToEstimatedLbl.
  ///
  /// In en, this message translates to:
  /// **'To (estimated)'**
  String get aeswap_swapToEstimatedLbl;

  /// No description provided for @aeswap_poolAddConfirmNewPoolLbl.
  ///
  /// In en, this message translates to:
  /// **'New pool'**
  String get aeswap_poolAddConfirmNewPoolLbl;

  /// No description provided for @aeswap_poolAddConfirmWithLiquidityLbl.
  ///
  /// In en, this message translates to:
  /// **'With liquidity'**
  String get aeswap_poolAddConfirmWithLiquidityLbl;

  /// No description provided for @aeswap_confirmBeforeLbl.
  ///
  /// In en, this message translates to:
  /// **'Before'**
  String get aeswap_confirmBeforeLbl;

  /// No description provided for @aeswap_confirmAfterLbl.
  ///
  /// In en, this message translates to:
  /// **'After'**
  String get aeswap_confirmAfterLbl;

  /// No description provided for @aeswap_poolCardPoolVerified.
  ///
  /// In en, this message translates to:
  /// **'Pool verified'**
  String get aeswap_poolCardPoolVerified;

  /// No description provided for @aeswap_localHistoryTooltipLinkPool.
  ///
  /// In en, this message translates to:
  /// **'View the pool information in the explorer'**
  String get aeswap_localHistoryTooltipLinkPool;

  /// No description provided for @aeswap_depositProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_depositProcessStep0;

  /// No description provided for @aeswap_depositProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get aeswap_depositProcessStep1;

  /// No description provided for @aeswap_depositProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Deposit in progress'**
  String get aeswap_depositProcessStep2;

  /// No description provided for @aeswap_depositProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_depositProcessStep3;

  /// No description provided for @aeswap_farmDepositControlAmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount'**
  String get aeswap_farmDepositControlAmountEmpty;

  /// No description provided for @aeswap_farmDepositControlAmountMin.
  ///
  /// In en, this message translates to:
  /// **'The amount should be >= 0.00000143 LP Token'**
  String get aeswap_farmDepositControlAmountMin;

  /// No description provided for @aeswap_farmDepositControlLPTokenAmountExceedBalance.
  ///
  /// In en, this message translates to:
  /// **'The amount entered exceeds your balance.'**
  String get aeswap_farmDepositControlLPTokenAmountExceedBalance;

  /// No description provided for @aeswap_farmDepositConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get aeswap_farmDepositConfirmTitle;

  /// No description provided for @aeswap_farmDepositFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get aeswap_farmDepositFormTitle;

  /// No description provided for @aeswap_farmDepositProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get aeswap_farmDepositProcessInterruptionWarning;

  /// No description provided for @aeswap_farmDepositSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Deposit has been done successfully'**
  String get aeswap_farmDepositSuccessInfo;

  /// No description provided for @aeswap_farmDepositInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_farmDepositInProgressConfirmAEWallet;

  /// No description provided for @aeswap_farmDepositProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get aeswap_farmDepositProcessInProgress;

  /// No description provided for @aeswap_btn_farm_deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get aeswap_btn_farm_deposit;

  /// No description provided for @aeswap_btn_confirm_farm_deposit.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get aeswap_btn_confirm_farm_deposit;

  /// No description provided for @aeswap_withdrawProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_withdrawProcessStep0;

  /// No description provided for @aeswap_withdrawProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get aeswap_withdrawProcessStep1;

  /// No description provided for @aeswap_withdrawProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Withdraw in progress'**
  String get aeswap_withdrawProcessStep2;

  /// No description provided for @aeswap_withdrawProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_withdrawProcessStep3;

  /// No description provided for @aeswap_farmWithdrawControlAmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount'**
  String get aeswap_farmWithdrawControlAmountEmpty;

  /// No description provided for @aeswap_farmWithdrawConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get aeswap_farmWithdrawConfirmTitle;

  /// No description provided for @aeswap_farmWithdrawFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get aeswap_farmWithdrawFormTitle;

  /// No description provided for @aeswap_farmWithdrawProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get aeswap_farmWithdrawProcessInterruptionWarning;

  /// No description provided for @aeswap_farmWithdrawSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Withdraw has been done successfully'**
  String get aeswap_farmWithdrawSuccessInfo;

  /// No description provided for @aeswap_farmWithdrawInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_farmWithdrawInProgressConfirmAEWallet;

  /// No description provided for @aeswap_farmWithdrawProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get aeswap_farmWithdrawProcessInProgress;

  /// No description provided for @aeswap_farmWithdrawControlLPTokenAmountExceedDeposited.
  ///
  /// In en, this message translates to:
  /// **'The amount entered exceeds the deposited amount.'**
  String get aeswap_farmWithdrawControlLPTokenAmountExceedDeposited;

  /// No description provided for @aeswap_btn_farm_withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get aeswap_btn_farm_withdraw;

  /// No description provided for @aeswap_btn_confirm_farm_withdraw.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get aeswap_btn_confirm_farm_withdraw;

  /// No description provided for @aeswap_claimProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_claimProcessStep0;

  /// No description provided for @aeswap_claimProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get aeswap_claimProcessStep1;

  /// No description provided for @aeswap_claimProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Claim in progress'**
  String get aeswap_claimProcessStep2;

  /// No description provided for @aeswap_claimProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_claimProcessStep3;

  /// No description provided for @aeswap_farmClaimConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get aeswap_farmClaimConfirmTitle;

  /// No description provided for @aeswap_farmClaimFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get aeswap_farmClaimFormTitle;

  /// No description provided for @aeswap_farmClaimProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get aeswap_farmClaimProcessInterruptionWarning;

  /// No description provided for @aeswap_farmClaimSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Claim has been done successfully'**
  String get aeswap_farmClaimSuccessInfo;

  /// No description provided for @aeswap_farmClaimInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_farmClaimInProgressConfirmAEWallet;

  /// No description provided for @aeswap_farmClaimProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get aeswap_farmClaimProcessInProgress;

  /// No description provided for @aeswap_btn_farm_claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get aeswap_btn_farm_claim;

  /// No description provided for @aeswap_btn_confirm_farm_claim.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get aeswap_btn_confirm_farm_claim;

  /// No description provided for @aeswap_farmDetailsInfoAddressesFarmAddress.
  ///
  /// In en, this message translates to:
  /// **'Farm address: '**
  String get aeswap_farmDetailsInfoAddressesFarmAddress;

  /// No description provided for @aeswap_farmDetailsInfoAddressesLPAddress.
  ///
  /// In en, this message translates to:
  /// **'LP Token address: '**
  String get aeswap_farmDetailsInfoAddressesLPAddress;

  /// No description provided for @aeswap_farmDetailsInfoAPR.
  ///
  /// In en, this message translates to:
  /// **'Current APR'**
  String get aeswap_farmDetailsInfoAPR;

  /// No description provided for @aeswap_farmDetailsInfoDistributedRewards.
  ///
  /// In en, this message translates to:
  /// **'Distributed rewards'**
  String get aeswap_farmDetailsInfoDistributedRewards;

  /// No description provided for @aeswap_farmDetailsInfoLPDeposited.
  ///
  /// In en, this message translates to:
  /// **'LP Token deposited'**
  String get aeswap_farmDetailsInfoLPDeposited;

  /// No description provided for @aeswap_lpToken.
  ///
  /// In en, this message translates to:
  /// **'LP Token'**
  String get aeswap_lpToken;

  /// No description provided for @aeswap_lpTokens.
  ///
  /// In en, this message translates to:
  /// **'LP Tokens'**
  String get aeswap_lpTokens;

  /// No description provided for @aeswap_lpTokenExpected.
  ///
  /// In en, this message translates to:
  /// **'LP Token expected'**
  String get aeswap_lpTokenExpected;

  /// No description provided for @aeswap_lpTokensExpected.
  ///
  /// In en, this message translates to:
  /// **'LP Tokens expected'**
  String get aeswap_lpTokensExpected;

  /// No description provided for @aeswap_available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get aeswap_available;

  /// No description provided for @aeswap_legacy.
  ///
  /// In en, this message translates to:
  /// **'Legacy'**
  String get aeswap_legacy;

  /// No description provided for @aeswap_lvl.
  ///
  /// In en, this message translates to:
  /// **'Lvl'**
  String get aeswap_lvl;

  /// No description provided for @aeswap_level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get aeswap_level;

  /// No description provided for @aeswap_farmDetailsInfoNbDeposit.
  ///
  /// In en, this message translates to:
  /// **'Holders'**
  String get aeswap_farmDetailsInfoNbDeposit;

  /// No description provided for @aeswap_farmDetailsInfoPeriodWillStart.
  ///
  /// In en, this message translates to:
  /// **'Farm will start at'**
  String get aeswap_farmDetailsInfoPeriodWillStart;

  /// No description provided for @aeswap_farmDetailsInfoPeriodStarted.
  ///
  /// In en, this message translates to:
  /// **'Farm started since'**
  String get aeswap_farmDetailsInfoPeriodStarted;

  /// No description provided for @aeswap_farmDetailsInfoPeriodEndAt.
  ///
  /// In en, this message translates to:
  /// **'Farm ends at'**
  String get aeswap_farmDetailsInfoPeriodEndAt;

  /// No description provided for @aeswap_farmDetailsInfoPeriodEnded.
  ///
  /// In en, this message translates to:
  /// **'Farm ended'**
  String get aeswap_farmDetailsInfoPeriodEnded;

  /// No description provided for @aeswap_farmDetailsInfoRemainingReward.
  ///
  /// In en, this message translates to:
  /// **'Remaining reward'**
  String get aeswap_farmDetailsInfoRemainingReward;

  /// No description provided for @aeswap_farmDetailsInfoTokenRewardEarn.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get aeswap_farmDetailsInfoTokenRewardEarn;

  /// No description provided for @aeswap_farmDetailsInfoYourAvailableLP.
  ///
  /// In en, this message translates to:
  /// **'Your available LP Tokens'**
  String get aeswap_farmDetailsInfoYourAvailableLP;

  /// No description provided for @aeswap_farmDetailsInfoYourDepositedAmount.
  ///
  /// In en, this message translates to:
  /// **'Your deposited amount'**
  String get aeswap_farmDetailsInfoYourDepositedAmount;

  /// No description provided for @aeswap_farmDetailsInfoYourRewardAmount.
  ///
  /// In en, this message translates to:
  /// **'Your reward amount'**
  String get aeswap_farmDetailsInfoYourRewardAmount;

  /// No description provided for @aeswap_farmDetailsButtonDepositFarmClosed.
  ///
  /// In en, this message translates to:
  /// **'Deposit LP Tokens (Farm closed)'**
  String get aeswap_farmDetailsButtonDepositFarmClosed;

  /// No description provided for @aeswap_farmDetailsButtonDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit LP Tokens'**
  String get aeswap_farmDetailsButtonDeposit;

  /// No description provided for @aeswap_farmDetailsButtonWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get aeswap_farmDetailsButtonWithdraw;

  /// No description provided for @aeswap_farmDetailsButtonClaim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get aeswap_farmDetailsButtonClaim;

  /// No description provided for @aeswap_farmCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Farming'**
  String get aeswap_farmCardTitle;

  /// No description provided for @aeswap_refreshIconToolTip.
  ///
  /// In en, this message translates to:
  /// **'Refresh information'**
  String get aeswap_refreshIconToolTip;

  /// No description provided for @aeswap_poolDetailsInfoSwapFees.
  ///
  /// In en, this message translates to:
  /// **'Swap fees'**
  String get aeswap_poolDetailsInfoSwapFees;

  /// No description provided for @aeswap_poolDetailsInfoProtocolFees.
  ///
  /// In en, this message translates to:
  /// **'Protocol fees'**
  String get aeswap_poolDetailsInfoProtocolFees;

  /// No description provided for @aeswap_poolDetailsInfoAddressesPoolAddress.
  ///
  /// In en, this message translates to:
  /// **'Pool address: '**
  String get aeswap_poolDetailsInfoAddressesPoolAddress;

  /// No description provided for @aeswap_poolDetailsInfoAddressesLPAddress.
  ///
  /// In en, this message translates to:
  /// **'LP Token address: '**
  String get aeswap_poolDetailsInfoAddressesLPAddress;

  /// No description provided for @aeswap_poolDetailsInfoAddressesToken1Address.
  ///
  /// In en, this message translates to:
  /// **'Token %1 address: '**
  String get aeswap_poolDetailsInfoAddressesToken1Address;

  /// No description provided for @aeswap_poolDetailsInfoAddressesToken2Address.
  ///
  /// In en, this message translates to:
  /// **'Token %1 address: '**
  String get aeswap_poolDetailsInfoAddressesToken2Address;

  /// No description provided for @aeswap_poolDetailsInfoDeposited.
  ///
  /// In en, this message translates to:
  /// **'Deposited'**
  String get aeswap_poolDetailsInfoDeposited;

  /// No description provided for @aeswap_poolDetailsInfoDepositedEquivalent.
  ///
  /// In en, this message translates to:
  /// **'Equivalent'**
  String get aeswap_poolDetailsInfoDepositedEquivalent;

  /// No description provided for @aeswap_poolDetailsInfoTVL.
  ///
  /// In en, this message translates to:
  /// **'TVL'**
  String get aeswap_poolDetailsInfoTVL;

  /// No description provided for @aeswap_poolDetailsInfoAPR.
  ///
  /// In en, this message translates to:
  /// **'APR'**
  String get aeswap_poolDetailsInfoAPR;

  /// No description provided for @aeswap_poolDetailsInfoAPRFarm3Years.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get aeswap_poolDetailsInfoAPRFarm3Years;

  /// No description provided for @aeswap_time24h.
  ///
  /// In en, this message translates to:
  /// **'24h'**
  String get aeswap_time24h;

  /// No description provided for @aeswap_time7d.
  ///
  /// In en, this message translates to:
  /// **'7d'**
  String get aeswap_time7d;

  /// No description provided for @aeswap_timeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get aeswap_timeAll;

  /// No description provided for @aeswap_poolDetailsInfoVolume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get aeswap_poolDetailsInfoVolume;

  /// No description provided for @aeswap_poolDetailsInfoFees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get aeswap_poolDetailsInfoFees;

  /// No description provided for @aeswap_poolDetailsInfoButtonAddLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Add Liquidity'**
  String get aeswap_poolDetailsInfoButtonAddLiquidity;

  /// No description provided for @aeswap_poolDetailsInfoButtonRemoveLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Remove Liquidity'**
  String get aeswap_poolDetailsInfoButtonRemoveLiquidity;

  /// No description provided for @aeswap_poolAddFavoriteIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add this pool in my favorites tab'**
  String get aeswap_poolAddFavoriteIconTooltip;

  /// No description provided for @aeswap_poolCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Pool'**
  String get aeswap_poolCardTitle;

  /// No description provided for @aeswap_poolListSearchBarHint.
  ///
  /// In en, this message translates to:
  /// **'Search by pool or token address or \"UCO\"'**
  String get aeswap_poolListSearchBarHint;

  /// No description provided for @aeswap_poolCreatePoolButton.
  ///
  /// In en, this message translates to:
  /// **'Create Pool'**
  String get aeswap_poolCreatePoolButton;

  /// No description provided for @aeswap_poolListTabVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get aeswap_poolListTabVerified;

  /// No description provided for @aeswap_poolListTabMyPools.
  ///
  /// In en, this message translates to:
  /// **'My pools'**
  String get aeswap_poolListTabMyPools;

  /// No description provided for @aeswap_poolListTabFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get aeswap_poolListTabFavorites;

  /// No description provided for @aeswap_poolListTabResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get aeswap_poolListTabResults;

  /// No description provided for @aeswap_poolRefreshIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh information'**
  String get aeswap_poolRefreshIconTooltip;

  /// No description provided for @aeswap_poolRemoveFavoriteIconConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Remove the pool from favorite tab?'**
  String get aeswap_poolRemoveFavoriteIconConfirmation;

  /// No description provided for @aeswap_poolRemoveFavoriteIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove the pool from favorite tab?'**
  String get aeswap_poolRemoveFavoriteIconTooltip;

  /// No description provided for @aeswap_poolListSearching.
  ///
  /// In en, this message translates to:
  /// **'Searching in progress. Please wait'**
  String get aeswap_poolListSearching;

  /// No description provided for @aeswap_poolListConnectWalletMyPools.
  ///
  /// In en, this message translates to:
  /// **'Please, connect your wallet to list your pools with position.'**
  String get aeswap_poolListConnectWalletMyPools;

  /// No description provided for @aeswap_poolListEnterSearchCriteria.
  ///
  /// In en, this message translates to:
  /// **'Please enter your search criteria.'**
  String get aeswap_poolListEnterSearchCriteria;

  /// No description provided for @aeswap_poolListNoResult.
  ///
  /// In en, this message translates to:
  /// **'No results found.'**
  String get aeswap_poolListNoResult;

  /// No description provided for @aeswap_poolListAddFavoriteText1.
  ///
  /// In en, this message translates to:
  /// **'To add your favorite pools to this tab, please click on the'**
  String get aeswap_poolListAddFavoriteText1;

  /// No description provided for @aeswap_poolListAddFavoriteText2.
  ///
  /// In en, this message translates to:
  /// **'icon in the pool cards header.'**
  String get aeswap_poolListAddFavoriteText2;

  /// No description provided for @aeswap_farmClaimConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the claim of '**
  String get aeswap_farmClaimConfirmInfosText;

  /// No description provided for @aeswap_farmClaimFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount claimed: '**
  String get aeswap_farmClaimFinalAmount;

  /// No description provided for @aeswap_finalAmountNotRecovered.
  ///
  /// In en, this message translates to:
  /// **'The amount could not be recovered'**
  String get aeswap_finalAmountNotRecovered;

  /// No description provided for @aeswap_finalAmountsNotRecovered.
  ///
  /// In en, this message translates to:
  /// **'The amounts could not be recovered'**
  String get aeswap_finalAmountsNotRecovered;

  /// No description provided for @aeswap_farmClaimFormText.
  ///
  /// In en, this message translates to:
  /// **'are available for claiming.'**
  String get aeswap_farmClaimFormText;

  /// No description provided for @aeswap_farmClaimTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Claim transaction address: '**
  String get aeswap_farmClaimTxAddress;

  /// No description provided for @aeswap_farmDepositConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the deposit of '**
  String get aeswap_farmDepositConfirmInfosText;

  /// No description provided for @aeswap_farmDepositConfirmYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get aeswap_farmDepositConfirmYourBalance;

  /// No description provided for @aeswap_farmDepositConfirmFarmBalance.
  ///
  /// In en, this message translates to:
  /// **'Farm\'s balance'**
  String get aeswap_farmDepositConfirmFarmBalance;

  /// No description provided for @aeswap_farmDepositFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount deposited: '**
  String get aeswap_farmDepositFinalAmount;

  /// No description provided for @aeswap_farmDepositTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Deposit transaction address: '**
  String get aeswap_farmDepositTxAddress;

  /// No description provided for @aeswap_farmWithdrawConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the withdraw of '**
  String get aeswap_farmWithdrawConfirmInfosText;

  /// No description provided for @aeswap_farmWithdrawConfirmYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get aeswap_farmWithdrawConfirmYourBalance;

  /// No description provided for @aeswap_farmWithdrawConfirmFarmBalance.
  ///
  /// In en, this message translates to:
  /// **'Farm\'s balance'**
  String get aeswap_farmWithdrawConfirmFarmBalance;

  /// No description provided for @aeswap_farmWithdrawConfirmRewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get aeswap_farmWithdrawConfirmRewards;

  /// No description provided for @aeswap_farmWithdrawConfirmYouWillReceive.
  ///
  /// In en, this message translates to:
  /// **'You will receive '**
  String get aeswap_farmWithdrawConfirmYouWillReceive;

  /// No description provided for @aeswap_farmWithdrawFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount withdrawn: '**
  String get aeswap_farmWithdrawFinalAmount;

  /// No description provided for @aeswap_farmWithdrawFinalAmountReward.
  ///
  /// In en, this message translates to:
  /// **'Amount rewarded: '**
  String get aeswap_farmWithdrawFinalAmountReward;

  /// No description provided for @aeswap_farmWithdrawFormText.
  ///
  /// In en, this message translates to:
  /// **'You can withdraw all or part of your deposited LP tokens. At the same time, this will claim your rewards.'**
  String get aeswap_farmWithdrawFormText;

  /// No description provided for @aeswap_farmWithdrawFormTextNoRewardText1.
  ///
  /// In en, this message translates to:
  /// **'No reward are available'**
  String get aeswap_farmWithdrawFormTextNoRewardText1;

  /// No description provided for @aeswap_farmWithdrawFormTextNoRewardText2.
  ///
  /// In en, this message translates to:
  /// **' are available for claiming.'**
  String get aeswap_farmWithdrawFormTextNoRewardText2;

  /// No description provided for @aeswap_farmWithdrawTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Withdraw transaction address: '**
  String get aeswap_farmWithdrawTxAddress;

  /// No description provided for @aeswap_runningTasksNotificationTasksInProgress.
  ///
  /// In en, this message translates to:
  /// **'tasks in progress'**
  String get aeswap_runningTasksNotificationTasksInProgress;

  /// No description provided for @aeswap_runningTasksNotificationTaskInProgress.
  ///
  /// In en, this message translates to:
  /// **'task in progress'**
  String get aeswap_runningTasksNotificationTaskInProgress;

  /// No description provided for @aeswap_warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get aeswap_warning;

  /// No description provided for @aeswap_headerDecentralizedExchange.
  ///
  /// In en, this message translates to:
  /// **'Decentralized Exchange'**
  String get aeswap_headerDecentralizedExchange;

  /// No description provided for @aeswap_tokenSelectionSingleTokenLPTooltip.
  ///
  /// In en, this message translates to:
  /// **'LP Token for pair'**
  String get aeswap_tokenSelectionSingleTokenLPTooltip;

  /// No description provided for @aeswap_priceImpact.
  ///
  /// In en, this message translates to:
  /// **'Price impact:'**
  String get aeswap_priceImpact;

  /// No description provided for @aeswap_priceImpactHighTooltip.
  ///
  /// In en, this message translates to:
  /// **'Warning, the price impact is high.'**
  String get aeswap_priceImpactHighTooltip;

  /// No description provided for @aeswap_liquidityPositionsIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'You have liquidity positions'**
  String get aeswap_liquidityPositionsIconTooltip;

  /// No description provided for @aeswap_liquidityFavoriteIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'Favorite pool'**
  String get aeswap_liquidityFavoriteIconTooltip;

  /// No description provided for @aeswap_verifiedPoolIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'This pool has been verified by Archethic'**
  String get aeswap_verifiedPoolIconTooltip;

  /// No description provided for @aeswap_verifiedTokenIconTooltip.
  ///
  /// In en, this message translates to:
  /// **'This token has been verified by Archethic'**
  String get aeswap_verifiedTokenIconTooltip;

  /// No description provided for @aeswap_poolInfoCardTVL.
  ///
  /// In en, this message translates to:
  /// **'TVL:'**
  String get aeswap_poolInfoCardTVL;

  /// No description provided for @aeswap_apr24hTooltip.
  ///
  /// In en, this message translates to:
  /// **'Estimation of the annual yield based on the fees generated by swaps over the last 24 hours.\nIt provides an idea of the potential annual return based on recent performance.'**
  String get aeswap_apr24hTooltip;

  /// No description provided for @aeswap_btn_farmLockDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get aeswap_btn_farmLockDeposit;

  /// No description provided for @aeswap_farmLockDepositFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get aeswap_farmLockDepositFormTitle;

  /// No description provided for @aeswap_farmLockDepositFormAmountLbl.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get aeswap_farmLockDepositFormAmountLbl;

  /// No description provided for @aeswap_farmLockDepositDurationFlexible.
  ///
  /// In en, this message translates to:
  /// **'Flexible'**
  String get aeswap_farmLockDepositDurationFlexible;

  /// No description provided for @aeswap_farmLockDepositDurationOneMonth.
  ///
  /// In en, this message translates to:
  /// **'1 month'**
  String get aeswap_farmLockDepositDurationOneMonth;

  /// No description provided for @aeswap_farmLockDepositDurationOneWeek.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get aeswap_farmLockDepositDurationOneWeek;

  /// No description provided for @aeswap_farmLockDepositDurationOneYear.
  ///
  /// In en, this message translates to:
  /// **'1 year'**
  String get aeswap_farmLockDepositDurationOneYear;

  /// No description provided for @aeswap_farmLockDepositDurationSixMonths.
  ///
  /// In en, this message translates to:
  /// **'6 months'**
  String get aeswap_farmLockDepositDurationSixMonths;

  /// No description provided for @aeswap_farmLockDepositDurationThreeMonths.
  ///
  /// In en, this message translates to:
  /// **'3 months'**
  String get aeswap_farmLockDepositDurationThreeMonths;

  /// No description provided for @aeswap_farmLockDepositDurationThreeYears.
  ///
  /// In en, this message translates to:
  /// **'3 years'**
  String get aeswap_farmLockDepositDurationThreeYears;

  /// No description provided for @aeswap_farmLockDepositDurationTwoYears.
  ///
  /// In en, this message translates to:
  /// **'2 years'**
  String get aeswap_farmLockDepositDurationTwoYears;

  /// No description provided for @aeswap_farmLockDepositDurationMax.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get aeswap_farmLockDepositDurationMax;

  /// No description provided for @aeswap_farmLockDepositAPREstimationLbl.
  ///
  /// In en, this message translates to:
  /// **'Est. APR:'**
  String get aeswap_farmLockDepositAPREstimationLbl;

  /// No description provided for @aeswap_farmLockDepositAPRLbl.
  ///
  /// In en, this message translates to:
  /// **'APR:'**
  String get aeswap_farmLockDepositAPRLbl;

  /// No description provided for @aeswap_btn_confirm_farm_add_lock.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get aeswap_btn_confirm_farm_add_lock;

  /// No description provided for @aeswap_farmLockDepositUnlockDateLbl.
  ///
  /// In en, this message translates to:
  /// **'Release date:'**
  String get aeswap_farmLockDepositUnlockDateLbl;

  /// No description provided for @aeswap_farmLockDepositConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get aeswap_farmLockDepositConfirmTitle;

  /// No description provided for @aeswap_farmLockDepositConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the lock of '**
  String get aeswap_farmLockDepositConfirmInfosText;

  /// No description provided for @aeswap_farmLockDepositConfirmYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get aeswap_farmLockDepositConfirmYourBalance;

  /// No description provided for @aeswap_farmLockDepositConfirmInfosText2.
  ///
  /// In en, this message translates to:
  /// **' for '**
  String get aeswap_farmLockDepositConfirmInfosText2;

  /// No description provided for @aeswap_farmLockDepositFormLockDurationLbl.
  ///
  /// In en, this message translates to:
  /// **'Choose the lock duration'**
  String get aeswap_farmLockDepositFormLockDurationLbl;

  /// No description provided for @aeswap_farmLockDepositConfirmInfosText3.
  ///
  /// In en, this message translates to:
  /// **'You can recover your LP Tokens and associated rewards at any time.'**
  String get aeswap_farmLockDepositConfirmInfosText3;

  /// No description provided for @aeswap_farmLockDepositConfirmCheckBoxUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand I can\'t get my tokens back before the release date.'**
  String get aeswap_farmLockDepositConfirmCheckBoxUnderstand;

  /// No description provided for @aeswap_farmLockDepositConfirmMoreInfo.
  ///
  /// In en, this message translates to:
  /// **'More info.'**
  String get aeswap_farmLockDepositConfirmMoreInfo;

  /// No description provided for @aeswap_depositFarmLockProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_depositFarmLockProcessStep0;

  /// No description provided for @aeswap_depositFarmLockProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get aeswap_depositFarmLockProcessStep1;

  /// No description provided for @aeswap_depositFarmLockProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Deposit in progress'**
  String get aeswap_depositFarmLockProcessStep2;

  /// No description provided for @aeswap_depositFarmLockProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_depositFarmLockProcessStep3;

  /// No description provided for @aeswap_farmLockDepositFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount deposited: '**
  String get aeswap_farmLockDepositFinalAmount;

  /// No description provided for @aeswap_farmLockDepositTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Deposit transaction address: '**
  String get aeswap_farmLockDepositTxAddress;

  /// No description provided for @aeswap_farmLockDepositInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_farmLockDepositInProgressConfirmAEWallet;

  /// No description provided for @aeswap_farmLockDepositSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Deposit have been done successfully'**
  String get aeswap_farmLockDepositSuccessInfo;

  /// No description provided for @aeswap_depositFarmLockProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get aeswap_depositFarmLockProcessInProgress;

  /// No description provided for @aeswap_farmLockWithdrawConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the withdraw of '**
  String get aeswap_farmLockWithdrawConfirmInfosText;

  /// No description provided for @aeswap_farmLockWithdrawConfirmYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get aeswap_farmLockWithdrawConfirmYourBalance;

  /// No description provided for @aeswap_farmLockWithdrawConfirmFarmBalance.
  ///
  /// In en, this message translates to:
  /// **'Farm\'s balance'**
  String get aeswap_farmLockWithdrawConfirmFarmBalance;

  /// No description provided for @aeswap_farmLockWithdrawConfirmRewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get aeswap_farmLockWithdrawConfirmRewards;

  /// No description provided for @aeswap_farmLockWithdrawConfirmYouWillReceive.
  ///
  /// In en, this message translates to:
  /// **'You will receive '**
  String get aeswap_farmLockWithdrawConfirmYouWillReceive;

  /// No description provided for @aeswap_farmLockWithdrawFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount withdrawn: '**
  String get aeswap_farmLockWithdrawFinalAmount;

  /// No description provided for @aeswap_farmLockWithdrawFinalAmountReward.
  ///
  /// In en, this message translates to:
  /// **'Amount rewarded: '**
  String get aeswap_farmLockWithdrawFinalAmountReward;

  /// No description provided for @aeswap_farmLockWithdrawFormText.
  ///
  /// In en, this message translates to:
  /// **'You can withdraw all or part of your deposited LP tokens. At the same time, this will claim your rewards.'**
  String get aeswap_farmLockWithdrawFormText;

  /// No description provided for @aeswap_farmLockWithdrawFormTextNoRewardText1.
  ///
  /// In en, this message translates to:
  /// **'No reward are available'**
  String get aeswap_farmLockWithdrawFormTextNoRewardText1;

  /// No description provided for @aeswap_farmLockWithdrawFormTextNoRewardText2.
  ///
  /// In en, this message translates to:
  /// **' are available for claiming.'**
  String get aeswap_farmLockWithdrawFormTextNoRewardText2;

  /// No description provided for @aeswap_farmLockWithdrawTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Withdraw transaction address: '**
  String get aeswap_farmLockWithdrawTxAddress;

  /// No description provided for @aeswap_farmLockWithdrawControlAmountEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount'**
  String get aeswap_farmLockWithdrawControlAmountEmpty;

  /// No description provided for @aeswap_farmLockWithdrawConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get aeswap_farmLockWithdrawConfirmTitle;

  /// No description provided for @aeswap_farmLockWithdrawFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get aeswap_farmLockWithdrawFormTitle;

  /// No description provided for @aeswap_farmLockWithdrawProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get aeswap_farmLockWithdrawProcessInterruptionWarning;

  /// No description provided for @aeswap_farmLockWithdrawSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Withdraw has been done successfully'**
  String get aeswap_farmLockWithdrawSuccessInfo;

  /// No description provided for @aeswap_farmLockWithdrawInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_farmLockWithdrawInProgressConfirmAEWallet;

  /// No description provided for @aeswap_farmLockWithdrawProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get aeswap_farmLockWithdrawProcessInProgress;

  /// No description provided for @aeswap_farmLockWithdrawControlLPTokenAmountExceedDeposited.
  ///
  /// In en, this message translates to:
  /// **'The amount entered exceeds the deposited amount.'**
  String get aeswap_farmLockWithdrawControlLPTokenAmountExceedDeposited;

  /// No description provided for @aeswap_withdrawFarmLockProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_withdrawFarmLockProcessStep0;

  /// No description provided for @aeswap_withdrawFarmLockProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get aeswap_withdrawFarmLockProcessStep1;

  /// No description provided for @aeswap_withdrawFarmLockProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Withdraw in progress'**
  String get aeswap_withdrawFarmLockProcessStep2;

  /// No description provided for @aeswap_withdrawFarmLockProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_withdrawFarmLockProcessStep3;

  /// No description provided for @aeswap_farmLockBlockAddLiquidityHeader.
  ///
  /// In en, this message translates to:
  /// **'1 - Add liquidity'**
  String get aeswap_farmLockBlockAddLiquidityHeader;

  /// No description provided for @aeswap_farmLockBlockAddLiquidityDesc.
  ///
  /// In en, this message translates to:
  /// **'Add liquidity to the pool and receive LP tokens representing your share.\nBy adding liquidity, you gain access to farming opportunities and can earn additional rewards.'**
  String get aeswap_farmLockBlockAddLiquidityDesc;

  /// No description provided for @aeswap_farmLockBlockAddLiquidityViewGuideArticle.
  ///
  /// In en, this message translates to:
  /// **'View the guide article'**
  String get aeswap_farmLockBlockAddLiquidityViewGuideArticle;

  /// No description provided for @aeswap_farmLockBlockAddLiquidityBtnAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get aeswap_farmLockBlockAddLiquidityBtnAdd;

  /// No description provided for @aeswap_farmLockBlockAddLiquidityBtnInfos.
  ///
  /// In en, this message translates to:
  /// **'Infos'**
  String get aeswap_farmLockBlockAddLiquidityBtnInfos;

  /// No description provided for @aeswap_farmLockBlockEarnRewardsBtnInfosFarmLegacy.
  ///
  /// In en, this message translates to:
  /// **'Infos Farm legacy'**
  String get aeswap_farmLockBlockEarnRewardsBtnInfosFarmLegacy;

  /// No description provided for @aeswap_farmLockBlockEarnRewardsBtnInfosFarmLock.
  ///
  /// In en, this message translates to:
  /// **'Infos Farm lock'**
  String get aeswap_farmLockBlockEarnRewardsBtnInfosFarmLock;

  /// No description provided for @aeswap_farmLockBlockAddLiquidityBtnWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get aeswap_farmLockBlockAddLiquidityBtnWithdraw;

  /// No description provided for @aeswap_farmLockBlockEarnRewardsHeader.
  ///
  /// In en, this message translates to:
  /// **'2 - Earn more'**
  String get aeswap_farmLockBlockEarnRewardsHeader;

  /// No description provided for @aeswap_farmLockBlockEarnRewardsDesc.
  ///
  /// In en, this message translates to:
  /// **'Farm your LP Tokens to earn rewards. By locking them for a specified period, you increase your rewards.\nThe longer you lock, the greater your rewards.'**
  String get aeswap_farmLockBlockEarnRewardsDesc;

  /// No description provided for @aeswap_farmLockBlockEarnRewardsWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning: Rewards are recalculated every hour.'**
  String get aeswap_farmLockBlockEarnRewardsWarning;

  /// No description provided for @aeswap_farmLockBlockEarnRewardsStartFarm.
  ///
  /// In en, this message translates to:
  /// **'Info: Rewards emission will start on'**
  String get aeswap_farmLockBlockEarnRewardsStartFarm;

  /// No description provided for @aeswap_farmLockBlockEarnRewardsBtnAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get aeswap_farmLockBlockEarnRewardsBtnAdd;

  /// No description provided for @aeswap_farmLockBlockEarnRewardsBtnNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Farm not available'**
  String get aeswap_farmLockBlockEarnRewardsBtnNotAvailable;

  /// No description provided for @aeswap_farmLockBlockEarnRewardsViewGuideArticle.
  ///
  /// In en, this message translates to:
  /// **'View the guide article'**
  String get aeswap_farmLockBlockEarnRewardsViewGuideArticle;

  /// No description provided for @aeswap_farmLockBlockAprLbl.
  ///
  /// In en, this message translates to:
  /// **'APR 3 years'**
  String get aeswap_farmLockBlockAprLbl;

  /// No description provided for @aeswap_farmLockBlockFarmedTokensSummaryHeader.
  ///
  /// In en, this message translates to:
  /// **'Farmed Tokens Summary'**
  String get aeswap_farmLockBlockFarmedTokensSummaryHeader;

  /// No description provided for @aeswap_farmLockBlockBalanceSummaryHeader.
  ///
  /// In en, this message translates to:
  /// **'Your Balances Summary'**
  String get aeswap_farmLockBlockBalanceSummaryHeader;

  /// No description provided for @aeswap_farmLockBlockFarmedTokensSummaryCapitalInvestedLbl.
  ///
  /// In en, this message translates to:
  /// **'Capital Invested'**
  String get aeswap_farmLockBlockFarmedTokensSummaryCapitalInvestedLbl;

  /// No description provided for @aeswap_farmLockBlockFarmedTokensSummaryCapitalRewardsEarnedLbl.
  ///
  /// In en, this message translates to:
  /// **'Rewards Earned'**
  String get aeswap_farmLockBlockFarmedTokensSummaryCapitalRewardsEarnedLbl;

  /// No description provided for @aeswap_farmLockBlockListHeaderAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get aeswap_farmLockBlockListHeaderAmount;

  /// No description provided for @aeswap_farmLockBlockListHeaderRewards.
  ///
  /// In en, this message translates to:
  /// **'Estimated rewards'**
  String get aeswap_farmLockBlockListHeaderRewards;

  /// No description provided for @aeswap_farmLockBlockListHeaderUnlocksIn.
  ///
  /// In en, this message translates to:
  /// **'Unlocks in'**
  String get aeswap_farmLockBlockListHeaderUnlocksIn;

  /// No description provided for @aeswap_farmLockBlockListHeaderUnlocks.
  ///
  /// In en, this message translates to:
  /// **'Unlocks'**
  String get aeswap_farmLockBlockListHeaderUnlocks;

  /// No description provided for @aeswap_farmLockBlockListHeaderLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get aeswap_farmLockBlockListHeaderLevel;

  /// No description provided for @aeswap_farmLockBlockListHeaderAPR.
  ///
  /// In en, this message translates to:
  /// **'APR'**
  String get aeswap_farmLockBlockListHeaderAPR;

  /// No description provided for @aeswap_farmLockBlockListHeaderActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get aeswap_farmLockBlockListHeaderActions;

  /// No description provided for @aeswap_farmLockBtnLevelUp.
  ///
  /// In en, this message translates to:
  /// **'Level Up!'**
  String get aeswap_farmLockBtnLevelUp;

  /// No description provided for @aeswap_farmLockBtnWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get aeswap_farmLockBtnWithdraw;

  /// No description provided for @aeswap_levelUpFarmLockProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_levelUpFarmLockProcessStep0;

  /// No description provided for @aeswap_levelUpFarmLockProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get aeswap_levelUpFarmLockProcessStep1;

  /// No description provided for @aeswap_levelUpFarmLockProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Level up in progress'**
  String get aeswap_levelUpFarmLockProcessStep2;

  /// No description provided for @aeswap_levelUpFarmLockProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_levelUpFarmLockProcessStep3;

  /// No description provided for @aeswap_btn_farmLockLevelUp.
  ///
  /// In en, this message translates to:
  /// **'Level Up'**
  String get aeswap_btn_farmLockLevelUp;

  /// No description provided for @aeswap_farmLockLevelUpFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Level Up'**
  String get aeswap_farmLockLevelUpFormTitle;

  /// No description provided for @aeswap_farmLockLevelUpFormAmountLbl.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get aeswap_farmLockLevelUpFormAmountLbl;

  /// No description provided for @aeswap_farmLockLevelUpAPREstimationLbl.
  ///
  /// In en, this message translates to:
  /// **'Est. APR:'**
  String get aeswap_farmLockLevelUpAPREstimationLbl;

  /// No description provided for @aeswap_farmLockLevelUpAPRLbl.
  ///
  /// In en, this message translates to:
  /// **'APR:'**
  String get aeswap_farmLockLevelUpAPRLbl;

  /// No description provided for @aeswap_farmLockLevelUpUnlockDateLbl.
  ///
  /// In en, this message translates to:
  /// **'Release date:'**
  String get aeswap_farmLockLevelUpUnlockDateLbl;

  /// No description provided for @aeswap_farmLockLevelUpCurrentLvlLbl.
  ///
  /// In en, this message translates to:
  /// **'Current level:'**
  String get aeswap_farmLockLevelUpCurrentLvlLbl;

  /// No description provided for @aeswap_farmLockLevelUpConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get aeswap_farmLockLevelUpConfirmTitle;

  /// No description provided for @aeswap_farmLockLevelUpConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the lock of '**
  String get aeswap_farmLockLevelUpConfirmInfosText;

  /// No description provided for @aeswap_farmLockLevelUpConfirmYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your balance'**
  String get aeswap_farmLockLevelUpConfirmYourBalance;

  /// No description provided for @aeswap_farmLockLevelUpConfirmInfosText2.
  ///
  /// In en, this message translates to:
  /// **' for '**
  String get aeswap_farmLockLevelUpConfirmInfosText2;

  /// No description provided for @aeswap_farmLockLevelUpFormLockDurationLbl.
  ///
  /// In en, this message translates to:
  /// **'Choose the lock duration'**
  String get aeswap_farmLockLevelUpFormLockDurationLbl;

  /// No description provided for @aeswap_farmLockLevelUpConfirmInfosText3.
  ///
  /// In en, this message translates to:
  /// **'You can recover your LP Tokens and associated rewards at any time.'**
  String get aeswap_farmLockLevelUpConfirmInfosText3;

  /// No description provided for @aeswap_farmLockLevelUpFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount: '**
  String get aeswap_farmLockLevelUpFinalAmount;

  /// No description provided for @aeswap_farmLockLevelUpTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Level Up transaction address: '**
  String get aeswap_farmLockLevelUpTxAddress;

  /// No description provided for @aeswap_farmLockLevelUpInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_farmLockLevelUpInProgressConfirmAEWallet;

  /// No description provided for @aeswap_farmLockLevelUpSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Deposit have been done successfully'**
  String get aeswap_farmLockLevelUpSuccessInfo;

  /// No description provided for @aeswap_farmLockLevelUpDesc.
  ///
  /// In en, this message translates to:
  /// **'You can extend the duration of your lock to earn more rewards.\nTo do this, you must choose a longer period than before, which will provide you with a higher level. The higher your level, the higher the APR.\nAt the same time, this will claim your actual rewards.'**
  String get aeswap_farmLockLevelUpDesc;

  /// No description provided for @aeswap_farmLockLevelUpConfirmCheckBoxUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand I can\'t get my tokens back before the release date.'**
  String get aeswap_farmLockLevelUpConfirmCheckBoxUnderstand;

  /// No description provided for @aeswap_farmLockLevelUpConfirmMoreInfo.
  ///
  /// In en, this message translates to:
  /// **'More info.'**
  String get aeswap_farmLockLevelUpConfirmMoreInfo;

  /// No description provided for @aeswap_addLiquiditySignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the amount of each token in the pool pair to the pool address and calls the smart contract\'s add liquidity function with the minimum amount for each token.'**
  String get aeswap_addLiquiditySignTxDesc_en;

  /// No description provided for @aeswap_addPoolSignTxDesc1_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends fees to the pool address to pay for the execution of the pool creation.'**
  String get aeswap_addPoolSignTxDesc1_en;

  /// No description provided for @aeswap_addPoolSignTxDesc2_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the amount of each token in the pool pair to the pool address, calls the smart contract\'s add pool function with the pair addresses and the new pool address, and then calls the smart contract\'s add liquidity function with the minimum amount for each token.'**
  String get aeswap_addPoolSignTxDesc2_en;

  /// No description provided for @aeswap_claimFarmSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction calls the smart contract\'s claim function to execute the claim.'**
  String get aeswap_claimFarmSignTxDesc_en;

  /// No description provided for @aeswap_depositFarmLockSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the LP tokens to be locked into the farm and calls the smart contract\'s deposit function with the tokens\' release date.'**
  String get aeswap_depositFarmLockSignTxDesc_en;

  /// No description provided for @aeswap_depositFarmSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the amount of LP tokens to the farm address and calls the smart contract\'s deposit function to execute the deposit.'**
  String get aeswap_depositFarmSignTxDesc_en;

  /// No description provided for @aeswap_levelUpFarmLockSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the LP tokens to be relocked into the farm by calling the smart contract\'s relock function with the tokens\' new release date and the associated index of the deposit.'**
  String get aeswap_levelUpFarmLockSignTxDesc_en;

  /// No description provided for @aeswap_removeLiquiditySignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction burns the amount of LP Token who wish to withdraw from the pool and calls the smart contract\'s remove liquidity function to obtain the equivalent tokens.'**
  String get aeswap_removeLiquiditySignTxDesc_en;

  /// No description provided for @aeswap_swapSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction sends the amount of the token you want to swap to the pool address, calls the smart contract\'s swap function, and obtains the equivalent token, considering the slippage tolerance.'**
  String get aeswap_swapSignTxDesc_en;

  /// No description provided for @aeswap_withdrawFarmLockSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction calls the smart contract\'s withdraw function with the amount of LP tokens and the associated index of the deposit to execute the withdrawal and claim the associated rewards.'**
  String get aeswap_withdrawFarmLockSignTxDesc_en;

  /// No description provided for @aeswap_withdrawFarmSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction calls the smart contract\'s withdraw function with the amount of LP tokens to execute the withdrawal and claim the associated rewards.'**
  String get aeswap_withdrawFarmSignTxDesc_en;

  /// No description provided for @aeswap_addLiquiditySignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie le montant de chaque jeton de la paire de la pool à l\'adresse de la pool et appelle la fonction d\'ajout de liquidité du contrat intelligent avec le montant minimum pour chaque jeton.'**
  String get aeswap_addLiquiditySignTxDesc_fr;

  /// No description provided for @aeswap_addPoolSignTxDesc1_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie les frais à l\'adresse de la pool pour payer l\'exécution de la création de la pool.'**
  String get aeswap_addPoolSignTxDesc1_fr;

  /// No description provided for @aeswap_addPoolSignTxDesc2_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie le montant de chaque jeton de la paire de la pool à l\'adresse de la pool, appelle la fonction d\'ajout de pool du contrat intelligent avec les adresses de la paire et la nouvelle adresse de la pool, puis appelle la fonction d\'ajout de liquidité du contrat intelligent avec le montant minimum pour chaque jeton.'**
  String get aeswap_addPoolSignTxDesc2_fr;

  /// No description provided for @aeswap_claimFarmSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction appelle la fonction de récupération des récompenses du contrat intelligent pour exécuter la récupération.'**
  String get aeswap_claimFarmSignTxDesc_fr;

  /// No description provided for @aeswap_depositFarmLockSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie les jetons LP à verrouiller dans la farm et appelle la fonction de dépôt du contrat intelligent avec la date de libération des jetons.'**
  String get aeswap_depositFarmLockSignTxDesc_fr;

  /// No description provided for @aeswap_depositFarmSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie le montant de jetons LP à l\'adresse de la farm et appelle la fonction de dépôt du contrat intelligent pour exécuter le dépôt.'**
  String get aeswap_depositFarmSignTxDesc_fr;

  /// No description provided for @aeswap_levelUpFarmLockSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie les jetons LP à reverrouiller dans la farm en appelant la fonction de reverrouillage du contrat intelligent avec la nouvelle date de libération des jetons et l\'index associé du dépôt.'**
  String get aeswap_levelUpFarmLockSignTxDesc_fr;

  /// No description provided for @aeswap_removeLiquiditySignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction brûle le montant de jetons LP que vous souhaitez retirer de la pool et appelle la fonction de retrait de liquidité du contrat intelligent pour obtenir les jetons équivalents.'**
  String get aeswap_removeLiquiditySignTxDesc_fr;

  /// No description provided for @aeswap_swapSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction envoie le montant du jeton que vous souhaitez échanger à l\'adresse de la pool, appelle la fonction d\'échange du contrat intelligent et obtient les jetons équivalents, en tenant compte du slippage.'**
  String get aeswap_swapSignTxDesc_fr;

  /// No description provided for @aeswap_withdrawFarmLockSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction appelle la fonction de retrait du contrat intelligent avec le montant de jetons LP et l\'index associé du dépôt pour exécuter le retrait et réclamer les récompenses associées.'**
  String get aeswap_withdrawFarmLockSignTxDesc_fr;

  /// No description provided for @aeswap_withdrawFarmSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction appelle la fonction de retrait du contrat intelligent avec le montant de jetons LP pour exécuter le retrait et réclamer les récompenses associées.'**
  String get aeswap_withdrawFarmSignTxDesc_fr;

  /// No description provided for @aeswap_poolFarmingAvailable.
  ///
  /// In en, this message translates to:
  /// **'Farming available'**
  String get aeswap_poolFarmingAvailable;

  /// No description provided for @aeswap_poolFarming.
  ///
  /// In en, this message translates to:
  /// **'Farming'**
  String get aeswap_poolFarming;

  /// No description provided for @aeswap_claimFarmLockSignTxDesc_en.
  ///
  /// In en, this message translates to:
  /// **'The transaction calls the smart contract\'s claim function to execute the claim.'**
  String get aeswap_claimFarmLockSignTxDesc_en;

  /// No description provided for @aeswap_claimFarmLockSignTxDesc_fr.
  ///
  /// In en, this message translates to:
  /// **'La transaction appelle la fonction de récupération des récompenses du contrat intelligent pour exécuter la récupération.'**
  String get aeswap_claimFarmLockSignTxDesc_fr;

  /// No description provided for @aeswap_farmLockClaimConfirmInfosText.
  ///
  /// In en, this message translates to:
  /// **'Please confirm the claim of '**
  String get aeswap_farmLockClaimConfirmInfosText;

  /// No description provided for @aeswap_farmLockClaimFinalAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount claimed: '**
  String get aeswap_farmLockClaimFinalAmount;

  /// No description provided for @aeswap_farmLockClaimFormText.
  ///
  /// In en, this message translates to:
  /// **'are available for claiming.'**
  String get aeswap_farmLockClaimFormText;

  /// No description provided for @aeswap_farmLockClaimTxAddress.
  ///
  /// In en, this message translates to:
  /// **'Claim transaction address: '**
  String get aeswap_farmLockClaimTxAddress;

  /// No description provided for @aeswap_farmLockClaimConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get aeswap_farmLockClaimConfirmTitle;

  /// No description provided for @aeswap_farmLockClaimFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get aeswap_farmLockClaimFormTitle;

  /// No description provided for @aeswap_farmLockClaimProcessInterruptionWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to stop the process?'**
  String get aeswap_farmLockClaimProcessInterruptionWarning;

  /// No description provided for @aeswap_farmLockClaimSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'Claim has been done successfully'**
  String get aeswap_farmLockClaimSuccessInfo;

  /// No description provided for @aeswap_farmLockClaimInProgressConfirmAEWallet.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm a transaction in your Archethic Wallet'**
  String get aeswap_farmLockClaimInProgressConfirmAEWallet;

  /// No description provided for @aeswap_farmLockClaimProcessInProgress.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get aeswap_farmLockClaimProcessInProgress;

  /// No description provided for @aeswap_btn_farm_lock_claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get aeswap_btn_farm_lock_claim;

  /// No description provided for @aeswap_btn_confirm_farm_lock_claim.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get aeswap_btn_confirm_farm_lock_claim;

  /// No description provided for @aeswap_claimLockProcessStep0.
  ///
  /// In en, this message translates to:
  /// **'Process not started'**
  String get aeswap_claimLockProcessStep0;

  /// No description provided for @aeswap_claimLockProcessStep1.
  ///
  /// In en, this message translates to:
  /// **'Build transaction'**
  String get aeswap_claimLockProcessStep1;

  /// No description provided for @aeswap_claimLockProcessStep2.
  ///
  /// In en, this message translates to:
  /// **'Claim in progress'**
  String get aeswap_claimLockProcessStep2;

  /// No description provided for @aeswap_claimLockProcessStep3.
  ///
  /// In en, this message translates to:
  /// **'Process finished'**
  String get aeswap_claimLockProcessStep3;

  /// No description provided for @aeswap_farmLockBtnClaim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get aeswap_farmLockBtnClaim;

  /// No description provided for @aeswap_farmLockDetailsLevelSingleRewardsAllocated.
  ///
  /// In en, this message translates to:
  /// **'Rewards allocated per period'**
  String get aeswap_farmLockDetailsLevelSingleRewardsAllocated;

  /// No description provided for @aeswap_farmLockDetailsLevelSingleWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get aeswap_farmLockDetailsLevelSingleWeight;

  /// No description provided for @aeswap_poolTxTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get aeswap_poolTxTypeUnknown;

  /// No description provided for @aeswap_poolTxAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get aeswap_poolTxAccount;

  /// No description provided for @aeswap_poolTxTotalValue.
  ///
  /// In en, this message translates to:
  /// **'Total value:'**
  String get aeswap_poolTxTotalValue;

  /// No description provided for @aeswap_errorDesc1.
  ///
  /// In en, this message translates to:
  /// **'aeSwap'**
  String get aeswap_errorDesc1;

  /// No description provided for @aeswap_errorDesc2.
  ///
  /// In en, this message translates to:
  /// **'Oops! Page not found.'**
  String get aeswap_errorDesc2;

  /// No description provided for @aeswap_errorDesc3.
  ///
  /// In en, this message translates to:
  /// **'Return to Homepage'**
  String get aeswap_errorDesc3;

  /// No description provided for @aeswap_mobileInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Mobile Compatibility'**
  String get aeswap_mobileInfoTitle;

  /// No description provided for @aeswap_mobileInfoTxt1.
  ///
  /// In en, this message translates to:
  /// **'We have detected that you are using a mobile device. Currently, our application is not optimized for mobile devices.\nFor the best experience, we recommend the following options:'**
  String get aeswap_mobileInfoTxt1;

  /// No description provided for @aeswap_mobileInfoTxt2.
  ///
  /// In en, this message translates to:
  /// **'1. Use our application on a desktop computer.'**
  String get aeswap_mobileInfoTxt2;

  /// No description provided for @aeswap_mobileInfoTxt3.
  ///
  /// In en, this message translates to:
  /// **'2. Use our application within your Archethic wallet on iOS, DApps tab.'**
  String get aeswap_mobileInfoTxt3;

  /// No description provided for @aeswap_mobileInfoTxt4.
  ///
  /// In en, this message translates to:
  /// **'Please note that updates for mobile compatibility are coming soon.'**
  String get aeswap_mobileInfoTxt4;

  /// No description provided for @aeswap_mobileInfoTxt5.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your understanding.'**
  String get aeswap_mobileInfoTxt5;
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
