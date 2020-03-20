require "arel/nodes/binary"
require "arel/predications"
require "arel/visitors/postgresql"

module Arel
  class Nodes::ContainsArray < Arel::Nodes::Binary
    def operator
      :"@>"
    end
  end

  class Nodes::IntersectArray < Arel::Nodes::Binary
    def operator
      :"&&"
    end
  end

  class Nodes::FullTextMatch < Arel::Nodes::Binary
    def operator
      :"@@"
    end
  end

  class Visitors::PostgreSQL
    private

    def visit_Arel_Nodes_ContainsArray(o, collector)
      infix_value o, collector, " @> "
    end

    def visit_Arel_Nodes_IntersectArray(o, collector)
      infix_value o, collector, " && "
    end

    def visit_Arel_Nodes_FullTextMatch(o, collector)
      infix_value o, collector, " @@ "
    end
  end

  module Predications
    def contains(other)
      Nodes::ContainsArray.new self, Nodes.build_quoted("{#{Array(other).join ", "}}", self)
    end

    def intersect(other)
      Nodes::IntersectArray.new self, Nodes.build_quoted(other, self)
    end

    def full_text_match(other)
      Nodes::FullTextMatch.new self, Arel::Nodes::SqlLiteral.new(other)
    end
  end
end
