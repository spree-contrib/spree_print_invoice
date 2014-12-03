# Spree Print Invoice

[![Build Status](https://travis-ci.org/spree-contrib/spree_print_invoice.svg?branch=master)](https://travis-ci.org/spree-contrib/spree_print_invoice)
[![Code Climate](https://codeclimate.com/github/spree-contrib/spree_print_invoice/badges/gpa.svg)](https://codeclimate.com/github/spree-contrib/spree_print_invoice)

This extension provides a "Print Invoice" button (per default) on the Admin Orders view screen which generates a PDF of the order details. It's fully extendable so you can add own _print slips_ from your own Rails app. It also comes with a packaging slip.

## Installation

Add to your `Gemfile`
```ruby
gem 'spree_print_invoice', github: 'spree-contrib/spree_print_invoice', branch: 'master'
```

Run
```
bundle install
rails g spree_print_invoice:install
```

Enjoy! Now allow to generate invoices with sequential numbers.

---

## Configuration and extending slips

1. Set the logo path preference to include your store / company logo.

```ruby
Spree::PrintInvoice::Config.set(logo_path: '/path/to/public/images/company-logo.png')
```

2. Add your own own footer texts to the locale. The current footer works with `:footer_left1` , `:footer_left2` and `:footer_right1`, `:footer_right2` where the 1 version is on the left in bold, and the 2 version the "value" on the right.

3. Override any of the partial templates. They are address, footer, totals, header, bye, and the line_items. In bye the text `:thanks` is printed. The `:extra_note` hook has been deprecated as Spree no longer supports hooks.

4. Set `:suppress_anonymous_address` option to get blank addresses for anonymous email addresses (as created by my spree_last_address extension for empty/unknown user info).

5. Many european countries requires numeric and sequential invoices numbers. To use invoices sequential number fill the specific field in "General Settings" or by setting:

```ruby
Spree::PrintInvoice::Config.set(next_number: [1|{your current next invoice number}])
```

The next invoice number will be the one that you specified. You will able to increase it in any moment, for example, to re-sync invoices number if you are making invoices also in other programs for the same business name.

6. Enable packaging slips, by setting:

```ruby
Spree::PrintInvoice::Config.set(print_buttons: 'invoice,packaging_slip') # comma separated list
```

Use above feature for your own template if you want. For each button_name, define `button_name_print` text in your locale.

7. Set page/document options with:

```ruby
Spree::PrintInvoice::Config.set(prawn_options: { page_layout: :landscape, page_size: 'A4', margin: [50, 100, 150, 200] })
```

---

## Contributing

See corresponding [guidelines][1]

---

## License

Copyright (c) 2011-2014 [Spree Commerce][2], and other [contributors][3], released under the [New BSD License][4]

[1]: https://github.com/spree-contrib/spree_print_invoice/blob/master/CONTRIBUTING.md
[2]: https://github.com/spree
[3]: https://github.com/spree-contrib/spree_print_invoice/contributors
[4]: https://github.com/spree-contrib/spree_print_invoice/blob/master/LICENSE.md
