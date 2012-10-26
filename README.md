# Hivelogic Enkoder for Rails

The enkoder_rails plugin provides adds some view helpers to Rails that can be used to
protect email addresses (or other information) by obfuscating them using
JavaScript code. The only way to decrypt the JavaScript is to actually run it,
hiding the results from email-harvesting robots while revealing them to real
people.

It uses a significantly different (and some might say more secure) algorithm
than the built-in mail_to helper.

*Note: There's no guarantee here* -- the only way to be completely safe is to not
publish your address at all.


##Installation

Add to your Gemfile and run the `bundle` command to install it.

 ```ruby
 gem "enkoder_rails", git: "git://github.com/wilg/hivelogic-enkoder-rails.git"
 ```

## Usage

There are two methods:

 ```ruby
 enkode(html)
 ```

This method accepts a block of html (or any text) and returns an enkoded JavaScript.

The second method is:

 ```ruby
 enkode_mail(email, link_text, title_text = nil, subject = nil)
 ```
 
This method takes an email address, the text to show to the viewer, optional
title text (what's seen when somebody hovers over the link), and optional
subject for the email, and returns an enkoded email address link.


## Examples

To enkode a single email address, one could just do:

 ```ruby
 enkode_mail('user@example.com', 'click here')
 ```
 
And the following link would be returned (enkoded as JavaScript):

 ```html
 <a href="mailto:user@example.com" title="">click here</a>
 ```

Adding a title and subject text would require the second two optional fields:

 ```ruby
 enkode_mail('user@domain.com','click here', 'email me', 'enkoder') %>
 ```

And we'd get back (enkoded as JavaScript):

 ```html
 <a href="mailto:user@domain.com?subject=enkoder" title="email me">click here</a>
 ```

To enkode a snippet of XHTML, we can do:

 ```html
 enkode("<p>This block will be hidden from spambots.</p>")
 ```

We could protect a link or block of XHTML from being indexed like this:

 ```html
 enkode('Try and find <a href="secret.html">this</a>, google!')
 ```

We could have anything we wanted in that block, XHTML, links, email addresses, etc.

For more examples and to see the full functionality of the Enkoder, [have a look
its permanent page on the web](http://hivelogic.com/enkoder).

##License

Copyright (c) 2009 Hivelogic Corporation

This plugin is released under the GPL license.  See LICENSE file for details.
