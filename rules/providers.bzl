# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Providers for license rules."""

LicenseKindInfo = provider(
    doc = """Provides information about a license_kind instance.""",
    fields = {
        "conditions": "list(string): List of conditions to be met when using this packages under this license.",
        "label": "Label: The full path to the license kind definition.",
        "long_name": "string: Human readable license name",
        "name": "string: Canonical license name",
    },
)

LicenseInfo = provider(
    doc = """Provides information about a license instance.""",
    fields = {
        "copyright_notice": "string: Human readable short copyright notice",
        "label": "Label: label of the license rule",
        "license_kinds": "list(LicenseKindInfo): License kinds ",
        "license_text": "string: The license file path",
        "namespace": "string: namespace of the license rule",
        # TODO(aiuto): move to PackageInfo
        "package_name": "string: Human readable package name",
        "package_url": "URL from which this package was downloaded.",
        "package_version": "Human readable version string",
    },
)

LicensedTargetInfo = provider(
    doc = """Lists the licenses directly used by a single target.""",
    fields = {
        "target_under_license": "Label: The target label",
        "licenses": "list(label of a license rule)",
    },
)

def licenses_info():
    return provider(
        doc = """The transitive set of licenses used by a target.""",
        fields = {
            "target_under_license": "Label: The top level target label.",
            "deps": "depset(LicensedTargetInfo): The transitive list of dependencies that have licenses.",
            "licenses": "depset(LicenseInfo)",
            "traces": "list(string) - diagnostic for tracing a dependency relationship to a target.",
        },
    )

# This provider is used by the aspect that is used by manifest() rules.
TransitiveLicensesInfo = licenses_info()
