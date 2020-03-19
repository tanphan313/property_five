class SearchParams
  attr_reader :params, :map_attr_constant

  def initialize params, map_attr_constant
    @params = params
    @map_attr_constant = map_attr_constant
  end

  class << self
    def call params, map_attr_constant
      SearchParams.new(params, map_attr_constant).call
    end
  end

  def call
    search_params = {}
    map_attr_constant.each do |form_param, ransack_params|
      if params[form_param].present?
        search_params.merge! ransack_params => params[form_param]
      end
    end
    search_params
  end
end
