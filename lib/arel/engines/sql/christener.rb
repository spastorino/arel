module Arel
  module Sql
    class Christener
      def initialize
        # FIXME: this exists because all objects hash the same. :'(
        @used_names = Hash.new(0)
        @relation_names = Hash.new do |hash, relation|
          name =  relation.table_alias || relation.name
          @used_names[name] += 1
          hash[relation] = name + (@used_names[name] > 1 ? "_#{@used_names[name]}" : '')
        end
      end

      def name_for(relation)
        @relation_names[relation.table]
      end
    end
  end
end
