# Useful Pl/PgSQL Functions

## Introduction
This repo has some useful Pl/PgSQL functions derived from those I wrote for my earlier projects. Will try to add more functions in the coming days.

## Function descriptions
1. PostGIS function to get a GeoJSON of polygon geometries matching the given list of integers in its "code" attribute.
This function selects the polygons having the "code" attribute matching the given list of codes (as a string of comma-separated integers) and returns them as a single GeoJSON record.
The GeoJSON contains the polygons geometry (coordinates) and only its "code" attribute as its property.
- Parameters: `codeList`
                 a string containing the comma-separated list of integers which are the "code" attributes 
                 of the polygon geometries.
- Returns: A single record containing the GeoJSON of polygons matching the given list of codes.
- Dependencies: PostGIS extension
- Filename: `get_geojson_of_polygons_matching_attribute.sql`

2. Function to convert Hstore to XML
`hstore_as_xmlagg(kvHstore hstore)`
This function takes a hstore and returns a single record containing an XML populated with data from the hstore.
- Parameter: `kvHstore` is an hstore
- Return: `kvhstore` converted to xml
- Dependency: requires hstore extension
- Filename: `hstore_as_xmlagg.sql`

3. Function to convert a Postgres array to XML
`array_as_xmlagg(attributeArray text[])`
This function takes an array and returns a single record containing an XML populated with data from the array.
- Parameter: `attributeArray` is an array of texts
- Return: the array converted to xml
- Dependency: requires hstore extension
- Filename: `array_as_xmlagg.sql`

