CREATE OR REPLACE FUNCTION array_as_xmlagg(attributeArray text[])
    RETURNS xml
/*
This function takes an array and returns a single record containing an XML populated with data from the array.
Parameter: attributeArray is an array of texts
Return: kvhstore converted to xml
Dependency: requires hstore extension
Author: Pratik Gautam
*/
AS
$$
DECLARE

BEGIN

RETURN
    xmlelement(name node, xmlagg) 
    FROM 
	(
        SELECT xmlagg(xnodes)
        FROM
        (
            SELECT
            xmlelement
            (
                name node,
                xmlattributes
                (
                    attribute as "value"
                )
            ) AS xnodes
            FROM
            unnest(attributeArray) AS attribute
        ) AS xnodes
    ) AS xmlagg;

END;
$$
LANGUAGE plpgsql