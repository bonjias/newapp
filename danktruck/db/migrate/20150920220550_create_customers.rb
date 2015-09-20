class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
    	t.string   "name"
    	t.string   "description"
   	 	t.string   "address"
    	t.float    "inputlattitude"
    	t.float    "inputlongitude"
   		
   		t.float    "latitude"
   		t.float    "longitude"
   		t.string   "geo_address"

      t.timestamps
    end
  end
end
