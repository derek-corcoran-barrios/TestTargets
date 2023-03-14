Read_Data <- function(Data){
  readr::read_csv("Species.csv") |> 
    dplyr::pull(Species)
}


DownloadSpecies <- function(Cleaned){
 SDMWorkflows::GetOccs(Species = Cleaned,
                        continent = "europe",
                        limit = 1000, 
                        WriteFile = F)
}

combine_presences <- function(Species) {
  Species[[1]][[1]] |> 
    dplyr::select("key", "scientificName", "decimalLatitude", "decimalLongitude", "kingdom", "phylum", "order", "family", "genus", "species") |> 
    dplyr::group_split(species)
}

Clean_Coord <- function(Coords){
  SDMWorkflows::clean_presences(Coords[[1]])
}

