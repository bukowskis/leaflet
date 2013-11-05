require 'spec_helper'

describe Leaflet::Collection do
  let(:array) { ('a'..'e').to_a }

  context 'converting an Array into a Collection' do
    let(:collection) { Leaflet::Collection.new(array) }

    describe '#current_page' do
      it 'is the passed in parameter' do
        collection.current_page.should == 1
      end

      it 'never gets out of bounds' do
        collection = Leaflet::Collection.new(array, page: 99, per_page: 2)
        collection.current_page.should == 3
      end
    end

    describe '#per_page' do
      it 'is the default per_page' do
        collection.per_page.should == 20
      end
    end

    describe '#limit_value ' do
      it 'is an alias for per_page' do
        collection.per_page.should == collection.per_page
      end
    end

    describe '#total_entries' do
      it 'corresponds to the records size' do
        collection.total_entries.should == 5
      end

      it 'can be zero' do
        Leaflet::Collection.new([]).total_entries.should == 0
      end
    end

    describe '#total_count' do
      it 'is an alias for #total_entries' do
        collection.total_count.should == collection.total_entries
      end
    end

    describe '#paginate' do
      it 'returns a subset of original collection' do
        collection.paginate(page: 1, per_page: 3).should == %w{ a b c }
      end

      it 'can be shorter than per_page if on last page' do
        collection.paginate(page: 2, per_page: 3).should == %w{ d e }
      end

      it 'includes whole collection if per_page permits' do
        collection.paginate(page: 1, per_page: 5).should == collection
      end

      it 'never gets out of bounds' do
        collection.paginate(page: 4, per_page: 2).should == %w{ e }
      end
    end
  end

  context 'custom Collection' do
    let(:collection) { Leaflet::Collection.new(array, total: 40, per_page: 4, page: 4) }

    describe '#total_entries' do
      it 'is the passed in parameter' do
        collection.total_entries.should == 40
      end
    end

    describe '#total_pages' do
      it 'is calculated from the passed in total' do
        collection.total_pages.should == 10
      end

      it 'cannot be negative' do
        Leaflet::Collection.new([], total: -5).total_entries.should == 5
      end
    end

    describe '#per_page' do
      it 'is calculated from the passed in total' do
        collection.per_page.should == 4
      end
    end

    describe '#current_page' do
      it 'is the passed in parameter' do
        collection.current_page.should == 4
      end
    end

    describe '#paginate' do
      it 'is not possible on a non-complete collection' do
        expect { collection.paginate }.to raise_exception(Leaflet::Collection::PartialCollectionCannotBePaginated)
      end
    end
  end

  context 'decoration' do
    let(:decorated_entry1) { double(:decorated_entry1) }
    let(:decorated_entry2) { double(:decorated_entry2) }
    let(:entry1)           { double(:entry, decorate: decorated_entry1) }
    let(:entry2)           { double(:entry, decorate: decorated_entry2) }
    let(:array)            { [entry1, entry2] }
    let(:collection)       { Leaflet::Collection.new(array) }

    it 'decorates all objects' do
      decorated_collection = collection.decorate
      decorated_collection.first.should be decorated_entry1
      decorated_collection.last.should  be decorated_entry2
    end

    it 'is not destructive' do
      collection.decorate
      collection.first.should be entry1
      collection.last.should  be entry2
    end
  end
end
