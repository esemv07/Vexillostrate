@tool
extends EditorScript


const OUTLINE_PATH = "res://Assets/Flag Outlines"
const OUTLINE_NAME = "Flag Outline.png"

const easy: int = 53
const medium: int = 84
const hard: int = 60

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
			"ratio": "13-15 missing",
		},
		"brazil" = {
			"name": "Brazil",
			"ratio": "7-10 missing",
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
			"ratio": "28-37 missing",
		},
		"egypt" = {
			"name": "Egypt",
			"ratio": "2-3",
		},
		"estonia" = {
			"name": "Estonia",
			"ratio": "7-11 missing",
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
			"ratio": "18-25 missing",
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
			"ratio": "8-11 missing",
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
			"ratio": "4-7 missing",
		},
		"monaco" = {
			"name": "Monaco",
			"ratio": "4-5 missing",
		},
		"nepal" = {
			"name": "Nepal",
			"ratio": "n-ratio missing",
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
			"ratio": "10-19 missing",
		},
		"vietnam" = {
			"name": "Vietnam",
			"ratio": "2-3",
		},
	},
	MEDIUM = {
		"albania": "5-7 missing",
		"algeria": "2-3",
		"angola": "2-3",
		"antigua-barbuda": "2-3",
		"azerbaijan": "1-2",
		"bahamas": "1-2",
		"bahrain": "3-5",
		"barbados": "2-3",
		"bolivia": "2-3",
		"botswana": "2-3",
		"burkina-faso": "2-3",
		"burundi": "3-5",
		"cambodia": "2-3",
		"cameroon": "2-3",
		"chad": "2-3",
		"chile": "2-3",
		"costa-rica": "3-5",
		"croatia": "1-2",
		"czechia": "2-3",
		"ecuador": "2-3",
		"ethiopia": "1-2",
		"gabon": "3-4",
		"gambia": "2-3",
		"georgia": "2-3",
		"ghana": "2-3",
		"guinea": "2-3",
		"guinea-bissau": "1-2",
		"guyana": "3-5",
		"honduras": "1-2",
		"iran": "4-7 missing",
		"iraq": "2-3",
		"ivory-coast": "2-3",
		"jordan": "1-2",
		"kenya": "2-3",
		"laos": "2-3",
		"lebanon": "2-3",
		"liberia": "10-19 missing",
		"libya": "1-2",
		"liechtenstein": "3-5",
		"madagascar": "2-3",
		"malawi": "2-3",
		"malaysia": "1-2",
		"maldives": "2-3",
		"mali": "2-3",
		"malta": "2-3",
		"mauritania": "2-3",
		"moldova": "1-2",
		"mongolia": "1-2",
		"morocco": "2-3",
		"myanmar": "2-3",
		"niger": "6-7 missing",
		"nigeria": "1-2",
		"n-korea": "1-2",
		"pakistan": "2-3",
		"palestine": "1:2",
		"panama": "2-3",
		"png": "3-4 missing",
		"paraguay": "11-20 missing",
		"portugal": "2-3",
		"qatar": "11-28 missing",
		"samoa": "1-2",
		"saudi-arabia": "2-3",
		"serbia": "2-3",
		"sierra-leone": "2-3",
		"singapore": "2-3",
		"slovakia": "2-3",
		"slovenia": "1-2",
		"somalia": "2-3",
		"spain": "2-3",
		"sri-lanka": "1-2",
		"sudan": "1-2",
		"syria": "2-3",
		"taiwan": "2-3",
		"tanzania": "2-3",
		"togo": "3-5",
		"tonga": "1-2",
		"trt": "3-5",
		"tunisia": "2-3",
		"uganda": "2-3",
		"uae": "1-2",
		"uruguay": "2-3",
		"vatican": "1-1",
		"venezuela": "2-3",
		"yemen": "2-3",
	},
	HARD = {
		"afghanistan": "1-2",
		"andorra": "7-10 missing",
		"belarus": "1-2",
		"belize": "3-5",
		"benin": "2-3",
		"bhutan": "2-3",
		"bosnia": "1-2",
		"brunei": "1-2",
		"cabo verde": "10-17 missing",
		"car": "3-5",
		"comoros": "3-5",
		"drc": "3-4 missing",
		"rep-congo": "2-3",
		"djibouti": "2-3",
		"dominica": "1-2",
		"dominican-rep": "5-8",
		"el-salvador": "189-335 missing",
		"eq-guinea": "2-3",
		"eritrea": "1-2",
		"eswatini": "2-3",
		"fiji": "1-2",
		"grenada": "3-5",
		"guatemala": "5-8",
		"haiti": "3-5",
		"kazakhstan": "1-2",
		"kiribati": "1-2",
		"kosovo": "5:7 missing",
		"kuwait": "1-2",
		"kyrgyzstan": "3-5",
		"lesotho": "2-3",
		"marshall-is": "10-19 missing",
		"mauritius": "2-3",
		"micronesia": "10-19",
		"montenegro": "1-2",
		"mozambique": "2-3",
		"namibia": "2-3",
		"nauru": "1-2",
		"nicaragua": "3-5",
		"n-mac": "1-2",
		"oman": "4-7 missing",
		"palau": "5-8",
		"rwanda": "2-3",
		"st-kitts": "2-3",
		"st-lucia": "1-2",
		"st-vincent": "2-3",
		"san-marino": "3-4 missing",
		"sao-tome": "1-2",
		"senegal": "2-3",
		"seychelles": "1-2",
		"solomon-is": "1-2",
		"south-sudan": "1-2",
		"suriname": "2-3",
		"tajikistan": "1-2",
		"timor-leste": "1-2",
		"turkmenistan": "2-3",
		"tuvalu": "1-2",
		"uzbekistan": "1-2",
		"vanuatu": "3-5",
		"zambia": "2-3",
		"zimbabwe": "1-2",
	}
}




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass # Replace with function body.

func _run() -> void:
	pick_random_country()


func pick_random_country():
	var all = COUNTRIES.EASY.keys()
	var rand = randi() % COUNTRIES.EASY.size()
	var rand_country = all[rand]
	var country = COUNTRIES["EASY"][rand_country]["ratio"]
	var path = "%s/%s %s" % [OUTLINE_PATH, country, OUTLINE_NAME]
	print(rand)
	print(path)
	print(rand_country)
	print(COUNTRIES["EASY"][rand_country]["name"])
