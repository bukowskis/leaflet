[![Build Status](https://travis-ci.org/bukowskis/leaflet.png)](https://travis-ci.org/bukowskis/leaflet)

# Leaflet

A very robust light-weight paginator based on [leaf](http://github.com/c7/leaf) which is based on [will_paginate](http://github.com/mislav/will_paginate).

# Design principles

* Does not fiddle with Array, ActiveRecord, or anything else. It is self-contained.
* Compatible with both [will_paginate](http://github.com/mislav/will_paginate) and [kaminari](http://github.com/amatsuda/kaminari) API.
* Never raise an exception! Negative pages will simple become positive, out of bounds simple means to the last page, etc...

# Features

* Convert an Array into a Collection
* Create a partial Collection from any data subset (something [like this](http://wiseleyb.tumblr.com/post/2896145167/willpaginate-with-redis-on-rails-3))
* Export as JSON for transferring the collection over an API

# Installation

```ruby
gem install leaflet
```

# Examples

```ruby
# Converting an Array into a paginatable Collection
complete_collection = Leafet::Collection.new my_array
complete_collection.paginate(page: 5, per_page: 3)    # <-- Returns an Array with the paginated subset of the original Array

# Creating a custom Collection
my_array_subset = [:d, :e, :f]  # E.g. fetched from Redis according to page and per_page
collection = Leafet::Collection.new my_array_subset, total: 26, page:2, per_page: 3
```

# Credits

Leaflet is based on [leaf](http://github.com/c7/leaf) (by Peter Hellberg) which is based on [will_paginate](http://github.com/mislav/will_paginate) by PJ Hyett, who later handed over development to Mislav Marohnić.
