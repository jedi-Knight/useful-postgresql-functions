CREATE OR REPLACE FUNCTION hstore_as_xmlagg(kvHstore hstore)
    RETURNS xml
/*
This function takes a hstore and returns a single record containing an XML populated with data from the hstore.
Parameter: kvHstore is an hstore
Return: kvhstore converted to xml
Dependency: requires hstore extension
Author: Pratik Gautam
*/
AS
$$

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
                    key as k,
                    value as v
                )
            ) AS xnodes
            FROM
            (select * from each(kvHstore)) AS kvPairs
	    ) AS xnodes
    ) AS xmlagg;

END;
$$
LANGUAGE plpgsql