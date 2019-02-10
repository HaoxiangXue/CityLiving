CityLiving
===============

This package obtains data with API and web-scraping skills from websites, and combines them into an overall dataset. It includes 4 tidy datasets, and 6 functions which assist users to obtain and summarize data. 

## sources
[Numbeo: https://www.numbeo.com](https://www.numbeo.com/) <br>
[Teleport: https://teleport.org](https://teleport.org/)

## datasets
This package includes 4 datasets: 
  * `numbeodata`
  * `teleportdata` 
  * `simpledata` 
  * `fulldata` <br>

More information can be found in the vignette `data_vignette`. 

## functions
This package includes 6 functions. <br>
Three functions intend to obtain data from internet: <br>
  * Get city scores out of 10 from teleport: `teleport`; <br>
  * Get city indices from Numbeo: `numbeo`; <br>
  * Get brief summary of monthly costs for each city: `costsummary`; <br>

Three functions intend to present brief summary: <br>
  * Get quality index summary: `quality`; <br>
  * Get score summary: `score`; <br>
  * Get overall summary of each city: `citysummary` <br>

More introductions can be found in the vignette `functions_vignette`.

