defmodule FinalProjectWeb.ValidInputs do
  alias Phoenix.HTML.Form

  def text_input(form, field, opts \\ []) do
    Form.text_input(form, field, opts ++ Form.input_validations(form, field))
  end

  def number_input(form, field, opts \\ []) do
    Form.number_input(form, field, opts ++ Form.input_validations(form, field))
  end
end
