class Search < ApplicationRecord
  self.primary_key = "searchable_id"
  self.table_name = "searches"

  belongs_to :searchable, polymorphic: true

  scope :score_sort, -> {order("score DESC")}

  class << self
    def by_term term
      where(where_clause(term))
    end

    def normalize(query)
      query.to_s.gsub(/\s(?![\&|\!|\|])/, '\\\\ ')
    end

    def fulltext_query term
      "to_tsquery('english',  #{term} || ':*')"
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

    def quote_nomalize term
      ActiveRecord::Base.connection.quote normalize(term)
    end
  end
end
