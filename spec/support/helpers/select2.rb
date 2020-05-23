# frozen_string_literal: true

module Select2
  def select_select2_dropdown(selector, value)
    first("#s2id_#{selector}.select2-container").click
    find('.select2-search .select2-input').send_keys(value, :enter)
  end
end
