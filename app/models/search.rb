class Search < ApplicationRecord
  self.primary_key = "searchable_id"
  self.table_name = "searches"

  belongs_to :searchable, polymorphic: true

  scope :score_sort, -> {order("score DESC")}
  scope :within_price_range, ->(price_range_params) do
    where(price: price_range_params)
  end

  class << self
    def normalize(query)
      query.to_s.gsub(/\s(?![\&|\!|\|])/, '\\\\ ')
    end

    def fulltext_query term
      "to_tsquery('english', vn_unaccent(#{term}) || ':*')"
    end

    def where_clause(search_term)
      arel_table[:document].full_text_match(fulltext_query search_term)
    end

    def rank_score term
      "ts_rank(document, #{fulltext_query term}) as score"
    end

    def search_ids(search_term)
      by_term(search_term).select(:searchable_id, :searchable_type, rank_score(quote_nomalize search_term))
    end

    def by_term(term)
      term = quote_nomalize term
      where(where_clause(term))
    end

    def quote_nomalize term
      ActiveRecord::Base.connection.quote normalize(term)
    end
  end
end
