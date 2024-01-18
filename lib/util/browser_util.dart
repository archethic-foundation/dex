/// SPDX-License-Identifier: AGPL-3.0-or-later

export 'browser_util_desktop.dart'
    if (dart.library.io) 'browser_util_desktop.dart'
    if (dart.library.js) 'browser_util_desktop.dart';
