CREATE TYPE geojson_featurecollection AS ( 
/*
Type required for the get_polygon_geojson function defined below.
Dependencies: PostGIS extension
Author: Pratik Gautam
*/
  code int,
  type varchar(17),
  crs json,
  features json
);



CREATE OR REPLACE FUNCTION get_polygon_geojson(codeList text)
    RETURNS geojson_featurecollection

/*
    This function selects the polygons having the "code" attribute matching the given list of codes (as a string of comma-separated integers)
    and returns them as a single GeoJSON record containing the polygons geometry and its "code" as its property.
    Parameters: codeList
                 a string containing the comma-separated list of integers which are the "code" attributes 
                 of the polygon geometries.
    Returns: A single record containing the GeoJSON of polygons matching the given list of codes.
    Dependencies: PostGIS extension
    Author: Pratik Gautam
*/

AS
$$

DECLARE
featureCollectionRecord geojson_featurecollection;

BEGIN

SELECT 1 as code,
        'FeatureCollection' AS type,
        '{ "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } }'::json AS crs,
        array_to_json(array_agg(features)) AS features
        FROM
        (
            SELECT
            'Feature' AS type,
            row_to_json
            ((
                select properties from (
                    select code
                ) as properties
            )) AS properties,
            ST_AsGeoJSON(geometry)::json AS geometry
            FROM
            (
                select * from polygons_table where string_to_array(codeList, ',', '')::int[] @> ARRAY[code]
            )
            as data
        ) AS features INTO featureCollectionRecord;

RETURN featureCollectionRecord;

END;
$$

LANGUAGE plpgsql;

