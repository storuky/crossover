class CrossoverFormBuilder < OxymoronFormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def angular_text method, options = {}
    options = options.merge({
      "ta-toolbar" => "taToolbar",
      "text-angular" => "",
      "ng-model" => options["ng-model"] || ng_model("#{method}")
    })

    @template.content_tag :div, nil, options
  end
end