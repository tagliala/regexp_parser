module Regexp::Expression
  class Subexpression < Regexp::Expression::Base
    include Enumerable

    attr_accessor :expressions

    def initialize(token, options = {})
      self.expressions = []
      super
    end

    # Override base method to clone the expressions as well.
    def initialize_copy(orig)
      self.expressions = orig.expressions.map(&:clone)
      super
    end

    def <<(exp)
      exp.parent = self
      if exp.is_a?(WhiteSpace) && last && last.is_a?(WhiteSpace)
        last.merge(exp)
      else
        expressions << exp
      end
    end

    %w[[] at each empty? fetch index join last length values_at].each do |method|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method}(*args, &block)
          expressions.#{method}(*args, &block)
        end
      RUBY
    end

    def dig(*indices)
      exp = self
      indices.each { |idx| exp = exp.nil? || exp.terminal? ? nil : exp[idx] }
      exp
    end

    def te
      ts + to_s.length
    end

    def to_h
      attributes.merge(
        text:        to_s(:base),
        expressions: expressions.map(&:to_h)
      )
    end
  end
end
