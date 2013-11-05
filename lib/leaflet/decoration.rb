module Leaflet
  class Collection < Array

    # Basic support for decorating collections just like draper does.
    # Could be improved with more options using something like this:
    # https://github.com/drapergem/draper/blob/4b933ef39d252ecfe93c573a072633be545c49fb/lib/draper/collection_decorator.rb
    # Also a #decorated? would be nice. But the following works in 99% of the cases as is.
    #
    def decorate
      result = dup
      result.map!(&:decorate)
      result
    end

  end
end
