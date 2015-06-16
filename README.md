# Spree Print Invoice

[![Build Status](https://travis-ci.org/spree-contrib/spree_print_invoice.svg?branch=master)](https://travis-ci.org/spree-contrib/spree_print_invoice)
[![Code Climate](https://codeclimate.com/github/spree-contrib/spree_print_invoice/badges/gpa.svg)](https://codeclimate.com/github/spree-contrib/spree_print_invoice)

This extension provides two things:

 * A model `Spree::Invoice`, which is generated when an order is completed or a reimbursement is created. It holds a date and a contiguous invoice number to comply with European tax regulation.
 * A model `Spree::BookkeepingDocument`, which generates PDFs from any Spree Object with the help of View objects that translate between different object structures and PDF templates.

The Gem contains example implementations for Invoices for `Spree::Order` as well as `Spree::Reimbursement`. The basic structure looks like this:

`Spree::BookkeepingDocument` takes as constructor arguments a `printable` (polymorphic AR object) and a `template` (string). It then passes on all actual data generation to a ViewObject. You can find these objects in `app/spree/printables/#{printable}/#{template}_view.rb`. The object will be instantiated upon PDF generation (look at the `Spree::BookkeepingDocument#render_pdf` method to see how it's done).

`Spree::Order` and `Spree::Reimbursement` are patched so that they generate both an invoice number and date and a PDF.

In the `Spree::Admin::OrdersController#show` view, you'll find an additional button `Documents`, where all printable documents will be listed.

## Installation

Add to your `Gemfile`
```ruby
gem 'spree_print_invoice', github: 'spree-contrib/spree_print_invoice', branch: 'master'
```

Run
```
bundle && exec rails g spree_print_invoice:install
```

Enjoy! Now you can generate invoices and packaging slips with sequential numbers from arbitrary Spree objects.

---

## Configuration and extending slips

1. Set the logo path preference to include your store / company logo.

  ```ruby
  Spree::PrintInvoice::Config.set(logo_path: '/path/to/public/images/company-logo.png')
  ```

2. Add your own own footer texts to the locale. The current footer works with `:footer_left1` , `:footer_left2` and `:footer_right1`, `:footer_right2` where the 1 version is on the left in bold, and the 2 version the "value" on the right.

3. Override any of the partial templates. They are address, footer, totals, header, bye, and the line_items. In bye the text `:thanks` is printed. The `:extra_note` hook has been deprecated as Spree no longer supports hooks.

4. Many european countries requires numeric and sequential invoices numbers. To use invoices sequential number fill the specific field in "General Settings" or by setting:

  ```ruby
  Spree::PrintInvoice::Config.set(next_number: [1|'your current next invoice number'])
  ```

  The next invoice number will be the one that you specified. You will able to increase it in any moment, for example, to re-sync invoices number if you are making invoices also in other programs for the same business name.

5. Set page/document options with:

  ```ruby
  Spree::PrintInvoice::Config.set(prawn_options: { page_layout: :landscape, page_size: 'A4', margin: [50, 100, 150, 200] })
  ```

6. Enable PDF storage feature

  PDF files can be stored to disk. This is very handy, if you want to send these files as email attachment.

  ```ruby
  Spree::PrintInvoice::Config.set(store_pdf: true) # Default: false
  Spree::PrintInvoice::Config.set(storage_path: 'pdfs/orders') # Default: tmp/order_prints
  ```

  *) Inside the `storage_path` a folder for each template will be created. Files will be saved with order number respectively invoice number as file name.

## Customize templates

In order to customize the build in invoice and packaging slip templates you need to copy them into your app:

```sh
$ bundle exec rails g spree_print_invoice:templates
```

You can then customize them at the following locations:

 * `app/views/spree/printables/order/invoice.pdf.prawn`
 * `app/views/spree/printables/reimbursement/invoice.pdf.prawn`
 * `app/views/spree/printables/order/packaging_slip.pdf.prawn`.

---

## Contributing

See corresponding [guidelines][1]

---

## License

Copyright (c) 2011-2015 [Spree Commerce][2], and other [contributors][3], released under the [New BSD License][4]

[1]: https://github.com/spree-contrib/spree_print_invoice/blob/master/CONTRIBUTING.md
[2]: https://github.com/spree
[3]: https://github.com/spree-contrib/spree_print_invoice/contributors
[4]: https://github.com/spree-contrib/spree_print_invoice/blob/master/LICENSE.md
