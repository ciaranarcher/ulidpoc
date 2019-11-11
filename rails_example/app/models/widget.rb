class Widget < ApplicationRecord
  include ULID::Rails
  ulid :id # The argument is the primary key column name
end
