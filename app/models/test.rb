# Simpler.application.db.create_table(:tests) do
#   primary_key :id
#   String :title, nul: false
#   Integer :level, default: 0
# end

class Test < Sequel::Model
end
