class Fonts < ActiveRecord::Migration
  def up
  	create_table :fonts do |t|
			t.string :family, :null => false, :default => "Helvetica"
			t.boolean :serif, :null => false, :default => false
			t.integer :min_weight, :null => false, :default => 100
			t.integer :normal_weight, :null => false, :default => 400
			t.integer :max_weight, :null => false, :default => 700
		end

		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Martel',1,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Martel Sans',0,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Exo 2',0,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Alegreya Sans',0,100,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Alegreya Sans SC',0,100,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Roboto',0,100,300,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Source Sans Pro',0,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Titillium Web',0,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Josefin Sans',0,100,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Josefin Slab',1,100,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Lato',0,100,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Open Sans',0,300,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Roboto Mono',0,100,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Raleway',1,100,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Cabin',1,400,500,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Expletus Sans',0,400,500,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Fira Sans',0,300,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Merriweather',1,300,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Merriweather Sans',0,300,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Ubuntu',0,300,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Advent Pro',0,100,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Biryani',0,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Dosis',0,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Ek Mukta',0,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Inknut Antiqua',1,300,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Palanquin',0,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Source Code Pro',0,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Alegreya',1,400,700,900)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Alegreya SC',0,400,700,900)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Crimson Text',1,400,600,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Neuton',1,200,400,700)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Overlock',0,400,700,900)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Playfair Display',1,400,700,900)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Playfair Display SC',0,400,700,900)")
		execute("INSERT INTO fonts(family, serif, min_weight, normal_weight, max_weight) VALUES('Roboto Condensed',0,300,400,700)")
		
  end

  def down
  	drop_table :fonts
  end
end
