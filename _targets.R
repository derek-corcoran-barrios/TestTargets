library(targets)


Spp <- c("Lucilia sericata", "Ocypus ophthalmicus", "Chorthippus vagans", 
         "Peridinium quadridentatum", "Cortinarius croceocaeruleus", "Contarinia pyrivora", 
         "Philonthus coprophilus", "Chaetogaster diaphanus", "Carex hartmaniorum", 
         "Platypalpus interstinctus", "Exobasidium juelianum", "Phytodietus variegatus", 
         "Osmunda regalis", "Stenurella bifasciata", "Neobisnius villosulus", 
         "Lepthyphantes minutus", "Taraxacum ristingense", "Bacidia neosquamulosa", 
         "Lithodesmium undulatum", "Calypogeia arguta", "Philocheras bispinosus", 
         "Clambus pubescens", "Faxonius rusticus", "Stenus kiesenwetteri", 
         "Ephemerum minutissimum", "Pocadius ferrugineus", "Psilocybe semilanceata", 
         "Erythromma najas", "Frankliniella schultzei", "Perilissus rufoniger", 
         "Glyptotendipes gripekoveni", "Synchaeta stylata", "Glypta teres", 
         "Philonthus umbratilis", "Neolimnophila placida", "Cortinarius falsosus", 
         "Prochoreutis sehestediana", "Carex strigosa", "Galerucella tenella", 
         "Iophon piceum", "Bracon caudiger", "Hybomitra lundbecki", "Eupithecia subfuscata", 
         "Badister peltatus", "Cytisus scoparius", "Symphoricarpos albus", 
         "Platylabus dolorosus", "Carabodes ornatus", "Anteris scutellaris", 
         "Porrhomma montanum")

tar_option_set(
  packages = c("SDMWorkflows", "readxl", "janitor", "dplyr", "purrr"),     format = "rds" # default storage format
)


tar_source()

list(
  tar_target(file, "Species.csv", format = "file"),
  tar_target(data, Read_Data(file)),
  tar_target(
    Species_Presences,
    DownloadSpecies(data),
    pattern = map(data),
    iteration = "list"
  ),
  tar_target(Cleaned_Coordinates,
             Clean_Coord(Species_Presences),
             pattern = map(Species_Presences),
             iteration = "group",
             error = "null")
)
