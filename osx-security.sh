#!/bin/bash
#
# OSX Hardening Snippets
# Original Source: github.com/drduh/macOS-Security-and-Privacy-Guide

########################################################
# Full disk encryption
########################################################

# enforce hibernation and evict FileVault keys from
# memory instead of traditional sleep to memory
sudo pmset -a destroyfvkeyonstandby 1
sudo pmset -a hibernatemode 25

# also modify standby and power nap settings to match
# github.com/drduh/OS-X-Security-and-Privacy-Guide/issues/124
sudo pmset -a powernap 0
sudo pmset -a standby 0
sudo pmset -a standbydelay 0
sudo pmset -a autopoweroff 0

########################################################
# Firewall
########################################################

# Enable the firewall:
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Enable logging:
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on

# Enable stealth mode:
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Prevent built-in software as well as code-signed,
# downloaded software from being whitelisted automatically:
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off

# After interacting with socketfilterfw, restart terminate the process:
sudo pkill -HUP socketfilterfw

########################################################
# Captive portal
########################################################

# When macOS connects to new networks, it probes the network & launches
# Captive Portal assistant utility if connectivity can't be determined.

# Disable this feature:
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control.plist Active -bool false

########################################################
# Curl
########################################################

# Default macOS Curl uses Secure Transport for SSL/TLS validation.

# To use OpenSSL, install with brew
brew install curl-openssl

# ensure it's the default:
brew link --force curl

# Add to ~/.curlcr :
############################
# user-agent = "Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101 Firefox/45.0"
# referer = ";auto"
# connect-timeout = 10
# progress-bar
# max-time = 90
# verbose
# show-error
# remote-time
# ipv4

########################################################
# PGP/GPG
########################################################

brew install gnupg2

# Add th following to ~/.gnupg/gpg.conf:
############################
# auto-key-locate keyserver
# keyserver hkps://hkps.pool.sks-keyservers.net
# keyserver-options no-honor-keyserver-url
# keyserver-options ca-cert-file=/etc/sks-keyservers.netCA.pem
# keyserver-options no-honor-keyserver-url
# keyserver-options debug
# keyserver-options verbose
# personal-cipher-preferences AES256 AES192 AES CAST5
# personal-digest-preferences SHA512 SHA384 SHA256 SHA224
# default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed
# cert-digest-algo SHA512
# s2k-digest-algo SHA512
# s2k-cipher-algo AES256
# charset utf-8
# fixed-list-mode
# no-comments
# no-emit-version
# keyid-format 0xlong
# list-options show-uid-validity
# verify-options show-uid-validity
# with-fingerprint
############################

# Install the keyservers CA certificate to configure GnuPG to use
# SSL when fetching new keys and prefer strong cryptographic primitives.
curl -O https://sks-keyservers.net/sks-keyservers.netCA.pem
sudo mv sks-keyservers.netCA.pem /etc

# generate gpg key
# github.com/ioerror/duraconf/blob/master/configs/gnupg/gpg.conf
gpg --gen-key

########################################################
# System Integrity Protection
########################################################

# verify it is enabled
csrutil status

# if not, enable it with:
# $ csrutil enable

########################################################
# Quarantine
########################################################

# Quarantine stores information about downloaded files in
# ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2

# Examine the file to see what is stored:
# $ sudo chflags schg ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2

# To permanently disable feature, clear the file:
:>~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2

# ...and make it immutable:
sudo chflags schg ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2
