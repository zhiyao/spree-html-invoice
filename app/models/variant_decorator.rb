Variant.class_eval do 
  def presentation
    on = option_values.first
    on ? on.presentation : nil 
  end

  def presentation= val
    on = option_values.first
    if on
      on.name = val
      on.presentation = val
      on.save!
    end
  end
end
