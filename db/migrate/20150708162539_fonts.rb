class Fonts < ActiveRecord::Migration
  def change
  	create_table :fonts do |t|
			t.string :family, :null => false
		end

		execute("INSERT INTO fonts(family) VALUES('Martel')")
		execute("INSERT INTO fonts(family) VALUES('Exo 2')")
		execute("INSERT INTO fonts(family) VALUES('Alegreya Sans')")
		execute("INSERT INTO fonts(family) VALUES('Alegreya Sans SC')")
		execute("INSERT INTO fonts(family) VALUES('Roboto')")
		execute("INSERT INTO fonts(family) VALUES('Source Sans Pro')")
		execute("INSERT INTO fonts(family) VALUES('Titillium Web')")
		execute("INSERT INTO fonts(family) VALUES('Josefin Sans')")
		execute("INSERT INTO fonts(family) VALUES('Josefin Slab')")
		execute("INSERT INTO fonts(family) VALUES('Lato')")
		execute("INSERT INTO fonts(family) VALUES('Open Sans')")
		execute("INSERT INTO fonts(family) VALUES('Roboto Mono')")
		execute("INSERT INTO fonts(family) VALUES('Raleway')")
		execute("INSERT INTO fonts(family) VALUES('Cabin')")
		execute("INSERT INTO fonts(family) VALUES('Expletus Sans')")
		execute("INSERT INTO fonts(family) VALUES('Fira Sans')")
		execute("INSERT INTO fonts(family) VALUES('Merriweather')")
		execute("INSERT INTO fonts(family) VALUES('Merriweather Sans')")
		execute("INSERT INTO fonts(family) VALUES('Ubuntu')")
		execute("INSERT INTO fonts(family) VALUES('Advent Pro')")
		execute("INSERT INTO fonts(family) VALUES('Biryani')")
		execute("INSERT INTO fonts(family) VALUES('Dosis')")
		execute("INSERT INTO fonts(family) VALUES('Ek Mukta')")
		execute("INSERT INTO fonts(family) VALUES('Inknut Antiqua')")
		execute("INSERT INTO fonts(family) VALUES('Martel')")
		execute("INSERT INTO fonts(family) VALUES('Martel Sans')")
		execute("INSERT INTO fonts(family) VALUES('Palanquin')")
		execute("INSERT INTO fonts(family) VALUES('Source Code Pro')")
		execute("INSERT INTO fonts(family) VALUES('Alegreya')")
		execute("INSERT INTO fonts(family) VALUES('Alegreya SC')")
		execute("INSERT INTO fonts(family) VALUES('Crimson Text')")
		execute("INSERT INTO fonts(family) VALUES('Neuton')")
		execute("INSERT INTO fonts(family) VALUES('Overlock')")
		execute("INSERT INTO fonts(family) VALUES('Playfair Display')")
		execute("INSERT INTO fonts(family) VALUES('Playfair Display SC')")
		execute("INSERT INTO fonts(family) VALUES('Roboto Condensed')")
		
  end
end
