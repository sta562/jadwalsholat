# Twitter Bot Jadwal Sholat 

Aplikasi jadwal sholat online bot menggunakan Twitter

## Deskripsi

Returns all prayer times for a specific date in a particular city using [aladhan API](https://aladhan.com/prayer-times-api).

## Parameter

- `date_or_timestamp` (string) - A date in the DD-MM-YYYY format or UNIX timestamp. Default's to the current date.
- `city` (string) - A city name. Example: London
- `country` (string) - A country name or 2 character alpha ISO 3166 code. Examples: GB or United Kindom
- `state` (string) - State or province. A state name or abbreviation. Examples: Colorado / CO / Punjab / Bengal
- `method` (number) - A prayer times calculation method. Methods identify various schools of thought about how to compute the timings. If not specified, it defaults to the closest authority based on the location or co-ordinates specified in the API call. This parameter accepts values from 0-12 and 99, as specified below:

    * 0 - Shia Ithna-Ansari
    * 1 - University of Islamic Sciences, Karachi
    * 2 - Islamic Society of North America
    * 3 - Muslim World League
    * 4 - Umm Al-Qura University, Makkah
    * 5 - Egyptian General Authority of Survey
    * 7 - Institute of Geophysics, University of Tehran
    * 8 - Gulf Region
    * 9 - Kuwait
    * 10 - Qatar
    * 11 - Majlis Ugama Islam Singapura, Singapore
    * 12 - Union Organization islamic de France
    * 13 - Diyanet İşleri Başkanlığı, Turkey
    * 14 - Spiritual Administration of Muslims of Russia
    * 15 - Moonsighting Committee Worldwide (also requires shafaq paramteer)
    * 99 - Custom. See https://aladhan.com/calculation-methods

- `shafaq` (string) - Which Shafaq to use if the method is Moonsighting Commitee Worldwide. Acceptable options are 'general', 'ahmer' and 'abyad'. Defaults to 'general'.
- `tune` (string) - Comma Separated String of integers to offset timings returned by the API in minutes. Example: 5,3,5,7,9,7. See https://aladhan.com/calculation-methods
- `school` (number) - 0 for Shafi (or the standard way), 1 for Hanafi. If you leave this empty, it defaults to Shafii.
- `midnightMode` (number) - 0 for Standard (Mid Sunset to Sunrise), 1 for Jafari (Mid Sunset to Fajr). If you leave this empty, it defaults to Standard.
- `latitudeAdjustmentMethod` (number) - Method for adjusting times higher latitudes - for instance, if you are checking timings in the UK or Sweden.

    * 1 - Middle of the Night
    * 2 - One Seventh
    * 3 - Angle Based

- `adjustment` (number) - Number of days to adjust hijri date(s). Example: 1 or 2 or -1 or -2
- `iso8601` (boolean) - Whether to return the prayer times in the iso8601 format. Example: true will return 2020-07-01T02:56:00+01:00 instead of 02:56