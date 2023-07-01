# Copyright (C) 2022 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Handle various build version information.
#
# Guarantees that the following are defined:
#     STATIX_MAJOR_VERSION
#     STATIX_MINOR_VERSION
#     STATIX_BUILD_VARIANT
#

# This is the global STATIX version flavor that determines the focal point
# behind our releases. This is bundled alongside $(STATIX_MINOR_VERSION)
# and only changes per major Android releases.
STATIX_MAJOR_VERSION := v6.3
STATIX_PLATFORM_VERSION := 13

# The version code is the upgradable portion during the cycle of
# every major Android release. Each version code upgrade indicates
# our own major release during each lifecycle.
ifdef STATIX_BUILDVERSION
    STATIX_MINOR_VERSION := $(STATIX_BUILDVERSION)
else
    STATIX_MINOR_VERSION := 1
endif

# Build Variants
#
# Alpha: Development / Test releases
# Beta: Public releases with CI
# Release: Final Product | No Tagging
ifdef STATIX_BUILDTYPE
  ifeq ($(STATIX_BUILDTYPE), ALPHA)
      STATIX_BUILD_VARIANT := alpha
  else ifeq ($(STATIX_BUILDTYPE), BETA)
      STATIX_BUILD_VARIANT := beta
  else ifeq ($(STATIX_BUILDTYPE), RELEASE)
      STATIX_BUILD_VARIANT := release
  endif
else
  STATIX_BUILD_VARIANT := unofficial
endif

# Build Date
BUILD_DATE := $(shell date -u +%Y%m%d)

# STATIX Version
TMP_STATIX_VERSION := $(STATIX_MAJOR_VERSION)-
ifeq ($(filter release,$(STATIX_BUILD_VARIANT)),)
    TMP_STATIX_VERSION += $(STATIX_BUILD_VARIANT)-
endif
ifeq ($(filter unofficial,$(STATIX_BUILD_VARIANT)),)
    TMP_STATIX_VERSION += $(STATIX_MINOR_VERSION)-
endif
TMP_STATIX_VERSION += $(STATIX_BUILD)-$(BUILD_DATE)
STATIX_VERSION := $(shell echo $(TMP_STATIX_VERSION) | tr -d '[:space:]')

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.statix.version=$(STATIX_VERSION)

# The properties will be uppercase for parse by Settings, etc.
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.statix.version.major=$(shell V1=$(STATIX_MAJOR_VERSION); echo $${V1^}) \
    ro.statix.version.minor=$(STATIX_MINOR_VERSION) \
    ro.statix.build.variant=$(shell V2=$(STATIX_BUILD_VARIANT); echo $${V2^})
