# Character encoding



*under development ... not clear where this is going*

## Character encoding: where it fits in

Main page about character data: [Character vectors](block028_character-data.html)

## Resources

  * [Strings subsection of data import chapter](http://r4ds.had.co.nz/data-import.html#readr-strings) in R for Data Science
  * Screeds on the Minimum Everyone Needs to Know about encoding
    - [The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)](http://www.joelonsoftware.com/articles/Unicode.html)
    - [What Every Programmer Absolutely, Positively Needs To Know About Encodings And Character Sets To Work With Text](http://kunststube.net/encoding/)

## Translating two blog posts from Ruby to R

For now, this page walks through these two mini-tutorials (written for Ruby), but translated to R:

  * [Guide to fixing encoding problems in Ruby](http://www.justinweiss.com/articles/3-steps-to-fix-encoding-problems-in-ruby/)
  * [How to Get From Theyâ€™re to They’re](http://www.justinweiss.com/articles/how-to-get-from-theyre-to-theyre/)
  
Don't expect much creativity from me here. My goal is faithful translation.

## What is an encoding?

Look at the string `"hello!"` in bytes. *Ruby*
 
```ruby
irb(main):001:0> "hello!".bytes
=> [104, 101, 108, 108, 111, 33]
```
 
The base function `charToRaw()` "converts a length-one character string to raw bytes. It does so without taking into account any declared encoding". It displays bytes in hexadecimal. Use `as.integer()` to convert to decimal, which is more intuitive and allows us to compare against the Ruby results.


```r
charToRaw("hello!")
#> [1] 68 65 6c 6c 6f 21
as.integer(charToRaw("hello!"))
#> [1] 104 101 108 108 111  33
```

Use a character less common in English: *Ruby*

```
irb(main):002:0> "hellṏ!".bytes
=> [104, 101, 108, 108, 225, 185, 143, 33]
```


```r
charToRaw("hellṏ!")
#> [1] 68 65 6c 6c e1 b9 8f 21
as.integer(charToRaw("hellṏ!"))
#> [1] 104 101 108 108 225 185 143  33
```

Now we see that it takes more than one byte to represent `"ṏ"`. Three in fact: [225, 185, 143]. The encoding of a string defines this relationship: encoding is a map between one or more bytes and a displayable character.

Take a look at what a single set of bytes looks like when you try different encodings.

Here's, a string encoded as ISO-8859-1 (also known as "Latin1") with a special character. *Ruby*

```
irb(main):003:0> str = "hellÔ!".encode("ISO-8859-1"); str.encode("UTF-8")
=> "hellÔ!"

irb(main):004:0> str.bytes
=> [104, 101, 108, 108, 212, 33]
```


```r
string_latin <- iconv("hellÔ!", from = "UTF-8", to = "Latin1")
string_latin
#> [1] "hell\xd4!"
charToRaw(string_latin)
#> [1] 68 65 6c 6c d4 21
as.integer(charToRaw(string_latin))
#> [1] 104 101 108 108 212  33
```

We've confirmed that we have the correct bytes (meaning the same as the Ruby example). What would that string look like interpreted as ISO-8859-5 instead? *Ruby*

```
irb(main):005:0> str.force_encoding("ISO-8859-5"); str.encode("UTF-8")
=> "hellд!"
```


```r
iconv(string_latin, from = "ISO-8859-5", to = "UTF-8")
#> [1] "hellд!"
```

It's garbled, which is your first tip-off to an encoding problem.

Also not all strings can be represented in all encodings: *Ruby*

```
irb(main):006:0> "hi∑".encode("Windows-1252")
Encoding::UndefinedConversionError: U+2211 to WINDOWS-1252 in conversion from UTF-8 to WINDOWS-1252
 from (irb):61:in `encode'
 from (irb):61
 from /usr/local/bin/irb:11:in `<main>'
```


```r
(string <- "hi∑")
#> [1] "hi∑"
Encoding(string)
#> [1] "unknown"
as.integer(charToRaw(string))
#> [1] 104 105 226 136 145
(string_windows <- iconv(string, from = "UTF-8", to = "Windows-1252"))
#> [1] NA
```

In Ruby, apparently that is an error. In R, we just get `NA`. Alternatively, and somewhat like Ruby, you can specify a substitution for non-convertible bytes.


```r
(string_windows <- iconv(string, from = "UTF-8", to = "Windows-1252", sub = "?"))
#> [1] "hi???"
```

In the Ruby post, we've seen 3 string functions so far. Review and note which R function was used in the translation.

  * `encode` translates a string to another encoding. We've used `iconv(x, from = "UTF-8", to = <DIFFERENT_ENCODING>)` here.
  * `bytes` shows the bytes that make up a string. We've used `charToRaw()`, which returns hexadecimal in R. For the sake of comparison to the Ruby post, I've converted to decimal with `as.integer()`.
  * `force_encoding` shows what the input bytes would look like if interpreted by a different encoding. We've used `iconv(x, from = <DIFFERENT_ENCODING>, to = "UTF-8")`.

## A three-step process for fixing encoding bugs

### Discover which encoding your string is actually in.

Shhh. Secret: this is encoded as Windows-1252. `\x99` should be the trademark symbol ™. Ruby can guess at the encoding. *Ruby*

```ruby
irb(main):078:0> "hi\x99!".encoding
=> #<Encoding:UTF-8>
```

Ruby's guess is bad. This is not encoded as UTF-8. R admits it doesn't know and `stringi`'s guess is not good.


```r
string <- "hi\x99!"
string
#> [1] "hi\x99!"
Encoding(string)
#> [1] "unknown"
stringi::stri_enc_detect(string)
#> [[1]]
#> [[1]]$Encoding
#> [1] "UTF-16BE" "UTF-16LE" "EUC-JP"   "EUC-KR"  
#> 
#> [[1]]$Language
#> [1] ""   ""   "ja" "ko"
#> 
#> [[1]]$Confidence
#> [1] 0.1 0.1 0.1 0.1
```

Advice given in post is to sleuth it out based on where the data came from or to look at encoding tables. With larger amounts of text, each language's guessing facilities presumably do better than they do here.

### Decide which encoding you want the string to be

That's easy. UTF-8. Done.

### Re-encode your string

```
irb(main):088:0> "hi\x99!".encode("UTF-8", "Windows-1252")
=> "hi™!"
```


```r
string_windows <- "hi\x99!"
string_utf8 <- iconv(string_windows, from = "Windows-1252", to = "UTF-8")
Encoding(string_utf8)
#> [1] "UTF-8"
string_utf8
#> [1] "hi™!"
```

## How to Get From Theyâ€™re to They’re

Moving on to the second blog post now.

### Multi-byte characters

Since we need to represent more than 256 characters, not all can be represented by a single byte. Let's look at the curly single quote. *Ruby*

```
irb(main):001:0> "they’re".bytes
=> [116, 104, 101, 121, 226, 128, 153, 114, 101]
```


```r
string_curly <- "they’re"
charToRaw(string_curly)
#> [1] 74 68 65 79 e2 80 99 72 65
as.integer(charToRaw(string_curly))
#> [1] 116 104 101 121 226 128 153 114 101
length(as.integer(charToRaw(string_curly)))
#> [1] 9
nchar(string_curly)
#> [1] 7
```

The string has 7 characters, but 9 bytes, because we're using 3 bytes to represent the curly single quote. Let's focus just on that. *Ruby*

```
irb(main):002:0> "’".bytes
=> [226, 128, 153]
```


```r
charToRaw("’")
#> [1] e2 80 99
as.integer(charToRaw("’"))
#> [1] 226 128 153
length(as.integer(charToRaw("’")))
#> [1] 3
```

One of the most common encoding fiascos you'll see is this: theyâ€™re. Note that the curly single quote has been turned into a 3 character monstrosity. This is no coincidence. Remember those 3 bytes?

This is what happens when you interpret bytes that represent text in the UTF-8 encoding as if it's encoded as Windows-1252. Learn to recognize it. *Ruby*

```
irb(main):003:0> "they’re".force_encoding("Windows-1252").encode("UTF-8")
=> "theyâ€™re"
```


```r
(string_mis_encoded <- iconv(string_curly, to = "UTF-8", from = "windows-1252"))
#> [1] "theyâ€™re"
```

Let's assume this little gem is buried in some large file and you don't immediately notice. So this string is interpreted with the wrong encoding, i.e. stored as the wrong bytes, either in an R object or in a file on disk. Now what?

Let's review the original, correct bytes vs. the current, incorrect bytes and print the associated strings.


```r
as.integer(charToRaw(string_curly))
#> [1] 116 104 101 121 226 128 153 114 101
as.integer(charToRaw(string_mis_encoded))
#>  [1] 116 104 101 121 195 162 226 130 172 226 132 162 114 101
string_curly
#> [1] "they’re"
string_mis_encoded
#> [1] "theyâ€™re"
```

### Encoding repair

How do you fix this? You have to reverse your steps. You have a UTF-8 encoded string. Convert it back to Windows-1252, to get the original bytes. Then re-encode that as UTF-8. *Ruby*

```
irb(main):006:0> "theyâ€™re".encode("Windows-1252").force_encoding("UTF-8")
=> "they’re"
```


```r
string_mis_encoded
#> [1] "theyâ€™re"
backwards_one <- iconv(string_mis_encoded, from = "UTF-8", to = "Windows-1252")
backwards_one
#> [1] "they’re"
Encoding(backwards_one)
#> [1] "unknown"
as.integer(charToRaw(backwards_one))
#> [1] 116 104 101 121 226 128 153 114 101
as.integer(charToRaw(string_curly))
#> [1] 116 104 101 121 226 128 153 114 101
```

