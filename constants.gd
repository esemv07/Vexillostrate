extends Node2D


const OUTLINE_PATH = "res://Assets/Flag Outlines"
const OUTLINE_NAME = "Flag Outline.png"

const easy: int = 53
const medium: int = 84
const hard: int = 60

var DIFFICULTY = []

const COUNTRIES = {
	EASY = {
		"argentina" = {
			"name": "Argentina",
			"ratio": "5-8",
		},
		"armenia" = {
			"name": "Armenia",
			"ratio": "1-2",
		},
		"australia" = {
			"name": "Australia",
			"ratio": "1-2",
		},
		"austria"= {
			"name": "Austria",
			"ratio": "2-3",
		},
		"bangladesh" = {
			"name": "Bangladesh",
			"ratio": "3-5",
		},
		"belgium" = {
			"name": "Belgium",
			"ratio": "13-15",
		},
		"brazil" = {
			"name": "Brazil",
			"ratio": "7-10",
		},
		"bulgaria" = {
			"name": "Bulgaria",
			"ratio": "3-5",
		},
		"canada" = {
			"name": "Canada",
			"ratio": "1-2",
		},
		"china" = {
			"name": "China",
			"ratio": "2-3",
		},
		"colombia" = {
			"name": "Colombia",
			"ratio": "2-3",
		},
		"cuba" = {
			"name": "Cuba",
			"ratio": "1-2",
		},
		"cyprus" = {
			"name": "Cyprus",
			"ratio": "2-3",
		},
		"denmark" = {
			"name": "Denmark",
			"ratio": "28-37",
		},
		"egypt" = {
			"name": "Egypt",
			"ratio": "2-3",
		},
		"estonia" = {
			"name": "Estonia",
			"ratio": "7-11",
		},
		"finland" = {
			"name": "Finland",
			"ratio": "11-18",
		},
		"france" = {
			"name": "France",
			"ratio": "2-3",
		},
		"germany" = {
			"name": "Germany",
			"ratio": "3-5",
		},
		"greece" = {
			"name": "Greece",
			"ratio": "2-3",
		},
		"hungary" = {
			"name": "Hungary",
			"ratio": "1-2",
		},
		"iceland" = {
			"name": "Iceland",
			"ratio": "18-25",
		},
		"india" = {
			"name": "India",
			"ratio": "2-3",
		},
		"indonesia" = {
			"name": "Indonesia",
			"ratio": "2-3",
		},
		"ireland" = {
			"name": "Ireland",
			"ratio": "1-2",
		},
		"israel" = {
			"name": "Israel",
			"ratio": "8-11",
		},
		"italy" = {
			"name": "Italy",
			"ratio": "2-3",
		},
		"jamaica" = {
			"name": "Jamaica",
			"ratio": "1-2",
		},
		"japan" = {
			"name": "Japan",
			"ratio": "2-3",
		},
		"latvia" = {
			"name": "Latvia",
			"ratio": "1-2",
		},
		"lithuania" = {
			"name": "Lithuania",
			"ratio": "3-5",
		},
		"luxembourg" = {
			"name": "Luxembourg",
			"ratio": "3-5",
		},
		"mexico" = {
			"name": "Mexico",
			"ratio": "4-7",
		},
		"monaco" = {
			"name": "Monaco",
			"ratio": "4-5",
		},
		"nepal" = {
			"name": "Nepal",
			"ratio": "N-Ratio",
		},
		"netherlands" = {
			"name": "The Netherlands",
			"ratio": "2-3",
		},
		"new-zealand" = {
			"name": "New Zealand",
			"ratio": "1-2",
		},
		"norway" = {
			"name": "Norway",
			"ratio": "8-11",
		},
		"peru" = {
			"name": "Peru",
			"ratio": "2-3",
		},
		"philippines" = {
			"name": "Philippines",
			"ratio": "1-2",
		},
		"poland" = {
			"name": "Poland",
			"ratio": "5-8",
		},
		"romania" = {
			"name": "Romania",
			"ratio": "2-3",
		},
		"russia" = {
			"name": "Russia",
			"ratio": "2-3",
		},
		"south-africa" = {
			"name": "South Africa",
			"ratio": "2-3",
		},
		"s-korea" = {
			"name": "South Korea",
			"ratio": "2-3",
		},
		"sweden" = {
			"name": "Sweden",
			"ratio": "5-8",
		},
		"switzerland" = {
			"name": "Switzerland",
			"ratio": "1-1",
		},
		"thailand" = {
			"name": "Thailand",
			"ratio": "2-3",
		},
		"turkey" = {
			"name": "Türkiye (Turkey)",
			"ratio": "2-3",
		},
		"ukraine" = {
			"name": "Ukraine",
			"ratio": "2-3",
		},
		"uk" = {
			"name": "United Kingdom",
			"ratio": "1-2",
		},
		"usa" = {
			"name": "United States of America (USA)",
			"ratio": "10-19",
		},
		"vietnam" = {
			"name": "Vietnam",
			"ratio": "2-3",
		},
	},
	MEDIUM = {
		"albania" = {
			"name": "Albania",
			"ratio": "5-7",
		},
		"algeria" = {
			"name": "Algeria",
			"ratio": "2-3",
		},
		"angola" = {
			"name": "Angola",
			"ratio": "2-3",
		},
		"antigua-barbuda" = {
			"name": "Antigua and Barbuda",
			"ratio": "2-3",
		},
		"azerbaijan" = {
			"name": "Azerbaijan",
			"ratio": "1-2",
		},
		"bahamas" = {
			"name": "Bahamas",
			"ratio": "1-2",
		},
		"bahrain" = {
			"name": "Bahrain",
			"ratio": "3-5",
		},
		"barbados" = {
			"name": "Barbados",
			"ratio": "2-3",
		},
		"bolivia" = {
			"name": "Bolivia",
			"ratio": "2-3",
		},
		"botswana" = {
			"name": "Botswana",
			"ratio": "2-3",
		},
		"burkina-faso" = {
			"name": "Burkina Faso",
			"ratio": "2-3",
		},
		"burundi" = {
			"name": "Burundi",
			"ratio": "3-5",
		},
		"cambodia" = {
			"name": "Cambodia",
			"ratio": "2-3",
		},
		"cameroon" = {
			"name": "Cameroon",
			"ratio": "2-3",
		},
		"chad" = {
			"name": "Chad",
			"ratio": "2-3",
		},
		"chile" = {
			"name": "Chile",
			"ratio": "2-3",
		},
		"costa-rica" = {
			"name": "Costa Rica",
			"ratio": "3-5",
		},
		"croatia" = {
			"name": "Croatia",
			"ratio": "1-2",
		},
		"czechia" = {
			"name": "Czechia (Czech Republic)",
			"ratio": "2-3",
		},
		"ecuador" = {
			"name": "Ecuador",
			"ratio": "2-3",
		},
		"ethiopia" = {
			"name": "Ethiopia",
			"ratio": "1-2",
		},
		"gabon" = {
			"name": "Gabon",
			"ratio": "3-4",
		},
		"gambia" = {
			"name": "The Gambia",
			"ratio": "2-3",
		},
		"georgia" = {
			"name": "Georgia",
			"ratio": "2-3",
		},
		"ghana" = {
			"name": "Ghana",
			"ratio": "2-3",
		},
		"guinea" = {
			"name": "Guinea",
			"ratio": "2-3",
		},
		"guinea-bissau" = {
			"name": "Guinea-Bissau",
			"ratio": "1-2",
		},
		"guyana" = {
			"name": "Guyana",
			"ratio": "3-5",
		},
		"honduras" = {
			"name": "Honduras",
			"ratio": "1-2",
		},
		"iran" = {
			"name": "Iran",
			"ratio": "4-7",
		},
		"iraq" = {
			"name": "Iraq",
			"ratio": "2-3",
		},
		"ivory-coast" = {
			"name": "Côte d'Ivoire (Ivory Coast)",
			"ratio": "2-3",
		},
		"jordan" = {
			"name": "Jordan",
			"ratio": "1-2",
		},
		"kenya" = {
			"name": "Kenya",
			"ratio": "2-3",
		},
		"laos" = {
			"name": "Laos",
			"ratio": "2-3",
		},
		"lebanon" = {
			"name": "Lebanon",
			"ratio": "2-3",
		},
		"liberia" = {
			"name": "Liberia",
			"ratio": "10-19",
		},
		"libya" = {
			"name": "Libya",
			"ratio": "1-2",
		},
		"liechtenstein" = {
			"name": "Liechtenstein",
			"ratio": "3-5",
		},
		"madagascar" = {
			"name": "Madagascar",
			"ratio": "2-3",
		},
		"malawi" = {
			"name": "Malawi",
			"ratio": "2-3",
		},
		"malaysia" = {
			"name": "Malaysia",
			"ratio": "1-2",
		},
		"maldives" = {
			"name": "Maldives",
			"ratio": "2-3",
		},
		"mali" = {
			"name": "Mali",
			"ratio": "2-3",
		},
		"malta" = {
			"name": "Malta",
			"ratio": "2-3",
		},
		"mauritania" = {
			"name": "Mauritania",
			"ratio": "2-3",
		},
		"moldova" = {
			"name": "Moldova",
			"ratio": "1-2",
		},
		"mongolia" = {
			"name": "Mongolia",
			"ratio": "1-2",
		},
		"morocco" = {
			"name": "Morocco",
			"ratio": "2-3",
		},
		"myanmar" = {
			"name": "Myanmar (formerly Burma)",
			"ratio": "2-3",
		},
		"niger" = {
			"name": "Niger",
			"ratio": "6-7",
		},
		"nigeria" = {
			"name": "Nigeria",
			"ratio": "1-2",
		},
		"n-korea" = {
			"name": "North Korea",
			"ratio": "1-2",
		},
		"pakistan" = {
			"name": "Pakistan",
			"ratio": "2-3",
		},
		"palestine" = {
			"name": "Palestine",
			"ratio": "1:2",
		},
		"panama" = {
			"name": "Panama",
			"ratio": "2-3",
		},
		"png" = {
			"name": "Papua New Guinea",
			"ratio": "3-4",
		},
		"paraguay" = {
			"name": "Paraguay",
			"ratio": "11-20",
		},
		"portugal" = {
			"name": "Portugal",
			"ratio": "2-3",
		},
		"qatar" = {
			"name": "Qatar",
			"ratio": "11-28",
		},
		"samoa" = {
			"name": "Samoa",
			"ratio": "1-2",
		},
		"saudi-arabia" = {
			"name": "Saudi Arabia",
			"ratio": "2-3",
		},
		"serbia" = {
			"name": "Serbia",
			"ratio": "2-3",
		},
		"sierra-leone" = {
			"name": "Sierra Leone",
			"ratio": "2-3",
		},
		"singapore" = {
			"name": "Singapore",
			"ratio": "2-3",
		},
		"slovakia" = {
			"name": "Slovakia",
			"ratio": "2-3",
		},
		"slovenia" = {
			"name": "Slovenia",
			"ratio": "1-2",
		},
		"somalia" = {
			"name": "Somalia",
			"ratio": "2-3",
		},
		"spain" = {
			"name": "Spain",
			"ratio": "2-3",
		},
		"sri-lanka" = {
			"name": "Sri Lanka",
			"ratio": "1-2",
		},
		"sudan" = {
			"name": "Sudan",
			"ratio": "1-2",
		},
		"syria" = {
			"name": "Syria",
			"ratio": "2-3",
		},
		"taiwan" = {
			"name": "Taiwan",
			"ratio": "2-3",
		},
		"tanzania" = {
			"name": "Tanzania",
			"ratio": "2-3",
		},
		"togo" = {
			"name": "Togo",
			"ratio": "3-5",
		},
		"tonga" = {
			"name": "Tonga",
			"ratio": "1-2",
		},
		"trt" = {
			"name": "Trinidad and Tobago",
			"ratio": "3-5",
		},
		"tunisia" = {
			"name": "Tunisia",
			"ratio": "2-3",
		},
		"uganda" = {
			"name": "Uganda",
			"ratio": "2-3",
		},
		"uae" = {
			"name": "United Arab Emirates (UAE)",
			"ratio": "1-2",
		},
		"uruguay" = {
			"name": "Uruguay",
			"ratio": "2-3",
		},
		"vatican" = {
			"name": "Vatican City",
			"ratio": "1-1",
		},
		"venezuela" = {
			"name": "Venezuela",
			"ratio": "2-3",
		},
		"yemen" = {
			"name": "Yemen",
			"ratio": "2-3",
		},
	},
	HARD = {
		"afghanistan" = {
			"name": "Afghanistan",
			"ratio": "1-2",
		},
		"andorra" = {
			"name": "Andorra",
			"ratio": "7-10",
		},
		"belarus" = {
			"name": "Belarus",
			"ratio": "1-2",
		},
		"belize" = {
			"name": "Belize",
			"ratio": "3-5",
		},
		"benin" = {
			"name": "Benin",
			"ratio": "2-3",
		},
		"bhutan" = {
			"name": "Bhutan",
			"ratio": "2-3",
		},
		"bosnia" = {
			"name": "Bosnia and Herzegovina",
			"ratio": "1-2",
		},
		"brunei" = {
			"name": "Brunei",
			"ratio": "1-2",
		},
		"cabo-verde" = {
			"name": "Cabo Verde (Cape Verde)",
			"ratio": "10-17",
		},
		"car" = {
			"name": "Central African Republic",
			"ratio": "3-5",
		},
		"comoros" = {
			"name": "Comoros",
			"ratio": "3-5",
		},
		"drc" = {
			"name": "Democratic Republic of the Congo (DRC)",
			"ratio": "3-4",
		},
		"rep-congo" = {
			"name": "Republic of the Congo",
			"ratio": "2-3",
		},
		"djibouti" = {
			"name": "Djibouti",
			"ratio": "2-3",
		},
		"dominica" = {
			"name": "Dominica",
			"ratio": "1-2",
		},
		"dominican-rep" = {
			"name": "Dominican Republic",
			"ratio": "5-8",
		},
		"el-salvador" = {
			"name": "El Salvador",
			"ratio": "189-335",
		},
		"eq-guinea" = {
			"name": "Equatorial Guinea",
			"ratio": "2-3",
		},
		"eritrea" = {
			"name": "Eritrea",
			"ratio": "1-2",
		},
		"eswatini" = {
			"name": "Eswatini",
			"ratio": "2-3",
		},
		"fiji" = {
			"name": "Fiji",
			"ratio": "1-2",
		},
		"grenada" = {
			"name": "Grenada",
			"ratio": "3-5",
		},
		"guatemala" = {
			"name": "Guatemala",
			"ratio": "5-8",
		},
		"haiti" = {
			"name": "Haiti",
			"ratio": "3-5",
		},
		"kazakhstan" = {
			"name": "Kazakhstan",
			"ratio": "1-2",
		},
		"kiribati" = {
			"name": "Kiribati",
			"ratio": "1-2",
		},
		"kosovo" = {
			"name": "Kosovo",
			"ratio": "5-7",
		},
		"kuwait" = {
			"name": "Kuwait",
			"ratio": "1-2",
		},
		"kyrgyzstan" = {
			"name": "Kyrgyzstan",
			"ratio": "3-5",
		},
		"lesotho" = {
			"name": "Lesotho",
			"ratio": "2-3",
		},
		"marshall-is" = {
			"name": "Marshall Islands",
			"ratio": "10-19",
		},
		"mauritius" = {
			"name": "Mauritius",
			"ratio": "2-3",
		},
		"micronesia" = {
			"name": "The Federated States of Micronesia (Micronesia)",
			"ratio": "10-19",
		},
		"montenegro" = {
			"name": "Montenegro",
			"ratio": "1-2",
		},
		"mozambique" = {
			"name": "Mozembique",
			"ratio": "2-3",
		},
		"namibia" = {
			"name": "Namibia",
			"ratio": "2-3",
		},
		"nauru" = {
			"name": "Nauru",
			"ratio": "1-2",
		},
		"nicaragua" = {
			"name": "Nicaragua",
			"ratio": "3-5",
		},
		"n-mac" = {
			"name": "North Macedonia",
			"ratio": "1-2",
		},
		"oman" = {
			"name": "Oman",
			"ratio": "4-7",
		},
		"palau" = {
			"name": "Palau",
			"ratio": "5-8",
		},
		"rwanda" = {
			"name": "Rwanda",
			"ratio": "2-3",
		},
		"st-kitts" = {
			"name": "Saint Kitts and Nevis",
			"ratio": "2-3",
		},
		"st-lucia" = {
			"name": "Saint Lucia",
			"ratio": "1-2",
		},
		"st-vincent" = {
			"name": "Saint Vincent and the Grenadines",
			"ratio": "2-3",
		},
		"san-marino" = {
			"name": "San Marino",
			"ratio": "3-4",
		},
		"sao-tome" = {
			"name": "São Tomé and Príncipe",
			"ratio": "1-2",
		},
		"senegal" = {
			"name": "Senegal",
			"ratio": "2-3",
		},
		"seychelles" = {
			"name": "Seychelles",
			"ratio": "1-2",
		},
		"solomon-is" = {
			"name": "Solomon Islands",
			"ratio": "1-2",
		},
		"s-sudan" = {
			"name": "South Sudan",
			"ratio": "1-2",
		},
		"suriname" = {
			"name": "Suriname",
			"ratio": "2-3",
		},
		"tajikistan" = {
			"name": "Tajikistan",
			"ratio": "1-2",
		},
		"timor-leste" = {
			"name": "Timor-Leste (East Timor)",
			"ratio": "1-2",
		},
		"turkmenistan" = {
			"name": "Turkmenistan",
			"ratio": "2-3",
		},
		"tuvalu" = {
			"name": "Tuvalu",
			"ratio": "1-2",
		},
		"uzbekistan" = {
			"name": "Uzbekistan",
			"ratio": "1-2",
		},
		"vanuatu" = {
			"name": "Vanuatu",
			"ratio": "3-5",
		},
		"zambia" = {
			"name": "Zambia",
			"ratio": "2-3",
		},
		"zimbabwe" = {
			"name": "Zimbabwe",
			"ratio": "1-2",
		},
	}
}


var username = "no username"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass # Replace with function body.
