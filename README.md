# Random

[![Travis](https://img.shields.io/travis/RichardSlater/atom-random.svg?style=flat-square&label=linux%20and%20osx%20build)](https://travis-ci.org/RichardSlater/atom-random) [![AppVeyor](https://img.shields.io/appveyor/ci/richard-slater/atom-random/master.svg?style=flat-square&label=windows%20build)](https://ci.appveyor.com/project/richard-slater/atom-random) [![Code Climate](https://img.shields.io/codeclimate/github/RichardSlater/atom-random.svg?style=flat-square)](https://codeclimate.com/github/RichardSlater/atom-random) [![Downloads](https://img.shields.io/apm/dm/random.svg?style=flat-square)](https://atom.io/packages/random) [![APM Version](https://img.shields.io/apm/v/random.svg?style=flat-square)](https://atom.io/packages/random) [![David](https://img.shields.io/david/RichardSlater/atom-random.svg?style=flat-square)](https://david-dm.org/RichardSlater/atom-random) ![Apache2 Licenced](https://img.shields.io/apm/l/random.svg?style=flat-square) [![Gitter](https://img.shields.io/gitter/room/RichardSlater/atom-random.js.svg?style=flat-square)](https://gitter.im/RichardSlater/atom-random)

Generates random data directly in Atom using the excellent [Chance](http://chancejs.com/) library written by [Victor Quinn](https://www.victorquinn.com/).  All supported random data types are directly accessible from the [command palette](https://atom.io/packages/command-palette), <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>P</kbd>, and from the `Random` menu.  If you are commonly using a particular data type then you can also bind it in your [keymap](http://flight-manual.atom.io/behind-atom/sections/keymaps-in-depth/).

![Screenshot of Random Package](https://cdn.rawgit.com/RichardSlater/atom-random/v0.1.4/assets/screenshot.gif)

[![Support via Gratipay](https://cdn.rawgit.com/RichardSlater/open-source-gratitude-buttons/1.0.0/icons/en-GB/support-via-gratipay.svg)](https://gratipay.com/~RichardSlater/) [![Flattr Atom Random](https://cdn.rawgit.com/RichardSlater/open-source-gratitude-buttons/1.0.0/icons/en-GB/support-via-flattr.svg)](https://flattr.com/submit/auto?user_id=RichardSlater&url=http://github.com/RichardSlater/atom-random&title=Atom%20Random&language=en_GB&tags=github&category=software)

## Bind a Keyboard Shortcut

Each random data type can be accessed from the command palette by pressing <kbd>Ctrl</kbd>-<kbd>Shift</kbd>-<kbd>P</kbd> then by typing `Random` followed by the data type, however if you are using a particular data type frequently you might want to bind keyboard shortcut to save you time.

Fortunately Atom makes this incredibly easy, simply go to `File` &rarr; `Keymap...` and scroll to the bottom of the `keymap.cson` file that opens.  Paste the following at the bottom of the file:

    'atom-text-editor':
       'ctrl-alt-shift-g': 'random:guid'

This will map the key press <kbd>Ctrl</kbd>-<kbd>Alt</kbd>-<kbd>Shift</kbd>-<kbd>G</kbd> to generate a new random GUID.  You can select any random data type from the list below.

## Reseed Chance

This package is entirely based around the superb [Chance](http://chancejs.com/) library written by [Victor Quinn](https://www.victorquinn.com/), by default this library uses a [Mersenne Twister](https://en.wikipedia.org/wiki/Mersenne_Twister) to generate a pseudo-random seed which is used for all subsequent random data generation.  If you want to use an external random data source you simply call the `Reseed` command from the Atom Command Palette this will make a call out to [Random.org's Integer Generator](https://www.random.org/integers/) to reseed the random number generator.

![Reseed using RANDOM.ORG](https://cdn.rawgit.com/RichardSlater/atom-random/v0.1.4/assets/reseed.gif)

## List of Supported Data Types

- **String**: random:string
- **GUID / UUID**: random:guid
- **Integer**: random:integer
- **Boolean**: random:boolean
- **Character**: random:character
- **Floating Point Number**: random:floating
- **Natural**: random:natural
- **Paragraph**: random:paragraph
- **Sentence**: random:sentence
- **Syllable**: random:syllable
- **Word**: random:word
- **Age**: random:age
- **Birthday**: random:birthday
- **First Name**: random:firstname
- **Last Name**: random:lastname
- **Gender**: random:gender
- **Name**: random:name
- **Prefix**: random:prefix
- **Social Security Number**: random:ssn
- **Suffix**: random:suffix
- **Android ID**: random:android_id
- **Apple Token**: random:apple_token
- **BlackBerry Device PIN**: random:bb_pin
- **Windows Phone 7 ANID**: random:wp7_anid
- **Windows Phone 8 ANID2**: random:wp8_anid2
- **Gravatar**: random:avatar
- **Color**: random:color
- **Domain**: random:domain
- **E-mail**: random:email
- **Facebook ID**: random:fbid
- **Google Analytics Tracking Code**: random:google_analytics
- **Hashtag**: random:hashtag
- **IPv4 Address**: random:ip
- **IPv6 Address**: random:ipv6
- **Klout**: random:klout
- **Top Level Domain Name**: random:tld
- **Twitter**: random:twitter
- **URL**: random:url
- **Address**: random:address
- **Altitude**: random:altitude
- **Area Code**: random:areacode
- **City**: random:city
- **Coordinates**: random:coordinates
- **Country**: random:country
- **Phone Number**: random:phone
- **Postal**: random:postal
- **Province**: random:province
- **State**: random:state
- **Street**: random:street
- **U.S. ZIP Code**: random:zip
- **Date**: random:date
- **Date (ISO 8601)**: random:isodate
- **Hammertime**: random:hammertime
- **Month**: random:month
- **Year**: random:year
- **Timestamp**: random:timestamp
- **Credit Card Number**: random:creditcard
- **Credit Card Type**: random:cc_type
- **Currency**: random:currency
- **Currency Pair**: random:currency_pair
- **Dollar Amount**: random:dollar
- **Credit Card Expiration**: random:exp
- **Credit Card Expiration Month**: random:exp_month
- **Credit Card Expiration Year**: random:exp_year
- **4-Sided Dice**: random:d4
- **6-Sided Dice**: random:d6
- **8-Sided Dice**: random:d8
- **10-Sided Dice**: random:d10
- **12-Sided Dice**: random:d12
- **20-Sided Dice**: random:d20
- **30-Sided Dice**: random:d30
- **100-Sided Dice**: random:d100
- **Hash**: random:hash
- **Normally Distributed Value**: random:normal
- **Radio Station**: random:radio
- **TV Station**: random:tv
- **Latitude**: random:latitude
- **Longitude**: random:longitude
- **Password (8 Characters)**: random:8-character-password
- **Password (10 Characters)**: random:10-character-password
- **Password (20 Characters)**: random:20-character-password
- **MAC Address**: random:mac_address

## Copyright and Licence

    © 2016 Richard Slater

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
