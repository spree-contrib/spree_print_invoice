# Prawn-handler

A Rails template handler for PDF library [Prawn](http://prawn.majesticseacreature.com/). You can find a more detailed description in its [introduction article](http://roman.flucti.com/alternative-prawn-handler-for-rails).

There already exists [prawnto](http://cracklabs.com/prawnto) but it's too bloated for my taste. Prawn-handler is lightweight, simple, and less of a hassle to use.

## Usage

3.  Name PDF view files like `foo.pdf.prawn`. Inside, use the `pdf` method to access a `Prawn::Document` object. In addition, this handler allows for lazy method calls: you don't have to specify the receiver explicitely, which cleans up the resulting view code.

    For example, the following code with formal calls:

        pdf.bounding_box [100, 600], :width => 200 do
          pdf.text "The rain in spain falls mainly on the plains " * 5
          pdf.stroke do
            pdf.line pdf.bounds.top_left,    pdf.bounds.top_right
            pdf.line pdf.bounds.bottom_left, pdf.bounds.bottom_right
          end
        end

    Is equivalent to this one with lazy calls:

        bounding_box [100, 600], :width => 200 do
          text "The rain in spain falls mainly on the plains " * 5
          stroke do
            line bounds.top_left,    bounds.top_right
            line bounds.bottom_left, bounds.bottom_right
          end
        end

    This is accomplished without `instance_eval`, so that access to instance variables set by the controller is retained.

## Credits

Initially written by [Roman Le Négrate](http://roman.flucti.com) ([contact](mailto:roman.lenegrate@gmail.com)). 
Released under the MIT-license: see the `LICENSE` file.
Adopted to Rails 3 by  [Torsten Rüger](http://github.com/dancinglightning)