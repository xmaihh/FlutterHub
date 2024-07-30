#!/bin/bash
#########################################################
# Script Name: Localization Automation Script
# Description: This script automates the process of generating
#              and extracting localization files using Dart.
#              It extracts ARB files from Dart code and then
#              generates localization files.
# Date       : 2024-07-30
# Version    : 1.0
# License    : MIT
# Usage      : ./localization_script.sh
# Platform   : All Linux Based Platforms
# Dependencies: Dart SDK, intl_generator package
#########################################################

# Run the intl_generator to extract messages to ARB files
dart run intl_generator:extract_to_arb --output-dir=l10n-arb lib/l10n/localization_intl.dart

# Run the intl_generator to generate Dart localization files from ARB files
dart run intl_generator:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localization_intl.dart l10n-arb/intl_*.arb