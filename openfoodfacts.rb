require 'open-uri'
require 'json'

# Fonction qui teste si l'information est renseignée ou pas dans le Json
def check_string(value)
	return value.empty? ? "L'information n'a pas été renseignée" : value
end

loop do
	# Récupération du Code Barre
	puts "============================================"
	puts "Entrez le numéro de Code Barre d'un produit:"
	puts "============================================"
	bar_code = gets.chomp

	# Récupération de l'information désirée
	puts "============================================"
	puts "Entrez un chiffre de 0 à 4"
	puts "============================================"
	puts "0: Marque"
	puts "1: Nom du produit"
	puts "2: Ingrédients"
	puts "3: Pays d'origine"
	puts "4: Toutes les informations"
	puts "============================================"
	info = gets.chomp.to_i

	# Création du tableau
	array = ["brands_tags", "product_name", "ingredients_text", "origins"]

	# Récupération des datas
	url="http://fr.openfoodfacts.org/api/v0/produit/#{bar_code}.json"
	json = open(url).read
	data = JSON.parse(json)

	# Affichage des données voulues par l'utilisateur avec tests pour éviter les champs vides
	if data['status_verbose'] == "product not found"
		puts "Le produit n'a pas été référencé"
	elsif info <= 3
		puts "============================================"
		puts check_string(data['product'][array.at(info)])
		puts "============================================"
	else
		puts "============================================"
		puts check_string(data['product']['brands_tags']),
			check_string(data['product']['product_name']),
			check_string(data['product']['ingredients_text']),
			check_string(data['product']['origins'])
		puts "============================================"
	end
end

